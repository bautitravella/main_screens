import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/User.dart';

abstract class DatabaseBlocEvent extends Equatable {
  const DatabaseBlocEvent();
}

class LoadUserInfo{}

class UpdateUserInfo{
  User user;
  UpdateUserInfo(this.user);

  @override
  List<Object> get props => [user];

}




