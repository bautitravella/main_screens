import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class UploadsBloc extends Bloc<UploadsBlocEvent, UploadsBlocState> {
  final DatabaseRepository databaseRepository;
  FirebaseAnalytics analytics = FirebaseAnalytics();

  UploadsBloc(this.databaseRepository);

  @override
  UploadsBlocState get initialState => InitialUploadsBlocState();

  @override
  Stream<UploadsBlocState> mapEventToState(
    UploadsBlocEvent event,
  ) async* {
    if (event is EditBook) {         //------------------BOOKS
      yield* _mapEditBookToState(event.book);
    }else if(event is EditBookImages){
     yield* _mapEditBookImagesToState(event.book);
    } else if(event is EditBookInfo){
      yield* _mapEditBookInfoToState(event.book);
    }else if (event is EditedBookReady) {
      yield* _mapEditedBookToState();
    }else if(event is EditUserProfile){  //--------------USER
      yield* _mapEditUserProfileToState(event.user);
    }else if(event is EditedUserProfile){
      yield* _mapEditedUserProfileToState();
    }else if(event is EditUserInfo){
      yield* _mapEditUserProfileInfoToState(event.user);
    }else if(event is EditUserImage){
      yield* _mapEditUserProfileImageToState(event.user);
    }else if(event is ErrorEditing){  //----------------ERRORS AND RESET
      yield* _mapErrorEditingToState(event.errorMessage);
    }else if(event is ResetEvent){
      yield* _mapResetToState();
    }else if(event is AddSchool){
      yield* _mapAddSchoolToState(event.schoolName,event.materiasList,event.userEmail);
    }
  }

  Stream<UploadsBlocState> _mapEditBookToState(Book book) async* {
    yield EditingState();
    databaseRepository
        .editBook(book)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())))
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editBook",parameters: {"edited": "image && info"});
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
        .catchError((e) => add(ErrorEditing(e.toString())))
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editBook",parameters: {"edited": "info"});
  }

  Stream<UploadsBlocState> _mapEditBookInfoToState(Book book) async* {
    yield EditingState();
    databaseRepository
        .editBookInfo(book)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString()))).whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editBook",parameters: {"edited": "image"});
  }

  Stream<UploadsBlocState> _mapResetToState() async*{
    yield InitialUploadsBlocState();
  }

  Stream<UploadsBlocState> _mapEditUserProfileToState(User user) async*{
    yield EditingState();
    databaseRepository
        .editUser(user)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())))
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editUserProfile",parameters: {"edited": "image && info"});
  }

  Stream<UploadsBlocState> _mapEditUserProfileInfoToState(User user) async*{
    yield EditingState();
    print("Hola llegue hasta _mapEditUserProfileInfoToState");
    databaseRepository
        .editUserInfo(user)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())))
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editUserProfile",parameters: {"edited": "info"});
  }

  Stream<UploadsBlocState> _mapEditUserProfileImageToState(User user) async*{
    yield EditingState();
    databaseRepository
        .editUserImage(user)
        .then((value) => add(EditedBookReady()))
        .catchError((e) => add(ErrorEditing(e.toString())))
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent())));
    analytics.logEvent(name: "editUserProfile",parameters: {"edited": "image"});
  }

  Stream<UploadsBlocState> _mapEditedUserProfileToState() async*{
    yield UserEdited();
  }

  Stream<UploadsBlocState>_mapAddSchoolToState(String schoolName,List<String> materiasList, String userEmail) async*{
    yield EditingState();
    databaseRepository
        .addSchool(schoolName,materiasList, userEmail);
    analytics.logEvent(name: "add_school",parameters: {"school_name": schoolName});
    Future.delayed(Duration(milliseconds: 500)).then((value) => add(ResetEvent()));
  }
}
