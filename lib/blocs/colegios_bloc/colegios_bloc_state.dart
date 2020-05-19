import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/ColegiosData.dart';

abstract class ColegiosBlocState extends Equatable {
  const ColegiosBlocState();
}



class ColegiosLoading extends ColegiosBlocState{

  @override
  List<Object> get props => [];
}

class ColegiosLoaded extends ColegiosBlocState{

  final ColegiosData colegiosData;

  ColegiosLoaded(this.colegiosData);

  @override
  List<Object> get props => [colegiosData];
}

class ColegiosErrorLoading extends ColegiosBlocState{
  final String errorMessage;

  ColegiosErrorLoading(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}