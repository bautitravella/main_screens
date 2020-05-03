import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

abstract class IndividualDocumentsBlocEvent extends Equatable {
  const IndividualDocumentsBlocEvent();
}


class GetBook extends IndividualDocumentsBlocEvent{

  final String uid;

  GetBook(this.uid);

  @override
  List<Object> get props => [uid];

}

class BookDownloaded extends IndividualDocumentsBlocEvent{
  final Book book;

  BookDownloaded(this.book);

  @override
  List<Object> get props => [book];
}

class GetUser extends IndividualDocumentsBlocEvent{
  final String email;

  GetUser(this.email);

  @override
  List<Object> get props => [email];
}

class UserDownloaded extends IndividualDocumentsBlocEvent{
  final User user;

  UserDownloaded(this.user);

  @override
  List<Object> get props => [user];
}

