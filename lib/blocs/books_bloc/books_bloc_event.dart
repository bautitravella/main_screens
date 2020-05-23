import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/home_hub/generic_booklist_screen.dart';

abstract class BooksBlocEvent extends Equatable {
  const BooksBlocEvent();
}

class LoadBooksByUser extends BooksBlocEvent{
  final ListType listType;

  LoadBooksByUser(this.listType);

  @override
  List<Object> get props => [listType];
}

class LoadBooksByChild extends BooksBlocEvent{

  final Hijo hijo;
  final ListType listType;

  LoadBooksByChild(this.listType,this.hijo);

  @override
  List<Object> get props => [listType,hijo];
}

class LoadBooksByInstituition extends BooksBlocEvent{
  final String instituition;
  final String parameter;
  final ListType listType;

  LoadBooksByInstituition(this.instituition, this.listType,this.parameter);
  @override
  List<Object> get props => [instituition,listType,parameter];

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

