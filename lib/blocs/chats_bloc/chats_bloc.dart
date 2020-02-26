import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChatsBlocBloc extends Bloc<ChatsBlocEvent, ChatsBlocState> {
  @override
  ChatsBlocState get initialState => InitialChatsBlocState();

  @override
  Stream<ChatsBlocState> mapEventToState(
    ChatsBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
