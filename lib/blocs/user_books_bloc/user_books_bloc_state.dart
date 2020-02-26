import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class UserBooksBlocState extends Equatable {
  const UserBooksBlocState();
}

class UserBooksLoadedState extends UserBooksBlocState{

  final List<Book> publicados;
  final List<Book> vendidos;

  UserBooksLoadedState(this.publicados, this.vendidos);

  @override
  List<Object> get props => [publicados,vendidos];
}

class UserBooksLoadingState extends UserBooksBlocState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserBooksNotLoadedState extends UserBooksBlocState{
  final String errorMessage;

  UserBooksNotLoadedState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}
