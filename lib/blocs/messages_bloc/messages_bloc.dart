import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/chat_roles.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class MessagesBloc extends Bloc<MessagesBlocEvent, MessagesBlocState> {

  final UserBloc userBloc;
  final ChatsBloc chatBloc;
  StreamSubscription messagesSubscription;
  StreamSubscription _userStreamSubscription;
  final DatabaseRepository databaseRepository;
  User downloadedUser;
  bool isUserDownloaded = false;
  bool isChatCreated = false;
  Chat currentChat;

  bool isChatBeenCreated = false;

  MessagesBloc( this.databaseRepository,this.userBloc, this.chatBloc){
    _userStreamSubscription = userBloc.listen((state) {

      if(state is UserLoadedState){
        isUserDownloaded = true;

        //add(LoadChats(state.user));

        downloadedUser = state.user;

      }
    });
  }


  @override
  MessagesBlocState get initialState => InitialMessagesBlocState();

  @override
  Stream<MessagesBlocState> mapEventToState(
    MessagesBlocEvent event,
  ) async* {
    if(event is LoadMessages){
      yield* _mapLoadMessagesToState(event.chat,event.chatRole);
    }else if(event is LoadedMessages){
      yield* _mapLoadedMessagesToState(event.messages);
    }else if(event is AddMessage){
      yield* _mapAddMessageToState(event.message,event.chatRole);
    }else if(event is SolicitarCompra){
      yield* _mapSolicitarCompraToState(event.chat);
    }else if(event is AceptarSolicitudDeCompra){
      yield* _mapAceptarSolicitudToState(event.chat);
    }else if(event is RechazarSolicitudDeCompra){
      yield* _mapRechazarSolicitudToState(event.chat);
    }
  }

  Stream<MessagesBlocState> _mapLoadMessagesToState(Chat chat,ChatRole chatRole) async* {
    //agregar que cuando te bajas los mensajes ya se tildeee como ya leiste el mensaje
    yield MessagesLoading();
    if (downloadedUser != null) {
      currentChat = chat;
      if (chat.uid != null) {
        isChatCreated = true;
        messagesSubscription =
            databaseRepository.getMessagesWithUid(chat, downloadedUser).listen((
                messages) {
              print("MESSAGES ================= $messages");
              databaseRepository.updateLeidoByField(chat, chatRole);
              add(LoadedMessages(messages));
            });
      } else {
        yield MessagesLoading();
        chat.addCompradorInformation(downloadedUser);
        Chat chatWithUid = await databaseRepository.getChatUid(
            chat, downloadedUser);
        if (chatWithUid != null) {
          currentChat = chatWithUid;
          print("MessagesBloc LoadMessages chatWithUid != null. Chat = " +
              chatWithUid.toString());
          isChatCreated = true;
          messagesSubscription =
              databaseRepository.getMessagesWithUid(chatWithUid, downloadedUser)
                  .listen((messages) {
                databaseRepository.updateLeidoByField(currentChat, chatRole);
                add(LoadedMessages(messages));
              });
        } else {
          print(
              "MessagesBloc LoadMessages chatWithUid == NULL. isChatCreated setting to false");
          yield PotentialNewMessage();
          isChatCreated = false;
        }
      }
    } else {
      print("MessagesBloc LoadMessages NO SE CARGO EL USUARIO");
    }
  }

  Stream<MessagesBlocState> _mapLoadedMessagesToState(List<Message> messages) async* {
    yield MessagesLoaded(messages);
  }

  _mapAddMessageToState(Message message,ChatRole chatRole) {
    //message.email = downloadedUser.email;
    if(isChatCreated){
      isChatBeenCreated = false;
      if(chatRole == ChatRole.COMPRADOR){
        message.email = currentChat.vendedorEmail;
        message.title = currentChat.compradorNombre +' - '+currentChat.nombreLibro;
      }else{
        message.email = currentChat.compradorEmail;
        message.title = currentChat.vendedorNombre + ' - '+currentChat.nombreLibro;
      }
      databaseRepository.sendMessage( currentChat , downloadedUser , message );
      databaseRepository.updateLastMessage(currentChat,message,chatRole);
    }else{ // esta parte del if es para cuando todavia no hubo ningun chat
      if(isChatBeenCreated == false){
        isChatBeenCreated = true;
        chatBloc.add(AddChat(currentChat));// aca utilizamos el currentChat porq ya asumimos que alguien hizo un LoadChats

      }
      add(LoadMessages(currentChat,chatRole));
      add(AddMessage(message,chatRole));
    }
  }

  _mapSolicitarCompraToState(Chat chat) {//Por definicion si alguien esta solicitando una compra el ChatRole es COMPRADOR
    if(isChatCreated){
      isChatBeenCreated = false;
      databaseRepository.solicitarCompra(currentChat);
    }else{
      if(isChatBeenCreated == false){
       isChatBeenCreated = true;
       chatBloc.add(AddChat(currentChat));
       add(LoadMessages(currentChat,ChatRole.COMPRADOR));
       add(SolicitarCompra(chat));
      }
    }
  }

  _mapAceptarSolicitudToState(Chat chat) {
    databaseRepository.aceptarSolicitudDeCompra(chat);
  }

  _mapRechazarSolicitudToState(Chat chat) {
    databaseRepository.rechazarSolicitudDeCompra(chat);
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    messagesSubscription.cancel();
    return super.close();
  }


}
