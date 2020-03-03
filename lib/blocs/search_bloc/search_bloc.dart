import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final UserBloc userBloc;
  StreamSubscription _userStreamSubscription;
  StreamSubscription booksSubscription;
  final DatabaseRepository databaseRepository;
  User downloadedUser;
  bool isUserDownloaded = false;

  SearchBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {

      if(state is UserLoadedState){
        isUserDownloaded = true;

        //add(LoadChats(state.user));

        downloadedUser = state.user;

      }
    });
  }

  @override
  SearchBlocState get initialState => InitialSearchBlocState();

  @override
  Stream<SearchBlocState> mapEventToState(
    SearchBlocEvent event,
  ) async* {
    if(event is SearchBooks){
      yield* _mapSearchBooksToState(event.list);
    }else if(event is LoadedSearchBooks){
      yield* _mapSearchBooksLoadedToState(event.booksList);
    }
  }

  Stream<SearchBlocState> _mapSearchBooksToState(List<String> list) async* {
    if(list.isNotEmpty) {
      if (downloadedUser != null) {
        booksSubscription =
            databaseRepository.searchBooks(downloadedUser, list).listen((
                booksList) {
              add(LoadedSearchBooks(booksList));
            });
      }
    }else{
      yield InitialSearchBlocState();
    }
  }

  Stream<SearchBlocState>_mapSearchBooksLoadedToState(List<Book> booksList) async*{
    yield SearchBooksLoaded(booksList);
  }
}
