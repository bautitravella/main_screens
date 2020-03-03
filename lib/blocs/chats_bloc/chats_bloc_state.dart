import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/message_model.dart';

abstract class ChatsBlocState extends Equatable {
  const ChatsBlocState();
}

class InitialChatsBlocState extends ChatsBlocState {
  @override
  List<Object> get props => [];
}

class ChatsLoading extends ChatsBlocState{
  @override
  List<Object> get props => [];
}

class ChatsLoaded extends ChatsBlocState{
  final List<Chat> chatsVentaList;
  final List<Chat> chatsCompraList;

  ChatsLoaded(this.chatsCompraList,this.chatsVentaList);

  @override
  List<Object> get props => [chatsCompraList,chatsVentaList];
}

class ChatsErrorLoading extends ChatsBlocState{

  final String errorMessage;

  ChatsErrorLoading(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

