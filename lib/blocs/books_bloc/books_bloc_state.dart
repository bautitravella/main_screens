import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class BooksBlocState extends Equatable {
  const BooksBlocState();
}

class LoadingBookState extends BooksBlocState{
  @override
  List<Object> get props => [];
}

class LoadingBookErrorState extends BooksBlocState{
  @override
  List<Object> get props => [];

}

class BooksLoadedState extends BooksBlocState {

  final List<Book> books;

  BooksLoadedState(this.books);

  @override
  List<Object> get props => [books];
}

class UploadingBook extends BooksBlocState{
  @override
  List<Object> get props => [];
}

class UploadedBook extends BooksBlocState{
  UploadedBook(void nothing);

  @override
  List<Object> get props => [];
}

class ErrorUploadingBook extends BooksBlocState{

  final String errorMessage;

  ErrorUploadingBook(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}