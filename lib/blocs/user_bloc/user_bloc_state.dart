import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();
}


class UserLoadedState extends UserBlocState{

  final User user;

  UserLoadedState(this.user);

  @override
  List<Object> get props => [user];

}

class UserNotLoaded extends UserBlocState{
  @override
  List<Object> get props => [];
}
