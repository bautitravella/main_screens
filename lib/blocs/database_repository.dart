import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';



abstract class DatabaseRepository {

  // USER

  Future<void> addUserInfo(User user);

  Future<void> updateUserInfo(User user);

  Stream<User> getUserInfo(String email);

  //BOOKS
  Future<void> addNewBook(Book book);

  Future<void> deleteBook(Book book);

  Stream<List<Book>> getAllBooks();

  Future<void> updateBook(Book todo);

  Future<void> reFilterBooks(User user) ;

  Stream<List<Book>> getUserBooks(User user);
}

class FirebaseRepository extends DatabaseRepository{

  final usersReference = Firestore.instance.collection("Users");
  final booksReference = Firestore.instance.collection("Publicaciones");

  @override
  Future<void> addNewBook(Book book) {
    return booksReference.document().setData(book.toMap());
  }

  @override
  Future<void> addUserInfo(User user) {
    //TODO primero subir fotos usuario desp subir los datos del usuario

    return usersReference.document(user.email).setData(user.toMap());
  }

  @override
  Future<void> deleteBook(Book book) {
    //return booksReference.document(book.uid).delete();
    throw UnimplementedError("no lo implementaste monster");

  }

//  @override
//  Stream<List<Book>> getAllBooks() {
//    return booksReference.snapshots().map((querySnapshot) => {return querySnapshot.documents.map((doc) => Book.fromDocumentSnapshot(doc)).toList();});
//  }

  @override
  Stream<List<Book>> getAllBooks() {
    return booksReference.snapshots().map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      return snapshot.documents
          .map((doc) => Book.fromDocumentSnapshot(doc)).toList();});
  }

  @override
  Stream<List<Book>> getUserBooks(User user) {
    print("GET USER BOOKS = $user");
    return booksReference.snapshots().map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      return snapshot.documents
          .map((doc) => Book.fromDocumentSnapshot(doc)).toList();});
  }


  @override
  Stream<User> getUserInfo(String email)   {
//    try{
//      DocumentSnapshot documentSnapshot =  await usersReference.document(email).get();
//
//      User user = User.fromMap(documentSnapshot.data, email);
//      return user;
//    }catch(e){
//      return null;
//    }
    try{
      return usersReference.document(email).snapshots().map((doc) => User.fromMap(doc.data, email));
    }catch(e){
      rethrow;
    }



  }

  @override
  Future<void> updateBook(Book book) {
    throw UnimplementedError();
    //return booksReference.document(book.uid).updateData(book.toMap());
  }

  @override
  Future<void> updateUserInfo(User user) {
    return usersReference.document(user.email).updateData(user.toMap());
  }

  @override
  Future<void> reFilterBooks(User user) {
    // TODO: implement reFilterBooks
    throw UnimplementedError();
  }

}