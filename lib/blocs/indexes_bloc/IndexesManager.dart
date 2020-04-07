

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/book.dart';

class IndexesManager{

  Map<String,BooksIndexes> booksIndexes = SplayTreeMap();
  Map<String,UsersIndexes> usersIndexes = SplayTreeMap();


  updateBooksIndexes(DocumentSnapshot documentSnapshot,String instituition){
    booksIndexes[instituition] = BooksIndexes.fromDocumentSnapshot(documentSnapshot);
  }


  updateUsersIndexes(DocumentSnapshot documentSnapshotsList,instituition){

  }


  List<Book> searchByName(String query){
    List<Book> results = [];
    booksIndexes.forEach((key, value) {
      results.addAll(booksIndexes[key].searchByName(query));
    });
  }
}

class BooksIndexes {

  Map<String,String> nameSearch = SplayTreeMap();
  Map<String,Book> booksList = SplayTreeMap();

  BooksIndexes.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    List<dynamic> books = documentSnapshot['books'];
    books.forEach((bookDoc) {
      Book book = Book.fromIndexMap(bookDoc);
      //primero agrego el libro a mi mapa que solo guarda libros por su ID
      booksList[book.uid] = book;
      //agrego los libros al nameSearch
      nameSearch[book.nombreLibro] = book.uid;
    });
  }

  List<Book> searchByName(String query) {
    return [booksList[nameSearch['query']]];
  }


}

class UsersIndexes {

  UsersIndexes.fromDocumentSnapshot(DocumentSnapshot documentSnapshot);

}