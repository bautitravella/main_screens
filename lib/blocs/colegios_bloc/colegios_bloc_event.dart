import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/ColegiosData.dart';

abstract class ColegiosBlocEvent extends Equatable {
  const ColegiosBlocEvent();
}

class LoadColegios extends ColegiosBlocEvent{
  @override
  List<Object> get props => [];
}

class LoadedColegios extends ColegiosBlocEvent{
  final ColegiosData colegiosData;

  LoadedColegios(this.colegiosData);

  @override
  List<Object> get props => [colegiosData];
}


