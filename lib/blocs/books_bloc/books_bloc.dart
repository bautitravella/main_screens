import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/home_hub/generic_booklist_screen.dart';


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
          downloadedUser = state.user;
          add(LoadBooksByUser(ListType.recomended));
        }else{
          add(UserUpdated(state.user));
          downloadedUser = state.user;
          add(LoadBooksByUser(ListType.recomended));

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
    if(event is LoadBooksByUser){
      yield*  _mapLoadUserBooksToState(event.listType);
    }else if(event is LoadBooksByChild){
      yield* _mapLoadBooksByChild(event.listType,event.hijo);
    }else if(event is LoadBooksByInstituition){
      yield* _mapLoadBooksByInstituition(event.instituition,event.listType,event.parameter);
    }else if(event is BooksLoaded){
      yield*  _mapBooksLoadedToState(event);
    }else if(event is AddBook){
      yield*  _mapAddBookToState(event);
    }else if(event is UserUpdated){
      yield* _mapUserUpdatedToState(event.user);
    }
  }



  Stream<BooksBlocState> _mapLoadUserBooksToState(ListType listType) async*{
    yield LoadingBookState();
    print("MAPUSERBOOKS 1.0");
    _booksStreamSubscription?.cancel();
      if (downloadedUser != null) {
        switch(listType){
          case ListType.recomended:
            print("MAPUSERBOOKS 2.0");
            _booksStreamSubscription =
                databaseRepository.getUserRecomendationBooks(downloadedUser)
                    .listen((books) {if(books!= null){
                  print("MAPUSERBOOKS 2.1 +" + books.toString());
                  add(BooksLoaded(books));}
                });
            break;
          case ListType.cheapest:
            print("MAPUSERBOOKS 3.0");
            _booksStreamSubscription =
                databaseRepository.getUserCheapBooks(downloadedUser)
                    .listen((books) {if(books!= null){
                  print("MAPUSERBOOKS 3.1");
                  add(BooksLoaded(books));}
                });
        }

    }

  }
  Stream<BooksBlocState> _mapLoadBooksByInstituition(String instituition, ListType listType, String parameter) async*{
    yield LoadingBookState();

    _booksStreamSubscription?.cancel();


    switch(listType){
      case ListType.years:
        _booksStreamSubscription = databaseRepository.getBooksByInstituitionAndYear(instituition,parameter).listen((books) {if(books != null){add(BooksLoaded(books)); }});
        break;
      case ListType.subject:
        _booksStreamSubscription = databaseRepository.getBooksByInstituitionAndSubject(instituition,parameter).listen((books) {if(books != null){add(BooksLoaded(books)); }});
        break;
      case ListType.career:
        _booksStreamSubscription = databaseRepository.getBooksByInstituitionAndCareer(instituition,parameter).listen((books) {if(books != null){add(BooksLoaded(books)); }});
        break;
      case ListType.recomended:
        _booksStreamSubscription = databaseRepository.getUserRecomendationBooks(downloadedUser).listen((books) {if(books!= null){add(BooksLoaded(books));}});
        break;
        default:
        break;
    }
  }

  Stream<BooksBlocState> _mapLoadBooksByChild(ListType listType, Hijo hijo)async*{
    yield LoadingBookState();
    _booksStreamSubscription?.cancel();


    switch(listType){
      case ListType.recomended:
        _booksStreamSubscription = databaseRepository.getChildRecommendedBooks(hijo).listen((books) {if(books != null){add(BooksLoaded(books)); }});
        break;
      case ListType.cheapest:
        _booksStreamSubscription = databaseRepository.getChildCheapestBooks(hijo).listen((books) {if(books != null){add(BooksLoaded(books)); }});
        break;
      default:
        break;
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
        final nothing = await databaseRepository.addNewBook(event.book,user).timeout(Duration(seconds: 200),onTimeout: smt);
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
