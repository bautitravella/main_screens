import 'package:equatable/equatable.dart';

abstract class TokensBlocState extends Equatable {
  const TokensBlocState();
}

class InitialTokensBlocState extends TokensBlocState {
  @override
  List<Object> get props => [];
}
