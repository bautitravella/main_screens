import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

abstract class UserBooksBlocEvent extends Equatable {
  const UserBooksBlocEvent();
}

class LoadUserBooksEvent extends UserBooksBlocEvent{
  final User user;

  LoadUserBooksEvent(this.user);

  @override
  List<Object> get props => [user];


}

class UserBooksLoadedEvent extends UserBooksBlocEvent{

  final List<Book> books;

  UserBooksLoadedEvent(this.books);

  @override
  List<Object> get props => [books];

}

//class AddBook extends UserBooksBlocEvent{
//  final Book book;
//
//  AddBook(this.book);
//
//  @override
//  List<Object> get props => [book];
//}

class UserUpdatedEvent extends UserBooksBlocEvent{
  final User user;

  UserUpdatedEvent(this.user);

  @override
  List<Object> get props => [user];
}