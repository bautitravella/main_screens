import 'package:equatable/equatable.dart';

abstract class DatabaseBlocState extends Equatable {
  const DatabaseBlocState();
}

class InitialDatabaseBlocState extends DatabaseBlocState {
  @override
  List<Object> get props => [];
}
