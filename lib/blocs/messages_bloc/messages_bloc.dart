import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/User.dart';
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
      yield* _mapLoadMessagesToState(event.chat);
    }else if(event is LoadedMessages){
      yield* _mapLoadedMessagesToState(event.messages);
    }else if(event is AddMessage){
      yield* _mapAddMessageToState(event.message);
    }
  }

  _mapLoadMessagesToState(Chat chat) async {
    if(downloadedUser != null) {
      currentChat = chat;
      if (chat.uid != null) {
        isChatCreated = true;
        messagesSubscription =
            databaseRepository.getMessagesWithUid(chat, downloadedUser).listen((
                messages) {
              add(LoadedMessages(messages));
            });
      } else {
        Chat chatWithUid = await databaseRepository.getChatUid(
            chat, downloadedUser);
        if (chatWithUid != null) {
          isChatCreated = true;
          messagesSubscription =
              databaseRepository.getMessagesWithUid(chatWithUid, downloadedUser)
                  .listen((messages) {
                add(LoadedMessages(messages));
              });
        } else {
            isChatCreated = false;
        }
      }
    }
    print("MessagesBloc NO SE CARGO EL USUARIO");
  }

  Stream<MessagesBlocState> _mapLoadedMessagesToState(List<Message> messages) async* {
    yield MessagesLoaded(messages);
  }

  _mapAddMessageToState(Message message) {
    if(isChatCreated){
      databaseRepository.addChat(downloadedUser, currentChat);
    }else{
      chatBloc.add(AddChat(currentChat));
      add(LoadMessages(currentChat));
      add(AddMessage(message));
    }
  }

}
