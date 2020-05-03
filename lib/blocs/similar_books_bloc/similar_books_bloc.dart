import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/database_repository.dart';
import './bloc.dart';

class SimilarBooksBloc extends Bloc<SimilarBooksBlocEvent, SimilarBooksBlocState> {


  final DatabaseRepository databaseRepository;
  StreamSubscription booksStreamSubscription;

  SimilarBooksBloc(this.databaseRepository);

  @override
  SimilarBooksBlocState get initialState => InitialSimilarBooksBlocState();

  @override
  Stream<SimilarBooksBlocState> mapEventToState(
    SimilarBooksBlocEvent event,
  ) async* {
    if(event is GetSimilarBooks){
       _mapGetSimilarBooksToState(event.book);
    }else if(event is SimilarBooksDownloaded){
      yield* _mapSimilarBooksDownloadedToState(event.booksList);
    }
  }

  _mapGetSimilarBooksToState(Book book) {
      booksStreamSubscription = databaseRepository.getSimilarBooksBySchool(book, book.colegios.first).listen((booksList) {

        if(booksList != null){
          add(SimilarBooksDownloaded(booksList));
        }

      });
  }

  Stream<SimilarBooksBlocState> _mapSimilarBooksDownloadedToState(List<Book> booksList) async*{
    yield SimilarBooksDownloadedState(booksList);
  }






}
