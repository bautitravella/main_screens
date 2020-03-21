import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();
}

class InitialUserBlocState extends UserBlocState{
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserBlocState{

  final User user;

  UserLoadedState(this.user);

  @override
  List<Object> get props => [user];

}

class UserNotLoadedState extends UserBlocState{
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserBlocState{
  @override
  List<Object> get props => [];
}
