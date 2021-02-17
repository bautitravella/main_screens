import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/User.dart';

abstract class ChatsBlocEvent extends Equatable {
  const ChatsBlocEvent();
}

class LoadChats extends ChatsBlocEvent{

  @override
  List<Object> get props => [];
}

class LoadedChats extends ChatsBlocEvent{
  final List<Chat> compraChats , ventaChats;

  LoadedChats(this.compraChats, this.ventaChats);

  @override
  List<Object> get props => [compraChats , ventaChats];

}

class AddChat extends ChatsBlocEvent{
  final Chat chat;
  Function(Chat) function;

  AddChat(this.chat,{this.function});

  @override
  List<Object> get props => [chat,function];


}