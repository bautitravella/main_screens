import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/database_repository.dart';
import './bloc.dart';

//class DatabaseBloc extends Bloc<DatabaseBlocEvent, DatabaseBlocState> {
//
//  final DatabaseRepository databaseRepository;
//  StreamSubscription _booksStreamSubscription;
//
//  DatabaseBloc(this.databaseRepository);
//
//  @override
//  DatabaseBlocState get initialState => LoadingState();
//
//  @override
//  Stream<DatabaseBlocState> mapEventToState(
//    DatabaseBlocEvent event,
//  ) async* {
//    if(event is LoadBooks){
//      yield*  _mapLoadBooksToState();
//    }else if(event is LoadUserInfo){
//      yield* _mapLoadUserInfoToState();
//    }else if(event is BooksLoaded){
//      yield*  _mapBooksLoadedToState(event);
//    }
//  }
//
//  Stream<DatabaseBlocState> _mapLoadUserInfoToState() {
//
//  }
//
//  Stream<DatabaseBlocState> _mapLoadBooksToState() {
//    _booksStreamSubscription?.cancel();
//    _booksStreamSubscription = databaseRepository.getAllBooks().listen((books) {add(BooksLoaded(books)); });
//  }
//
//  Stream<DatabaseBlocState> _mapBooksLoadedToState(BooksLoaded booksLoaded) async*{
//    yield BooksLoadedState(booksLoaded.books);
//
//  }
//
//
//
//
//}

