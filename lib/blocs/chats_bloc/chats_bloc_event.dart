import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/User.dart';

abstract class ChatsBlocEvent extends Equatable {
  const ChatsBlocEvent();
}

class LoadChats extends ChatsBlocEvent{
  final User user;

  LoadChats(this.user);

  @override
  List<Object> get props => [user];
}

class LoadedChats extends ChatsBlocEvent{
  final List<Chat> compraChats , ventaChats;

  LoadedChats(this.compraChats, this.ventaChats);

  @override
  List<Object> get props => [compraChats , ventaChats];

}

class AddChat extends ChatsBlocEvent{
  final Chat chat;

  AddChat(this.chat);

  @override
  List<Object> get props => [chat];


}