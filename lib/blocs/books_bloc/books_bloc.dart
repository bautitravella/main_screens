import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';


class BooksBloc extends Bloc<BooksBlocEvent, BooksBlocState> {

  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  StreamSubscription _booksStreamSubscription;
  StreamSubscription _userStreamSubscription;
  bool isUserDownloaded = false;
  bool timeouted = false;
  User downloadedUser;

  BooksBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {
      if(state is UserLoadedState){
        if(isUserDownloaded == false){
          isUserDownloaded = true;
          add(LoadUserBooks());
          downloadedUser = state.user;
        }else{
          add(UserUpdated(state.user));
        }

      }
    });
  }


  @override
  BooksBlocState get initialState => LoadingBookState();

  @override
  Stream<BooksBlocState> mapEventToState(
    BooksBlocEvent event,
  ) async* {
    if(event is LoadUserBooks){
      yield*  _mapLoadUserBooksToState();
    }else if(event is BooksLoaded){
      yield*  _mapBooksLoadedToState(event);
    }else if(event is AddBook){
      yield*  _mapAddBookToState(event);
    }else if(event is UserUpdated){
      yield* _mapUserUpdatedToState(event.user);
    }
  }



  Stream<BooksBlocState> _mapLoadUserBooksToState() {

    if(isUserDownloaded == false){
      if(downloadedUser != null){
        _booksStreamSubscription?.cancel();

        _booksStreamSubscription = databaseRepository.getUserRecomendationBooks(downloadedUser).listen((books) {add(BooksLoaded(books)); });
      }

    }else{
      _booksStreamSubscription?.cancel();

      _booksStreamSubscription = databaseRepository.getUserRecomendationBooks(downloadedUser).listen((books) {add(BooksLoaded(books)); });
    }

  }

  Stream<BooksBlocState> _mapBooksLoadedToState(BooksLoaded booksLoaded) async*{
    yield BooksLoadedState(booksLoaded.books);

  }

  Stream<BooksBlocState> _mapAddBookToState(AddBook event) async* {
    try {
      yield UploadingBook();
      UserBlocState userBlocState = userBloc.state;
      if(userBlocState is UserLoadedState){
        User user = userBlocState.user;
        final nothing = await databaseRepository.addNewBook(event.book,user).timeout(Duration(seconds: 30),onTimeout: smt);
        if(!timeouted){
          yield UploadedBook(nothing);
        }else{
          print('ES ACA1');
          yield ErrorUploadingBook("Hubo algun problema subiendo el libro");
          timeouted = false;
        }


      }else{
        print('ES ACA2');
        yield ErrorUploadingBook("NO user information");
      }

    }catch(e){
      print('ES ACA3.Error = ${e.toString()}');
      yield ErrorUploadingBook(e.toString());
    }
  }



  Stream<BooksBlocState> _mapUserUpdatedToState(User user) {
    databaseRepository.reFilterBooks(user);
  }

   smt() {
    timeouted = true;
  }

  Stream<BooksBlocState> smt2() async*{
    yield UploadedBook("hola");
  }

  @override
  Future<void> close(){
    _booksStreamSubscription?.cancel();
    return super.close();
  }
}
