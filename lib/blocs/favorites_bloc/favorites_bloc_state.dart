import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class FavoritesBlocState extends Equatable {
  const FavoritesBlocState();
}

class FavoriteBooksLoaded extends FavoritesBlocState{
  final List<Book> books;

  FavoriteBooksLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class FavoriteBooksLoading extends FavoritesBlocState{
  @override
  List<Object> get props => [];
}

class ErrorLoadingFavoriteBooks extends FavoritesBlocState{
  final String errorMessage;

  ErrorLoadingFavoriteBooks(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
