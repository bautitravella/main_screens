import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';

abstract class MessagesBlocState extends Equatable {
  const MessagesBlocState();
}

class InitialMessagesBlocState extends MessagesBlocState {
  @override
  List<Object> get props => [];
}

class MessagesLoading extends MessagesBlocState{
  @override
  List<Object> get props => [];
}

class MessagesLoaded extends MessagesBlocState{
  final List<Message> messages;
  final Chat chat;

  MessagesLoaded(this.messages,this.chat);

  @override
  List<Object> get props => [messages,chat];
}

class MessagesErrorLoading extends MessagesBlocState{
  final String errorMessage;

  MessagesErrorLoading(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PotentialNewMessage extends MessagesBlocState{
  @override
  List<Object> get props => [];
}


