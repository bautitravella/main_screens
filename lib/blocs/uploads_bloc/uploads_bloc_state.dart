import 'package:equatable/equatable.dart';

abstract class UploadsBlocState extends Equatable {
  const UploadsBlocState();
}

class InitialUploadsBlocState extends UploadsBlocState {
  @override
  List<Object> get props => [];
}

class BookEdited extends UploadsBlocState{
  @override
  List<Object> get props => [];
}

class UserEdited extends UploadsBlocState{
  @override
  List<Object> get props => [];
}

class FailedToEdit extends UploadsBlocState{
  final String errorMessage;

  FailedToEdit(this.errorMessage);


  @override
  List<Object> get props => throw UnimplementedError();
}

class EditingState extends UploadsBlocState{
  @override
  List<Object> get props => [];
}
