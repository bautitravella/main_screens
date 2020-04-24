import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class SimilarBooksBlocEvent extends Equatable {
  const SimilarBooksBlocEvent();
}

class GetSimilarBooks extends SimilarBooksBlocEvent{

  final Book book;

  GetSimilarBooks(this.book);


  @override
  List<Object> get props => [];
}

class SimilarBooksDownloaded extends SimilarBooksBlocEvent{
  final List<Book> booksList;

  SimilarBooksDownloaded(this.booksList);

  @override
  List<Object> get props => [];

}
