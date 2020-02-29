import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MessagesBlocBloc extends Bloc<MessagesBlocEvent, MessagesBlocState> {
  @override
  MessagesBlocState get initialState => InitialMessagesBlocState();

  @override
  Stream<MessagesBlocState> mapEventToState(
    MessagesBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
