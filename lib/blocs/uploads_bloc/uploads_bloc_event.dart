import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';
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
class EditUserProfile extends UploadsBlocEvent{
  final User user;

  EditUserProfile(this.user);

  @override
  List<Object> get props => [user];
}
class EditUserInfo extends UploadsBlocEvent{
  final User user;

  EditUserInfo(this.user);

  @override
  List<Object> get props => [user];
}
class EditUserImage extends UploadsBlocEvent{
  final User user;

  EditUserImage(this.user);

  @override
  List<Object> get props => [user];
}
class EditedUserProfile extends UploadsBlocEvent{

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
class AddSchool extends UploadsBlocEvent{
  final String schoolName,userEmail;
  final List<String> materiasList;
  AddSchool( this.schoolName,this.materiasList, this.userEmail);

  @override
  List<Object> get props => [schoolName,userEmail];
}
