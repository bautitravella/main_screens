import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/chat_roles.dart';

abstract class MessagesBlocEvent extends Equatable {
  const MessagesBlocEvent();
}

class LoadMessages extends MessagesBlocEvent{
  final Chat chat;

  LoadMessages(this.chat);

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

class AddMessage extends MessagesBlocEvent{
  final Message message;
  final ChatRole chatRole;

  AddMessage(this.message, this.chatRole);

  @override
  List<Object> get props => [message];

}


