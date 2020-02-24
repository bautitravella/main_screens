import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';


class BooksBloc extends Bloc<BooksBlocEvent, BooksBlocState> {

  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  StreamSubscription _booksStreamSubscription;
  StreamSubscription _userStreamSubscription;

  BooksBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) { 
      if(state is UserLoadedState){
        add(UserUpdated(state.user));
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
    _booksStreamSubscription?.cancel();
    _booksStreamSubscription = databaseRepository.getAllBooks().listen((books) {add(BooksLoaded(books)); });
  }

  Stream<BooksBlocState> _mapBooksLoadedToState(BooksLoaded booksLoaded) async*{
    yield BooksLoadedState(booksLoaded.books);

  }

  Stream<BooksBlocState> _mapAddBookToState(AddBook event) async* {
    try {
      yield UploadingBook();
      final nothing = await databaseRepository.addNewBook(event.book);
      yield UploadedBook(nothing);
    }catch(e){
      yield ErrorUploadingBook(e.toString());
    }
  }

  @override
  Future<void> close(){
    _booksStreamSubscription?.cancel();
    return super.close();
  }

  Stream<BooksBlocState> _mapUserUpdatedToState(User user) {
    databaseRepository.reFilterBooks(user);
  }


}
