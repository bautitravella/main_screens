import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();
}

class SearchBooks extends SearchBlocEvent{
  final String search;

  SearchBooks(this.search);

  @override
  List<Object> get props => [search];
}

class LoadedSearchBooks extends SearchBlocEvent{


  LoadedSearchBooks();

  @override
  List<Object> get props => [];
}