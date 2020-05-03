import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui/Models/book.dart';

abstract class SimilarBooksBlocState extends Equatable {
  const SimilarBooksBlocState();
}

class InitialSimilarBooksBlocState extends SimilarBooksBlocState {
  @override
  List<Object> get props => [];
}

class SimilarBooksDownloadedState extends SimilarBooksBlocState{
  final List<Book> booksList;

  SimilarBooksDownloadedState(this.booksList);

  @override
  List<Object> get props => [booksList];
}
