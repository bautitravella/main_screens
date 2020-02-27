import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/books_bloc/books_bloc_event.dart';
import 'package:flutterui/blocs/database_repository.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc_state.dart';
import './bloc.dart';

class UserBooksBloc extends Bloc<UserBooksBlocEvent, UserBooksBlocState> {

  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  StreamSubscription _booksStreamSubscription;
  StreamSubscription _userStreamSubscription;
  bool isUserDownloaded = false;
  User downloadedUser;
  bool timeouted = false;

  UserBooksBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {

      if(state is UserLoadedState){
        if(isUserDownloaded == false){
          isUserDownloaded = true;

          add(LoadUserBooksEvent(state.user));

          downloadedUser = state.user;
        }else{
          add(UserUpdatedEvent (state.user));
        }

      }
    });

  }

  @override
  UserBooksBlocState get initialState => UserBooksLoadingState();

  @override
  Stream<UserBooksBlocState> mapEventToState(
    UserBooksBlocEvent event,
  ) async* {
   if(event is LoadUserBooksEvent){
     yield* _mapLoadUserBooksToState(event.user);
   }else if(event is UserBooksLoadedEvent){
     yield* _mapUserBooksLoadedToState(event.books);
   }else if(event is UserUpdatedEvent){
     yield* _mapUserUpdatedToState(event.user);
   }
  }

  Stream<UserBooksBlocState> _mapLoadUserBooksToState(User user) {

    if(isUserDownloaded == false){
      if(downloadedUser != null){
        _booksStreamSubscription?.cancel();
        _booksStreamSubscription = databaseRepository.getUserBooks(user).listen((books) {add(UserBooksLoadedEvent(books)); });
      }

    }else{
      _booksStreamSubscription?.cancel();
      _booksStreamSubscription = databaseRepository.getUserBooks(user).listen((books) {add(UserBooksLoadedEvent(books)); });
    }
  }


  Stream<UserBooksBlocState> _mapUserBooksLoadedToState(List<Book> books) async*{
    List<List<Book>> booksList = separateInPublicadosYVendidos(books);
    yield UserBooksLoadedState(booksList[0],booksList[1]);


  }

  Stream<UserBooksBlocState> _mapUserUpdatedToState(User user) {
    databaseRepository.reFilterUserBooks(user);
  }

  List<List<Book>> separateInPublicadosYVendidos(List<Book> books){
    List<List<Book>> booksList = List(2);
    booksList[0] = [];
    booksList[1] = [];
    for(Book book in books){
      if(book.vendido == false) booksList[0].add(book); /// En la primer posicion de la lista se guardaran los libros publicados
      if(book.vendido == true) booksList[1].add(book); /// En la segunda los vendidos
    }
    return booksList;
  }

  @override
  Future<void> close() {
    _booksStreamSubscription.cancel();
    _userStreamSubscription.cancel();
    return super.close();
  }




}
