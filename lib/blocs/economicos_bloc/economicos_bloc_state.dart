import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class EconomicosBlocState extends Equatable {
  const EconomicosBlocState();
}

class InitialEconomicosBlocState extends EconomicosBlocState {
  @override
  List<Object> get props => [];
}


class LoadingEconomicosBooksState extends EconomicosBlocState{
  @override
  List<Object> get props => [];
}

class LoadingEconomicosBooksErrorState extends EconomicosBlocState{
  @override
  List<Object> get props => [];

}

class EconomicosBooksLoadedState extends EconomicosBlocState {

  final List<Book> books;

  EconomicosBooksLoadedState(this.books);

  @override
  List<Object> get props => [books];
}

