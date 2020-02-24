import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {

  final DatabaseRepository databaseRepository;
  StreamSubscription userStreamSubscription;

  UserBloc(this.databaseRepository);

  @override
  UserBlocState get initialState => UserNotLoaded();

  @override
  Stream<UserBlocState> mapEventToState(
    UserBlocEvent event,
  ) async* {
    if(event is LoadUser){
      yield*  _mapLoadUserToState(event.email);
    }else if(event is UploadUser){
      yield* _mapUploadUserToState(event.user);
    }else if(event is LoadedUser){
      yield* _mapLoadedUserToState(event.user);
    }
  }

   Stream<UserBlocState> _mapLoadUserToState(String email) {
      userStreamSubscription?.cancel();
      userStreamSubscription = databaseRepository.getUserInfo(email).listen((user) {
        add(LoadedUser(user));
      });
   }

  Stream<UserBlocState> _mapUploadUserToState(User user) {
      databaseRepository.addUserInfo(user);

  }

  Stream<UserBlocState> _mapLoadedUserToState(User user) async* {
      yield UserLoadedState(user);
  }
}
