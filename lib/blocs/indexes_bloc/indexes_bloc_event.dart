import 'package:equatable/equatable.dart';

abstract class IndexesBlocEvent extends Equatable {
  const IndexesBlocEvent();
}

class LoadIndexes extends IndexesBlocEvent{
  @override
  List<Object> get props => [];
}

class UnloadIndexes extends IndexesBlocEvent{
  @override
  List<Object> get props => [];
}
