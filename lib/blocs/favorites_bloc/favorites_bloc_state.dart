import 'package:equatable/equatable.dart';

abstract class FavoritesBlocState extends Equatable {
  const FavoritesBlocState();
}

class InitialFavoritesBlocState extends FavoritesBlocState {
  @override
  List<Object> get props => [];
}
