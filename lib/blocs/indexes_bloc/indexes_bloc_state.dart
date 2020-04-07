import 'package:equatable/equatable.dart';

abstract class IndexesBlocState extends Equatable {
  const IndexesBlocState();
}

class InitialIndexesBlocState extends IndexesBlocState {
  @override
  List<Object> get props => [];
}
