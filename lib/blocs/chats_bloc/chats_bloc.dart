import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class ChatsBloc extends Bloc<ChatsBlocEvent, ChatsBlocState> {
  User downloadedUser;
  final UserBloc userBloc;
  StreamSubscription compraChatsStreamSubscription , ventaChatsStreamSubscription , _userStreamSubscription;
  final DatabaseRepository databaseRepository;
  bool isUserDownloaded = false;
  List<Chat> compraChats , ventaChats;

  ChatsBloc(this.databaseRepository,this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {

      if(state is UserLoadedState){
          isUserDownloaded = true;

          add(LoadChats(state.user));

          downloadedUser = state.user;

      }
    });
  }



  @override
  ChatsBlocState get initialState => InitialChatsBlocState();

  @override
  Stream<ChatsBlocState> mapEventToState(
    ChatsBlocEvent event,
  ) async* {
    if(event is LoadChats){
      yield* _mapLoadChatsToState(event.user);
    }else if(event is LoadedChats){
      yield* _mapLoadedChatsToState(event.compraChats, event.ventaChats);
    }else if(event is AddChat){
      yield* _mapAddChatToState(event.chat);
    }
  }

  _mapLoadChatsToState(User user) {
    compraChatsStreamSubscription = databaseRepository.getCompraChats(user)
        .listen((list) {
          compraChats  = list;
            add(LoadedChats(compraChats,ventaChats));
        });
    ventaChatsStreamSubscription = databaseRepository.getVentaChats(user)
        .listen((list) {
      ventaChats  = list;
      add(LoadedChats(compraChats,ventaChats));
    });
  }

  Stream<ChatsBlocState> _mapLoadedChatsToState(List<Chat> compraChats, List<Chat> ventaChats) async*{
    yield   ChatsLoaded(compraChats,ventaChats);
  }

  _mapAddChatToState(Chat chat) {
    databaseRepository.addChat(downloadedUser, chat);
  }
}






