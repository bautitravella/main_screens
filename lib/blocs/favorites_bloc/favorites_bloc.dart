import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc.dart';
import '../bloc.dart';
import '../database_repository.dart';
import './bloc.dart';

class FavoritesBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> {
  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  StreamSubscription _booksStreamSubscription;
  StreamSubscription _userStreamSubscription;
  bool isUserDownloaded = false;
  User downloadedUser;
  List<Book> favoriteBooks;
  Stream<List> favoritesStream;

  FirebaseAnalytics analytics = FirebaseAnalytics();

  FavoritesBloc(this.databaseRepository, this.userBloc) {
    if(userBloc != null){
      _userStreamSubscription = userBloc?.listen((state) {
        if (state is UserLoadedState) {
          add(LoadFavoriteBooks(state.user));

          downloadedUser = state.user;
        }
      });
    }

  }

  @override
  FavoritesBlocState get initialState => FavoriteBooksLoading();

  @override
  Stream<FavoritesBlocState> mapEventToState(
    FavoritesBlocEvent event,
  ) async* {
    if (event is LoadFavoriteBooks) {
       _mapLoadFavoriteBooksToState(event.user);
    } else if (event is FavoriteBooksLoadedEvent) {
      yield* _mapFavoriteBooksLoadedToState(event.books);
    } else if (event is AddBookToFavorites) {
      yield* _mapAddBookToFavoritesToState(event.uid);
    } else if (event is RemoveBookFromFavorites) {
      yield* _mapRemoveBookToFavoritesToState(event.uid);
    }
  }

  _mapLoadFavoriteBooksToState(User user) async {
    //_booksStreamSubscription?.cancel();
    try {
      if (downloadedUser != null) {
        favoritesStream = databaseRepository
            .getUserFavoriteBooksList(user);
        if (favoritesStream != null) {
          _booksStreamSubscription = favoritesStream?.listen((booksList) async {
            // print("LLego la lista?????????????????????????????????????????????????????????????????? " + booksList.toString());
            databaseRepository.getUserFavoriteBooks(booksList, user).then((
                value) {
              add(FavoriteBooksLoadedEvent(value));
              favoriteBooks = value;
            });
          });
        }
      }
    }catch(e){
      print("ERROR FAVORITE BOOKS mLFBTS = " + e.toString());
    }

//    _booksStreamSubscription = databaseRepository
//        .getUserFavoriteBooksList(user)
//        .listen((booksList) async {
//      // print("LLego la lista?????????????????????????????????????????????????????????????????? " + booksList.toString());
//      databaseRepository.getUserFavoriteBooks(booksList, user).then((value) {
//        add(FavoriteBooksLoadedEvent(value));
//        favoriteBooks = value;
//      });
//    });
  }

  Stream<FavoritesBlocState> _mapFavoriteBooksLoadedToState(List<Book> books) async* {
    //print("FAVORITE BOOOKS2 ============= " + books.toString());
    yield FavoriteBooksLoaded(books);
  }

  _mapRemoveBookToFavoritesToState(String uid) {
    analytics.logEvent(name: "remove_favorites",parameters: {"uid": uid});
    databaseRepository.removeFromFavorites(uid, downloadedUser);
  }

  _mapAddBookToFavoritesToState(String uid) {
    analytics.logEvent(name: "add_favorites",parameters: {"uid": uid});
    databaseRepository.addBookToFavorites(uid, downloadedUser);
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    _booksStreamSubscription.cancel();
    return super.close();
  }
}
