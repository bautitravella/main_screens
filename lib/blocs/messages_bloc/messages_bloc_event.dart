import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/chat_roles.dart';

abstract class MessagesBlocEvent extends Equatable {
  const MessagesBlocEvent();
}

class LoadMessages extends MessagesBlocEvent{
  final Chat chat;
  final ChatRole chatRole;

  LoadMessages(this.chat, this.chatRole);

  @override
  List<Object> get props => [chat];
}

class LoadingMessages extends MessagesBlocEvent{
  @override
  List<Object> get props => [];
}

class LoadedMessages extends MessagesBlocEvent{
  final List<Message> messages;

  LoadedMessages(this.messages);

  @override
  List<Object> get props => [messages];
}

class UnloadMessages extends MessagesBlocEvent{
  @override
  List<Object> get props => [];
}



class AddMessage extends MessagesBlocEvent{
  final Message message;
  final ChatRole chatRole;

  AddMessage(this.message, this.chatRole);

  @override
  List<Object> get props => [message];

}

class SolicitarCompra extends MessagesBlocEvent{
  final Chat chat;

  SolicitarCompra(this.chat);

  @override
  List<Object> get props => [chat];
}

class AceptarSolicitudDeCompra extends MessagesBlocEvent{
  final Chat chat;

  AceptarSolicitudDeCompra(this.chat);

  @override
  List<Object> get props => [chat];
}

class RechazarSolicitudDeCompra extends MessagesBlocEvent{
  final Chat chat;

  RechazarSolicitudDeCompra(this.chat);

  @override
  List<Object> get props => [chat];
}

class CancelarSolicitudDeCompra extends MessagesBlocEvent{
  final Chat chat;

  CancelarSolicitudDeCompra(this.chat);

  @override
  List<Object> get props => [chat];
}


