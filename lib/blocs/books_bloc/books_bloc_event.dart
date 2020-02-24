import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/User.dart';

abstract class BooksBlocEvent extends Equatable {
  const BooksBlocEvent();
}

class LoadUserBooks extends BooksBlocEvent{
  final User user;

  LoadUserBooks(this.user);

  @override
  List<Object> get props => [];


}

class BooksLoaded extends BooksBlocEvent{

  final List<Book> books;

  BooksLoaded(this.books);

  @override
  List<Object> get props => [books];

}

class AddBook extends BooksBlocEvent{
  final Book book;

  AddBook(this.book);

  @override
  List<Object> get props => [book];
}

class UserUpdated extends BooksBlocEvent{
  final User user;

  UserUpdated(this.user);

  @override
  List<Object> get props => [user];
}

