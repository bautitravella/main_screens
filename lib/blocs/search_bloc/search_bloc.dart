import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final UserBloc userBloc;
  StreamSubscription _userStreamSubscription;
  List<StreamSubscription> booksSubscriptionList;
  final DatabaseRepository databaseRepository;
  User downloadedUser;
  bool isUserDownloaded = false;
  //List<Book> booksList=[];
  String lastSearchPhrase;
  Queue<List<Book>> resultsQueue = new Queue();
  Queue<String> searchPhrasesQueue = new Queue();

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
      yield* _mapSearchBooksToState(event.search);
    }else if(event is LoadedSearchBooks){
      yield* _mapSearchBooksLoadedToState();
    }
  }

  Stream<SearchBlocState> _mapSearchBooksToState(String searchPhrase) async* {
    if (searchPhrasesQueue.length != 0){
      lastSearchPhrase = searchPhrasesQueue.last;
    }else{
      lastSearchPhrase = null;
    }
    if(lastSearchPhrase == null ||  lastSearchPhrase.length < searchPhrase.length){  //se agrego alguna letra a el searchTerm
      if(lastSearchPhrase == null){
        lastSearchPhrase = searchPhrase;
        resultsQueue.clear();
        //resultsQueue.addLast(List<Book>());
        //searchPhrasesQueue.add(searchPhrase);
      }

      resultsQueue.addLast(List<Book>());
      List<String> list = generateSearchList(searchPhrase);

      if(searchPhrase != null && searchPhrase.length != 0) {
        if (downloadedUser != null) {
          List<String> colegios=downloadedUser.getColegios();
          for(int i=0; i<colegios.length;i++){
            booksSubscriptionList[i] =
                databaseRepository.searchBooksBySchool(downloadedUser, list,colegios[i]).listen((
                    booksList) {
                  print("SEARCH ====" + booksList.toString());
                  booksList.forEach((element) {
                    if(!resultsQueue.last.contains(element)){
                      resultsQueue.last.add(element);
                    }
                  });
                  add(LoadedSearchBooks());
                });
          }
        }
      }else{
        yield InitialSearchBlocState();
      }
      searchPhrasesQueue.addLast(searchPhrase);
    }else{          //se borro alguna letra al searchPhase
      resultsQueue.removeLast();
      searchPhrasesQueue.removeLast();
      add(LoadedSearchBooks());
    }

  }



  Stream<SearchBlocState>_mapSearchBooksLoadedToState() async*{
//    booksList.forEach((element) {
//      if(!this.booksList.contains(element)){
//        this.booksList.add(element);
//      }
//    });
    //List<Book> booksList = new List();
    //booksList = resultsQueue.last;

    yield SearchBooksLoaded(resultsQueue.last);
  }


  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    booksSubscriptionList.forEach((element) {element.cancel();});
    return super.close();
  }

  List<String> generateSearchList(String searchPhrase) {
    return searchPhrase.toLowerCase().split(" ");
  }

}
