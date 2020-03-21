import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/database_repository.dart';
import './bloc.dart';

class EconomicosBloc extends Bloc<EconomicosBlocEvent, EconomicosBlocState> {

  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  StreamSubscription _booksStreamSubscription;
  StreamSubscription _userStreamSubscription;
  bool isUserDownloaded = false;
  bool timeouted = false;
  User downloadedUser;


  EconomicosBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {
      if(state is UserLoadedState){
        if(isUserDownloaded == false){
          isUserDownloaded = true;
          downloadedUser = state.user;
          add(LoadUserEconomicosBooks());

        }else{
          downloadedUser = state.user;
          add(LoadUserEconomicosBooks());
        }

      }
    });
  }


  @override
  EconomicosBlocState get initialState => LoadingEconomicosBooksState();

  @override
  Stream<EconomicosBlocState> mapEventToState(
      EconomicosBlocEvent event,
      ) async* {
    if(event is LoadUserEconomicosBooks){
      yield*  _mapLoadUserBooksToState();
    }else if(event is EconomicosBooksLoaded){
      yield*  _mapBooksLoadedToState(event.books);
    }
  }



  Stream<EconomicosBlocState> _mapLoadUserBooksToState() {

    if(isUserDownloaded == false){
      if(downloadedUser != null){
        _booksStreamSubscription?.cancel();

        _booksStreamSubscription = databaseRepository.getUserCheapBooks(downloadedUser).listen((books) {add(EconomicosBooksLoaded(books)); });
      }

    }else{
      _booksStreamSubscription?.cancel();

      _booksStreamSubscription = databaseRepository.getUserCheapBooks(downloadedUser).listen((books) {add(EconomicosBooksLoaded(books)); });
    }

  }

  Stream<EconomicosBlocState> _mapBooksLoadedToState(List<Book> books) async*{
    yield EconomicosBooksLoadedState(books);

  }




  Stream<EconomicosBlocState> _mapUserUpdatedToState(User user) {
    databaseRepository.reFilterBooks(user);
  }




  @override
  Future<void> close(){
    _booksStreamSubscription?.cancel();
    return super.close();
  }

}
