import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class UploadsBlocEvent extends Equatable {
  const UploadsBlocEvent();
}

class EditBook extends UploadsBlocEvent{
  final Book book;

  EditBook(this.book);

  @override
  List<Object> get props => [book];
}

class EditBookInfo extends UploadsBlocEvent{
  final Book book;

  EditBookInfo(this.book);

  @override
  List<Object> get props => [book];
}
class EditBookImages extends UploadsBlocEvent{
  final Book book;

  EditBookImages(this.book);

  @override
  List<Object> get props => [book];
}


class EditedBookReady extends UploadsBlocEvent{


  EditedBookReady();

  @override
  List<Object> get props => [];
}

class ErrorEditing extends UploadsBlocEvent{
  final String errorMessage;

  ErrorEditing(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}

class ResetEvent extends UploadsBlocEvent{
  @override
  List<Object> get props => [];
}
