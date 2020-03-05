import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';
import './bloc.dart';

class TokensBloc extends Bloc<TokensBlocEvent, TokensBlocState> {

  final UserBloc userBloc;
  StreamSubscription _userStreamSubscription;
  StreamSubscription booksSubscription;
  final DatabaseRepository databaseRepository;
  User downloadedUser;
  bool isUserDownloaded = false;

  TokensBloc(this.databaseRepository, this.userBloc){
    _userStreamSubscription = userBloc.listen((state) {

      if(state is UserLoadedState){
        isUserDownloaded = true;

        //add(LoadChats(state.user));

        downloadedUser = state.user;

      }
    });
  }

  @override
  TokensBlocState get initialState => InitialTokensBlocState();

  @override
  Stream<TokensBlocState> mapEventToState(
    TokensBlocEvent event,
  ) async* {
    if(event is AddToken){
      yield* _mapAddTokenToState();
    }else if(event is RemoveToken){
      yield* _mapRemoveTokenToState();
    }
  }

  _mapAddTokenToState() {
    databaseRepository.addToken(downloadedUser);

  }

  _mapRemoveTokenToState() {
    databaseRepository.removeToken(downloadedUser);
  }
}
