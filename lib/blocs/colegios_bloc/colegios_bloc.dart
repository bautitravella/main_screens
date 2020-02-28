import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/Models/Colegio.dart';
import './bloc.dart';

class ColegiosBloc extends Bloc<ColegiosBlocEvent, ColegiosBlocState> {
  final DatabaseRepository databaseRepository;
  StreamSubscription colegiosStreamSubscriptions;
  bool colegiosLoaded = false;

  ColegiosBloc(this.databaseRepository);

  @override
  ColegiosBlocState get initialState => InitialColegiosBlocState();

  @override
  Stream<ColegiosBlocState> mapEventToState(
    ColegiosBlocEvent event,
  ) async* {
    if(event is LoadColegios){
      yield* _mapLoadColegiosToState();
    }else if(event is LoadedColegios){
      yield* _mapLoadedColegiosToState(event.colegiosData);
    }
  }

  _mapLoadColegiosToState() {
    if(colegiosLoaded == false) {
      colegiosStreamSubscriptions =
          databaseRepository.getColegios().listen((colegios) =>
              add(LoadedColegios(colegios)));
    }
  }

  Stream<ColegiosBlocState> _mapLoadedColegiosToState(ColegiosData colegiosData)  async*{

    yield ColegiosLoaded(colegiosData);
  }

@override
  Future<void> close() {
    colegiosStreamSubscriptions.cancel();
    return super.close();
  }

}
