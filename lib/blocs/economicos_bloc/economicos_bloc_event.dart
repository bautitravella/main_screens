import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/book.dart';

abstract class EconomicosBlocEvent extends Equatable {
  const EconomicosBlocEvent();
}

class LoadUserEconomicosBooks extends EconomicosBlocEvent{


  @override
  List<Object> get props => [];


}

class EconomicosBooksLoaded extends EconomicosBlocEvent{

  final List<Book> books;

  EconomicosBooksLoaded(this.books);

  @override
  List<Object> get props => [books];

}