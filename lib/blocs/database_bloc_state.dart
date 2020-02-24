import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

abstract class DatabaseBlocState extends Equatable {
  const DatabaseBlocState();
}

//class InitialDatabaseBlocState extends DatabaseBlocState {
//  @override
//  List<Object> get props => [];
//}
//
//class LoadingState extends DatabaseBlocState{
//  @override
//  List<Object> get props => [];
//}
//
//class LoadingErrorState extends DatabaseBlocState{
//  @override
//  List<Object> get props => [];
//
//}
//
//class BooksLoadedState extends DatabaseBlocState{
//
//  final List<Book> books;
//
//  BooksLoadedState(this.books);
//
//  @override
//  List<Object> get props => [books];
//}
//
//class UserLoaded extends  DatabaseBlocState{
//
//  final User user;
//
//  const UserLoaded(this.user);
//
//  @override
//  List<Object> get props => [user];
//}
