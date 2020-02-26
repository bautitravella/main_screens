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
  bool timeouted = false;

  UserBooksBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {
      if(state is UserLoadedState){
        if(isUserDownloaded == false){
          add(LoadUserBooksEvent(state.user));
        }else{
          add(UserUpdatedEvent(state.user));
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
    _booksStreamSubscription?.cancel();
    //todo implement que te devuelva dos colecciones en vez de solo una ("books")
    print("ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print("ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    _booksStreamSubscription = databaseRepository.getUserBooks(user).listen((books) {add(UserBooksLoadedEvent(books)); });
  }


  Stream<UserBooksBlocState> _mapUserBooksLoadedToState(List<Book> books) async*{
    yield UserBooksLoadedState(books,books);
  }

  Stream<UserBooksBlocState> _mapUserUpdatedToState(User user) {
    databaseRepository.reFilterUserBooks(user);
  }

  @override
  Future<void> close() {
    _booksStreamSubscription.cancel();
    _userStreamSubscription.cancel();
    return super.close();
  }




}
