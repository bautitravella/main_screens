import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

abstract class IndividualDocumentsBlocState extends Equatable {
  const IndividualDocumentsBlocState();
}

class InitialIndividualDocumentsBlocState extends IndividualDocumentsBlocState {
  @override
  List<Object> get props => [];
}

class UserDownloadedState extends IndividualDocumentsBlocState{
  final User user;

  UserDownloadedState(this.user);

  @override
  List<Object> get props => [user];
}

class BookDownloadedState extends IndividualDocumentsBlocState{

  final Book book;

  BookDownloadedState(this.book);

  @override
  List<Object> get props => [book];
}
