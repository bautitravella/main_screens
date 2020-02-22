import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DatabaseBlocBloc extends Bloc<DatabaseBlocEvent, DatabaseBlocState> {
  @override
  DatabaseBlocState get initialState => InitialDatabaseBlocState();

  @override
  Stream<DatabaseBlocState> mapEventToState(
    DatabaseBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
