import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();
}

class SearchBooks extends SearchBlocEvent{
  final List<String> list;

  SearchBooks(this.list);

  @override
  List<Object> get props => [list];
}

class LoadedSearchBooks extends SearchBlocEvent{
  final List<Book> booksList;

  LoadedSearchBooks(this.booksList);

  @override
  List<Object> get props => [booksList];
}