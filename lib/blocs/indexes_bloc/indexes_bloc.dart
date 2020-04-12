import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';
import 'IndexesManager.dart';


class IndexesBloc extends Bloc<IndexesBlocEvent, IndexesBlocState> {

  final DatabaseRepository databaseRepository;
  final UserBloc userBloc;
  List<StreamSubscription> _booksIndexesStreamSubscriptionList = [];
  List<StreamSubscription> _usersIndexesStreamSubscriptionList = [];
  StreamSubscription _userStreamSubscription;
  bool isUserDownloaded = false;
  bool timeouted = false;
  User downloadedUser;
  IndexesManager indexManager = IndexesManager();

  IndexesBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {
      if(state is UserLoadedState){
        downloadedUser = state.user;
        add(LoadIndexes());
      }else if(state is UnloadUser){
        downloadedUser = null;
        add(UnloadIndexes());
      }
    });
  }


  @override
  IndexesBlocState get initialState => InitialIndexesBlocState();

  @override
  Stream<IndexesBlocState> mapEventToState(
    IndexesBlocEvent event,
  ) async* {
    if(event is LoadIndexes){
      yield* _mapLoadIndexesToState();
    }else if(event is UnloadIndexes){
      yield* _mapUnloadIndexesToState();
    }
  }

  _mapLoadIndexesToState() {
      if(downloadedUser != null){
        if(_booksIndexesStreamSubscriptionList == null) _booksIndexesStreamSubscriptionList = [];
        if(_usersIndexesStreamSubscriptionList == null) _usersIndexesStreamSubscriptionList = [];
        List<String> instituitionsList = downloadedUser.getColegios();
        for(int i=0;i<instituitionsList.length;i++){
          String institution = instituitionsList[i];
          _booksIndexesStreamSubscriptionList.add(  databaseRepository.getBookIndexes(institution).listen((booksList) {
            indexManager.updateBooksIndexes(booksList,institution);
          }));
          _usersIndexesStreamSubscriptionList.add(  databaseRepository.getUsersIndexes(institution).listen((usersList) {
            indexManager.updateUsersIndexes(usersList,institution);
          }));
        }

        };
  }

  _mapUnloadIndexesToState() {

    if(_usersIndexesStreamSubscriptionList != null && _booksIndexesStreamSubscriptionList != null){
      _usersIndexesStreamSubscriptionList.forEach((element) {
        element.cancel();
      });
      _booksIndexesStreamSubscriptionList.forEach((element) {
        element.cancel();
      });
    }
    _usersIndexesStreamSubscriptionList.clear();
    _booksIndexesStreamSubscriptionList.clear();

  }

  @override
  Future<void> close() {

    if(_usersIndexesStreamSubscriptionList != null && _booksIndexesStreamSubscriptionList != null){
      _usersIndexesStreamSubscriptionList.forEach((element) {
        element.cancel();
      });
      _booksIndexesStreamSubscriptionList.forEach((element) {
        element.cancel();
      });
    }
    return super.close();
  }
}
