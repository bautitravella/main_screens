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
  UserBlocState get initialState =>UserLoadingState();

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
    }else if(event is UserNotLoaded){
      yield*  _mapUserNotLoadedToState();
    }
  }

   Stream<UserBlocState> _mapLoadUserToState(String email) async* {
      //userStreamSubscription?.cancel();
      //yield UserLoadingState();
      try {
        Stream<User> streamUser = databaseRepository.getUserInfo(email);
        if(streamUser != null){
          userStreamSubscription = streamUser.listen( (user) {
            if(user == null){
              add(UserNotLoaded());
            }else{
              add(LoadedUser(user));
            }

          }  );
        }
//        userStreamSubscription =
//            databaseRepository.getUserInfo(email).listen((user) {
//              if(user == null){
//                add(UserNotLoaded());
//              }else{
//                add(LoadedUser(user));
//              }
//
//            });
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
    yield InitialUserBlocState();
    userStreamSubscription.cancel();
  }

  @override
  Future<void> close() {
    userStreamSubscription.cancel();
    return super.close();
  }

  Stream<UserBlocState>  _mapUserNotLoadedToState() async*{
    yield UserNotLoadedState();
  }

}

 void doSmt(){
  print('PROBLEMAS EN EL PARAISO');
 }
