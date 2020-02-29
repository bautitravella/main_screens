import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/Colegio.dart';
import 'package:flutter/services.dart';
import 'dart:core';



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

  Stream<List<dynamic>> getUserFavoriteBooksList(User user);

  Future<List<Book>> getUserFavoriteBooks(List<dynamic> favoritesList,User user);

  Future<void> reFilterUserBooks(User user);

  Future<void> removeFromFavorites(String uid, User user);
  
  Future<void> addBookToFavorites(String uid,User user);

  Stream<ColegiosData> getColegios();

  //CHAT
  Stream<List<Chat>> getVentaChats(User user);
  Stream<List<Chat>> getCompraChats(User user);
  Future<void> addChat(User user,Chat chat);
  Future<void> buyBook();
  Future<void> sellBook();
  Stream<List<Message>> getMessagesWithUid(Chat chat,User user);
  Future<Chat> getChatUid(Chat chat,User user);
  Future<void> sendMessage(Chat chat,User user,Message message);
  
  
}

class FirebaseRepository extends DatabaseRepository{

  final usersReference = Firestore.instance.collection("Users");
  final booksReference = Firestore.instance.collection("Publicaciones");
  final colegiosReference = Firestore.instance.collection("Colegios");
  final chatsReference = Firestore.instance.collection('Chats');

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

  Stream<List<dynamic>> getUserFavoriteBooksList(User user){
    return usersReference.document(user.email).collection("Favoritos").document("favoritos").snapshots().map((doc) => doc.data['favoritosList'] );
  }

  Future<List<DocumentSnapshot>> _getUserFavoriteBooksFuture(List<dynamic> favoritesList){
    List<Future<DocumentSnapshot>> futureList = [];

    for(int i = 0; i < favoritesList.length; i++){
      String uid = favoritesList[i];
      futureList.add(booksReference.document(uid).get());
    }

    return Future.wait(futureList);
  }

  Future<List<Book>> getUserFavoriteBooks(List<dynamic> favoritesList,User user) async {


    List<DocumentSnapshot> documentsList = await _getUserFavoriteBooksFuture(favoritesList);

    return documentsList.map((doc) =>  Book.fromDocumentSnapshot(doc)).toList();
  }
  
  @override
  Future<void> reFilterUserBooks(User user) {
    // TODO: implement reFilterUserBooks
    throw UnimplementedError();
  }
  
  @override
  Future<void> addBookToFavorites(String uid,User user) {
    try{
    usersReference.document(user.email).collection("Favoritos").document("favoritos").updateData({"favoritosList": FieldValue.arrayUnion([uid])});
    }catch (e){
      print(e.toString());
    }
  }

  @override
  Future<void> removeFromFavorites(String uid, User user) {
    usersReference.document(user.email).collection("Favoritos").document("favoritos").updateData({"favoritosList": FieldValue.arrayRemove([uid])});
  }

  @override
  Stream<ColegiosData> getColegios() {
    return colegiosReference.document('colegios').snapshots().map((doc) { return ColegiosData.fromDocumentSnapshot(doc);});
  }

  @override
  Future<void> addChat(User user,Chat chat) {
    chat.addCompradorInformation(user);
    return chatsReference.document().setData(chat.toMap());
  }

  @override
  Future<void> buyBook() {
    // TODO: implement buyBook
    throw UnimplementedError();
  }

  @override
  Stream<List<Chat>> getVentaChats(User user) {
    return chatsReference.where('vendedorEmail',isEqualTo: user.email).snapshots().map((docs) => docs.documents.map((doc) => Chat.fromDocumentSnapshotAsVendedor(doc)));
  }

  @override
  Stream<List<Chat>> getCompraChats(User user) {
    return chatsReference.where('compradorEmail',isEqualTo: user.email).snapshots().map((docs) => docs.documents.map((doc) => Chat.fromDocumentSnapshotAsVendedor(doc)));
  }

  @override
  Stream<List<Message>> getMessagesWithUid(Chat chat, User user) {
    return chatsReference.document(chat.uid).collection("Messages").snapshots().map((docs) => docs.documents.map((doc) => Message.fromDocumentSnapshot(doc)));
  }

  Future<Chat> getChatUid(Chat chat,User user) async{
    QuerySnapshot snapshot = await getChatUidDocuments(chat, user);
    print("GetChatUid printing snapshot ${snapshot.toString()}");
    if(snapshot.documents != null && snapshot.documents.isNotEmpty){
      if(snapshot.documents.length == 1){
        DocumentSnapshot doc = snapshot.documents.single;
        return Chat.fromDocumentSnapshotAsComprador(doc);
      }

    }
    print("GetChatUid printing nullll");
    return null;


//    try {
//
//    } on IterableElementError  catch (e){
//      print("ErrorGetChatUid = " + e.toString());
//      return null;
//    }catch(e){
//      print("ErrorGetChatUid = " + e.toString());
//      rethrow;
//    }

  }

  Future<QuerySnapshot> getChatUidDocuments(Chat chat,User user){
    return chatsReference.where('compradorEmail', isEqualTo: user.email).where('publicacionId',isEqualTo: chat.publicacionId).getDocuments();
  }


  @override
  Future<void> sellBook() {
    // TODO: implement sellBook
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(Chat chat,User user,Message message) {
    chatsReference.document(chat.uid).collection("Message").document().setData(message.toMap());
  }





}