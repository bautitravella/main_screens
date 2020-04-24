import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/database_repository.dart';
import './bloc.dart';

class IndividualDocumentsBloc extends Bloc<IndividualDocumentsBlocEvent, IndividualDocumentsBlocState> {

  final DatabaseRepository databaseRepository;
  StreamSubscription documentStreamSubscription;

  IndividualDocumentsBloc(this.databaseRepository);



  @override
  IndividualDocumentsBlocState get initialState => InitialIndividualDocumentsBlocState();

  @override
  Stream<IndividualDocumentsBlocState> mapEventToState(
    IndividualDocumentsBlocEvent event,
  ) async* {
    if(event is GetBook){
       _mapGetBookToState(event.uid);
    }else if(event is BookDownloaded){
      yield* _mapBookDownloadedToState(event.book);
    } else if(event is GetUser){
      yield* _mapGetUserToState(event.email);
    }
  }

  _mapGetBookToState(String uid) {
      documentStreamSubscription = databaseRepository.getBook(uid).listen((book) {
            add(BookDownloaded(book));
      });
  }

  Stream<IndividualDocumentsBlocState> _mapBookDownloadedToState(Book book) async*{
    yield BookDownloadedState(book);
  }

  _mapGetUserToState(String email) {
    documentStreamSubscription = databaseRepository.getUserInfo(email).listen((user) {
      add(UserDownloaded(user));
    });
  }



  Stream<IndividualDocumentsBlocState> _mapUserDownloadedToState(User user) async*{
    yield UserDownloadedState(user);
  }
}

