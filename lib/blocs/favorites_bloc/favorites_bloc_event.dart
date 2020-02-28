import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

abstract class FavoritesBlocEvent extends Equatable {
  const FavoritesBlocEvent();
}

class AddBookToFavorites extends FavoritesBlocEvent{
  final String uid;

  AddBookToFavorites(this.uid);

  @override
  List<Object> get props => [uid];
}

class LoadFavoriteBooks extends FavoritesBlocEvent{
  final User user;

  LoadFavoriteBooks(this.user);

  @override
  List<Object> get props => [user];
}

class FavoriteBooksLoadedEvent extends FavoritesBlocEvent{
  final List<Book> books;

  FavoriteBooksLoadedEvent(this.books);

  @override
  List<Object> get props => [books];

}

class RemoveBookFromFavorites extends FavoritesBlocEvent{
  final Book book;

  RemoveBookFromFavorites(this.book);

  @override
  // TODO: implement props
  List<Object> get props => [book];
}
