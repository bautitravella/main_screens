import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';

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

  AddMessage(this.message);

  @override
  List<Object> get props => [message];

}


