import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FavoritesBlocBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> {
  @override
  FavoritesBlocState get initialState => InitialFavoritesBlocState();

  @override
  Stream<FavoritesBlocState> mapEventToState(
    FavoritesBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
