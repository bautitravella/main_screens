import 'dart:async';
import 'package:bloc/bloc.dart';
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

  FavoritesBloc(this.databaseRepository, this.userBloc) {
    _userStreamSubscription = userBloc.listen((state) {
      if (state is UserLoadedState) {
        add(LoadFavoriteBooks(state.user));

        downloadedUser = state.user;
      }
    });
  }

  @override
  FavoritesBlocState get initialState => FavoriteBooksLoading();

  @override
  Stream<FavoritesBlocState> mapEventToState(
    FavoritesBlocEvent event,
  ) async* {
    if (event is LoadFavoriteBooks) {
      yield* _mapLoadFavoriteBooksToState(event.user);
    } else if (event is FavoriteBooksLoadedEvent) {
      yield* _mapFavoriteBooksLoadedToState(event.books);
    } else if (event is AddBookToFavorites) {
      yield* _mapAddBookToFavoritesToState(event.uid);
    } else if (event is RemoveBookFromFavorites) {
      yield* _mapRemoveBookToFavoritesToState(event.book);
    }
  }

  _mapLoadFavoriteBooksToState(User user) async {
    _booksStreamSubscription?.cancel();
    _booksStreamSubscription = databaseRepository
        .getUserFavoriteBooksList(user)
        .listen((booksList) async {
      // print("LLego la lista?????????????????????????????????????????????????????????????????? " + booksList.toString());
      databaseRepository.getUserFavoriteBooks(booksList, user).then((value) {
        add(FavoriteBooksLoadedEvent(value));
        favoriteBooks = value;
      });
    });
  }

  Stream<FavoritesBlocState> _mapFavoriteBooksLoadedToState(
      List<Book> books) async* {
    //print("FAVORITE BOOOKS2 ============= " + books.toString());
    yield FavoriteBooksLoaded(books);
  }

  _mapRemoveBookToFavoritesToState(Book book) {
    databaseRepository.removeFromFavorites(book.uid, downloadedUser);
  }

  _mapAddBookToFavoritesToState(String uid) {
    databaseRepository.addBookToFavorites(uid, downloadedUser);
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    _booksStreamSubscription.cancel();
    return super.close();
  }
}
