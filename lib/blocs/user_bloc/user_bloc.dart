import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/message_model.dart';
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
    }else if(event is UnloadUser){
      yield* _mapUnloadUserToState();
    }
  }

   Stream<UserBlocState> _mapLoadUserToState(String email) {
      userStreamSubscription?.cancel();
      try {
        userStreamSubscription =
            databaseRepository.getUserInfo(email).listen((user) {
              add(LoadedUser(user));
            });
      }catch (e){
        print("ERROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOORRRRR = $e");
      }
   }

  Stream<UserBlocState> _mapUploadUserToState(User user) {
      databaseRepository.addUserInfo(user);

  }

  Stream<UserBlocState> _mapLoadedUserToState(User user) async* {
      yield UserLoadedState(user);
  }

  Stream<UserBlocState> _mapUnloadUserToState()  async*{
    userStreamSubscription.cancel();
    yield UserNotLoaded();
  }


}

 void doSmt(){
  print('PROBLEMAS EN EL PARAISO');
 }
