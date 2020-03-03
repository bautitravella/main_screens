import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class SearchBlocState extends Equatable {
  const SearchBlocState();
}

class InitialSearchBlocState extends SearchBlocState {
  @override
  List<Object> get props => [];
}

class SearchBooksLoading extends SearchBlocState{
  @override
  List<Object> get props => [];
}
class SearchBooksLoaded extends SearchBlocState{
  final List<Book> booksList;

  SearchBooksLoaded(this.booksList);

  @override
  List<Object> get props => [booksList];
}
