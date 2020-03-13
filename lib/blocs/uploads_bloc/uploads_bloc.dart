import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class UploadsBloc extends Bloc<UploadsBlocEvent, UploadsBlocState> {
  final DatabaseRepository databaseRepository;

  UploadsBloc(this.databaseRepository);

  @override
  UploadsBlocState get initialState => InitialUploadsBlocState();

  @override
  Stream<UploadsBlocState> mapEventToState(
    UploadsBlocEvent event,
  ) async* {
    if (event is EditBook) {
      yield* _mapEditBookToState(event.book);
    }else if(event is EditBookImages){
     yield* _mapEditBookImagesToState(event.book);
    } else if(event is EditBookInfo){
      yield* _mapEditBookInfoToState(event.book);
    }else if (event is EditedBookReady) {
      yield* _mapEditedBookToState();
    }else if(event is ErrorEditing){
      yield* _mapErrorEditingToState(event.errorMessage);
    }
  }

  Stream<UploadsBlocState> _mapEditBookToState(Book book) async* {
    yield EditingState();
    databaseRepository
        .editBook(book)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())));
  }

  Stream<UploadsBlocState> _mapEditedBookToState() async* {
    yield BookEdited();
  }

  Stream<UploadsBlocState> _mapErrorEditingToState(String errorMessage) async*{
    yield FailedToEdit(errorMessage);
  }

  Stream<UploadsBlocState> _mapEditBookImagesToState(Book book) async* {
    yield EditingState();
    databaseRepository
        .editBookImages(book)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())));
  }

  Stream<UploadsBlocState> _mapEditBookInfoToState(Book book) async* {
    yield EditingState();
    databaseRepository
        .editBookInfo(book)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())));
  }
}
