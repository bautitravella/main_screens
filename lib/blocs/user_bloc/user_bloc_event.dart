import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();
}

class LoadUser extends UserBlocEvent{

  final String email;

  LoadUser(this.email);

  @override
  List<Object> get props => [email];


}

class UploadUser extends UserBlocEvent{

  final User user;

  UploadUser(this.user);

  @override
  List<Object> get props => [user];

}

class LoadedUser extends UserBlocEvent{
  final User user;

  LoadedUser(this.user);

  @override
  List<Object> get props => [user];

}