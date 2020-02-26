import 'package:equatable/equatable.dart';

abstract class ChatsBlocState extends Equatable {
  const ChatsBlocState();
}

class InitialChatsBlocState extends ChatsBlocState {
  @override
  List<Object> get props => [];
}
