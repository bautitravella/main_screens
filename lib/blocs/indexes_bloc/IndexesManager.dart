

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

class IndexesManager{

  Map<String,BooksIndexes> booksIndexes = HashMap();
  Map<String,UsersIndexes> usersIndexes = SplayTreeMap();


  updateBooksIndexes(DocumentSnapshot documentSnapshot,String instituition){
    booksIndexes[instituition] = BooksIndexes.fromDocumentSnapshot(documentSnapshot);
  }


  updateUsersIndexes(DocumentSnapshot documentSnapshot,instituition){
    usersIndexes[instituition]= UsersIndexes.fromDocumentSnapshot(documentSnapshot);
  }


  List<Book> searchByName(String query){
    List<Book> results = [];
    Iterable<Book> aux ;
    int prueba ;
    booksIndexes.forEach((key, value) {
//      prueba = booksIndexes[key].searchByName(query);
//      print(prueba);
      aux = booksIndexes[key].searchByName(query);
      print("INDX MANAGER sbn2222222= " + aux.toString());

      aux.forEach((element) {
        results.add(element);
      });
    });
    print("INDX MANAGER sbn= " + results.toString());
    return results;
  }
}

class BooksIndexes {

  Map<String,List<String>> nameSearch = SplayTreeMap();
  Map<String,Book> booksList = SplayTreeMap();

  BooksIndexes.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    if(documentSnapshot != null){
      print("INDEXES MANAGER: books document snapshot is not null");
      List<dynamic> books = documentSnapshot['indexes'];
      print(books);
      books.forEach((bookDoc) {
        Book book = Book.fromIndexMap(bookDoc);
        //primero agrego el libro a mi mapa que solo guarda libros por su ID
        booksList[book.uid] = book;
        //agrego los libros al nameSearch
        book.createIndexes();
        book.indexes.forEach((index) {
          if(nameSearch[index] == null){
            nameSearch[index] = List();
          }
          nameSearch[index].add(book.uid);
        });

      });
    }else{
      print("INDEXES MANAGER: books document snapshot is null");
    }
    print("BookIndexes = " + booksList.toString());
  }

  Iterable<Book> searchByName(String query) {
    print("SEARCH BY NAME "+ booksList.values.toString());
    Iterable<Book> result = booksList.values;
    return result;

  }


}

class UsersIndexes {

  Map<String,List<String>> nameSearch = SplayTreeMap();
  Map<String,Book> usersList = SplayTreeMap();

  UsersIndexes.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    List users = documentSnapshot['indexes'];
    if(users != null){
      users.forEach((user) {
        User user = createUserFromDocumentSnapshot(documentSnapshot)
      });
    }
  }

}