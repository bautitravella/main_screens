import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';



abstract class DatabaseRepository {

  // USER

  Future<void> addUserInfo(User user);

  Future<void> updateUserInfo(User user);

  Stream<User> getUserInfo(String email);

  //BOOKS
  Future<void> addNewBook(Book book, User user);

  Future<void> deleteBook(Book book);

  Stream<List<Book>> getAllBooks();

  Future<void> updateBook(Book todo);

  Future<void> reFilterBooks(User user) ;

  Stream<List<Book>> getUserRecomendationBooks(User user);
  
  Stream<List<Book>> getUserBooks(User user);

  Future<void> reFilterUserBooks(User user);
}

class FirebaseRepository extends DatabaseRepository{

  final usersReference = Firestore.instance.collection("Users");
  final booksReference = Firestore.instance.collection("Publicaciones");

  @override
  Future<void> addNewBook(Book book, User user) async {
    Future<void> returnFuture;

    List<String> bookSplitList = book.nombreLibro.split(" ");

    for (var value in book.autor.split(" ")) {
      bookSplitList.add(value);
    }

    List<String> indexList = [];

    for(int i = 0; i < bookSplitList.length ; i++){
      for(int j = 1; j < bookSplitList[i].length + 1; j++){
        indexList.add(bookSplitList[i].substring(0,j).toLowerCase());
      }
    }

    book.indexes = indexList;


    book.addUserInformation(user);
    book.vendido = false;
    DocumentReference documentReference = booksReference.document();

    documentReference.setData(book.toMap()).then((doc) => {
      uploadBookImages(book,documentReference.documentID).then((urlList)  {
    urlList.forEach((url) {
    book.imagesUrl.add(url);
    });
    return returnFuture =  booksReference.document(documentReference.documentID).setData(book.toMap());

    }),
    });


  }

  Future<List<String>> uploadBookImages(Book book,String uid) async {
    List<String> urlList = [];
    for(int i = 0; i< book.imagesRaw.length -1; i++){
      urlList.add(await uploadBookImage(i,book,uid));
    }
    return urlList;
  }

  Future uploadBookImage(int i, Book book,String uid) async {
    StorageReference ref =
    FirebaseStorage.instance.ref().child("publicaciones_images2/" + uid + i.toString() + ".jpg");
    StorageUploadTask uploadTask = ref.putFile(book.imagesRaw[i]);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
    (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
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
  Stream<List<Book>> getUserRecomendationBooks(User user) {
    print("GET USER BOOKS = $user");
    return booksReference.snapshots().map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      return snapshot.documents
          .map((doc) {
            try {
              return Book.fromDocumentSnapshot(doc);
            }catch(e){
              print(e);
            }
          })
          .toList();
    });
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

  @override
  Stream<List<Book>> getUserBooks(User user) {
    return booksReference.where("emailVendedor",isEqualTo: user.email).snapshots().map((snapshot) {
      print('USER BOOKS ================= ${snapshot.documents}');
      return snapshot.documents
          .map((doc) {
        try {
          return Book.fromDocumentSnapshot(doc);
        }catch(e){
          print(e);
        }
      })
          .toList();
    });
  }



  @override
  Future<void> reFilterUserBooks(User user) {
    // TODO: implement reFilterUserBooks
    throw UnimplementedError();
  }

}