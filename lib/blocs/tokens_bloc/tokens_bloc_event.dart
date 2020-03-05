import 'package:equatable/equatable.dart';

abstract class TokensBlocEvent extends Equatable {
  const TokensBlocEvent();
}

class AddToken extends TokensBlocEvent{


  @override
  List<Object> get props => [];
}

class RemoveToken extends TokensBlocEvent{

  @override
  List<Object> get props => [];
}
