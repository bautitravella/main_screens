import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/Colegio.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutterui/Models/chat_roles.dart';

abstract class DatabaseRepository {
  // USER

  Future<void> addUserInfo(User user);

  Future<void> editUserInfo(User user);

  Future<void> editUserImage(User user);

  Future<void> editUser(User user);

  Stream<User> getUserInfo(String email);




  //BOOKS
  Future<void> addNewBook(Book book, User user);

  Future<void> deleteBook(Book book);

  Stream<List<Book>> getAllBooks();

  Future editBook(Book book);

  Future editBookInfo(Book book);

  Future editBookImages(Book book);

  Future<void> reFilterBooks(User user);

  Stream<List<Book>> getUserRecomendationBooks(User user);

  Stream<List<Book>> getUserBooks(User user);

  Stream<List<dynamic>> getUserFavoriteBooksList(User user);

  Future<List<Book>> getUserFavoriteBooks(
      List<dynamic> favoritesList, User user);
  
  Stream<List<Book>> getUserCheapBooks(User user);

  Future<void> reFilterUserBooks(User user);

  Future<void> removeFromFavorites(String uid, User user);

  Future<void> addBookToFavorites(String uid, User user);

  Stream<ColegiosData> getColegios();

  Future<void> addSchool(String name,String email);

  //CHAT
  Stream<List<Chat>> getVentaChats(User user);
  Stream<List<Chat>> getCompraChats(User user);
  Future<String> addChat(User user, Chat chat);
  Future<void> buyBook();
  Future<void> sellBook();
  Stream<List<Message>> getMessagesWithUid(Chat chat, User user);
  Future<Chat> getChatUid(Chat chat, User user);
  Future<void> sendMessage(Chat chat, User user, Message message);
  Future<void> updateLastMessage(
      Chat currentChat, Message message, ChatRole chatRole);
  Future<void> updateLeidoByField(Chat chat, ChatRole chatRole);
  Future<void> solicitarCompra(Chat chat);
  Future<void> cancelarSolicitudDeCompra(Chat chat);
  Future<void> aceptarSolicitudDeCompra(Chat chat);
  Future<void> rechazarSolicitudDeCompra(Chat chat);
  Future<void> addToken(User user);
  Future<void> removeToken(User user);

  Stream<List<Book>> searchBooks(User downloadedUser, List<String> list);
  Stream<List<Book>> searchBooksBySchool(User downloadedUser, List<String> list, String colegio);

  Stream<Chat> getChat(Chat chat) {}




}

class FirebaseRepository extends DatabaseRepository {
  static Firestore _firestoreInstance = Firestore.instance;


  final usersReference = _firestoreInstance.collection("Users");
  final booksReference = _firestoreInstance.collection("Publicaciones");
  final colegiosReference = _firestoreInstance.collection("Colegios");
  final chatsReference = _firestoreInstance.collection('Chats');
  final requestsReference = _firestoreInstance.collection("Requests");
  final booksCollectionGroupReference = _firestoreInstance.collectionGroup("colegiosSearch");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Future editBook(Book book){
    return Future.wait([editBookInfo(book),editBookImages(book)]);
  }

  @override
  Future editBookInfo(Book book){

    book.createIndexes();
    return booksReference
        .document(book.uid)
        .updateData(book.toMap());
    //Todo faltaria hacer que se modifique el nombre del libro en todos los chats que sean de este libro

  }

  @override
  Future editBookImages(Book book){
    book.imagesUrl.clear();
    book.thumbImagesUrl.clear();
    Future uploadImages =
    uploadBookImages(book, book.uid).then((urlLists) {
      urlLists[0].forEach((url) {
        book.imagesUrl.add(url);
      });
      urlLists[1].forEach((thumbUrl) {
        book.thumbImagesUrl.add(thumbUrl);
      });
    });
    return  Future.wait([uploadImages]).then((urlLists) {

      booksReference
          .document(book.uid)
          .updateData(book.toMap());
    });
  }

  @override
  Future<void> addNewBook(Book book, User user) async {
    Future<void> returnFuture;

    book.createIndexes();
    book.addUserInformation(user);
    book.vendido = false;
    DocumentReference documentReference = booksReference.document();

//    documentReference.setData(book.toMap()).then((doc) => {
//      uploadBookImages(book,documentReference.documentID).then((urlLists)  {
//    urlLists[0].forEach((url) {book.imagesUrl.add(url); });
//    urlLists[1].forEach((thumbUrl) {book.thumbImagesUrl.add(thumbUrl); });
//
//    return returnFuture =  booksReference.document(documentReference.documentID).setData(book.toMap());
//
//    }),
//    });
    Future uploadImages =
        uploadBookImages(book, documentReference.documentID).then((urlLists) {
      urlLists[0].forEach((url) {
        book.imagesUrl.add(url);
      });
      urlLists[1].forEach((thumbUrl) {
        book.thumbImagesUrl.add(thumbUrl);
      });
    });
    return  Future.wait([uploadImages]).then((urlLists) {

      booksReference
          .document(documentReference.documentID)
          .setData(book.toMap());
    });
  }

  Future<List<List<String>>> uploadBookImages(Book book, String uid) async {
    List<List<String>> urlLists = List(2);
    urlLists[0] = [];
    urlLists[1] = [];
    for (int i = 0; i < book.imagesRaw.length; i++) {
      urlLists[0].add(await uploadBookImage(i, book, uid));
    }
    for (int i = 0; i < book.imagesRawThumb.length; i++) {
      urlLists[1].add(await uploadBookThumbImage(i, book, uid));
    }
    return urlLists;
  }

  Future uploadBookImage(int i, Book book, String uid) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("publicaciones_images2/" + uid + i.toString() + ".jpg");
    StorageUploadTask uploadTask = ref.putData(book.imagesRaw[i]);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
        (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
  }

  Future uploadBookThumbImage(int i, Book book, String uid) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("publicaciones_thumbs2/" + uid + i.toString() + ".jpg");
    StorageUploadTask uploadTask = ref.putData(book.imagesRawThumb[i]);
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
          .map((doc) => Book.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<Book>> getUserRecomendationBooks(User user) {
    print("GET USER BOOKS = $user");
    return booksReference
        .where("vendido",isEqualTo: false)
        .where("colegios",arrayContainsAny: user.getColegios())
        .snapshots().map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      List<Book> books = [];
      Book book;
      List<dynamic> cursos;
      bool addBook=false;
      snapshot.documents.forEach((doc) {
        try {
          if(doc['cursos'] != null) {
            cursos = doc['cursos'];
            user.getCursos().forEach((curso) {
              if(cursos.contains(curso))addBook = true;
            });
            if(doc['emailVendedor'] != null && doc['emailVendedor'] == user.email ){
              addBook = false;
            }
            if(addBook){
              book = Book.fromDocumentSnapshot(doc);
              if (book != null) {
                books.add(book);
              }
            }
          }
        } catch (e) {
          print("NO SE PUDO AGREGAR ESTE LIBRO");
        }
      });
      return books;
//      return snapshot.documents
//          .map((doc) {
//            try {
//              return Book.fromDocumentSnapshot(doc);
//            }catch(e){
//              print(e);
//            }
//          })
//          .toList();
    });
  }
  @override
  Stream<List<Book>> getUserCheapBooks(User user) {
    print("GET USER BOOKS = $user");
    return booksReference
        .where("vendido",isEqualTo: false)
        .where("colegios", arrayContainsAny: user.getColegios())
        .orderBy("precio", descending: false)
        .limit(50)
        .snapshots().map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      List<Book> books = [];
      Book book;
      bool addBook = false;
      snapshot.documents.forEach((doc) {
        try {
          book = Book.fromDocumentSnapshot(doc);
          if (book != null) {
            books.add(book);
          }
        } catch (e) {
          print("NO SE PUDO AGREGAR ESTE LIBRO");
        }
      });
      return books;
    });
  }

  @override
  Stream<User> getUserInfo(String email) {
//    try{
//      DocumentSnapshot documentSnapshot =  await usersReference.document(email).get();
//
//      User user = User.fromMap(documentSnapshot.data, email);
//      return user;
//    }catch(e){
//      return null;
//    }
    try {
      return usersReference
          .document(email)
          .snapshots()
          .map((doc) {
            if(doc.data!=null){
              return createUserFromDocumentSnapshot(doc);
            }
            });
      //User.fromMap(doc.data, email));
    } catch (e) {
      print("getUserInfo error = " + e.toString());
      rethrow;
    }
  }

  @override
  Future<void> editUser(User user) {
    return Future.wait([editUserImage(user),editUserInfo(user)]);
  }

  @override
  Future<void> editUserImage(User user) async {
    String downloadUrl = await uploadProfileImage(user);
    usersReference.document(user.email).updateData({"fotoPerfilUrl":downloadUrl});
    return null;
  }

  Future<String> uploadProfileImage(User user) async {
    StorageReference ref =
    FirebaseStorage.instance.ref().child("profile_images2/" + user.email + ".jpg");
    StorageUploadTask uploadTask = ref.putFile(user.fotoPerfilRaw);
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
  Future<void> editUserInfo(User user) {
    return usersReference.document(user.email).updateData(user.toMap());
  }

  @override
  Future<void> reFilterBooks(User user) {
    // TODO: implement reFilterBooks
    throw UnimplementedError();
  }

  @override
  Stream<List<Book>> getUserBooks(User user) {
    return booksReference
        .where("emailVendedor", isEqualTo: user.email)
        .snapshots()
        .map((snapshot) {
      print('DOCUMENTOS ================= ${snapshot.documents}');
      List<Book> books = [];
      Book book;
      snapshot.documents.forEach((doc) {
        try {
          book = Book.fromDocumentSnapshot(doc);
          if (book != null) {
            books.add(book);
          }
        } catch (e) {
          print("NO SE PUDO AGREGAR ESTE LIBRO");
        }
      });
      return books;
    });
  }

  Stream<List<dynamic>> getUserFavoriteBooksList(User user) {
    return usersReference
        .document(user.email)
        .collection("Favoritos")
        .document("favoritos")
        .snapshots()
        .map((doc) => doc.data['favoritosList']);
  }

  Future<List<DocumentSnapshot>> _getUserFavoriteBooksFuture(
      List<dynamic> favoritesList) {
    List<Future<DocumentSnapshot>> futureList = [];

    for (int i = 0; i < favoritesList.length; i++) {
      String uid = favoritesList[i];
      futureList.add(booksReference.document(uid).get());
    }

    return Future.wait(futureList);
  }

  Future<List<Book>> getUserFavoriteBooks(
      List<dynamic> favoritesList, User user) async {
    List<DocumentSnapshot> documentsList =
        await _getUserFavoriteBooksFuture(favoritesList);

    return documentsList.map((doc) => Book.fromDocumentSnapshot(doc)).toList();
  }

  @override
  Future<void> reFilterUserBooks(User user) {
    // TODO: implement reFilterUserBooks
    throw UnimplementedError();
  }

  @override
  Future<void> addBookToFavorites(String uid, User user) {
    try {
      usersReference
          .document(user.email)
          .collection("Favoritos")
          .document("favoritos")
          .updateData({
        "favoritosList": FieldValue.arrayUnion([uid])
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> removeFromFavorites(String uid, User user) {
    usersReference
        .document(user.email)
        .collection("Favoritos")
        .document("favoritos")
        .updateData({
      "favoritosList": FieldValue.arrayRemove([uid])
    });
  }

  @override
  Stream<ColegiosData> getColegios() {
    return colegiosReference.document('colegios').snapshots().map((doc) {
      return ColegiosData.fromDocumentSnapshot(doc);
    });
  }

  @override
  Future<String> addChat(User user, Chat chat) async {
    chat.addCompradorInformation(user);
    Chat potentialChat = await getChatUid(chat, user);
    Map<String,dynamic> estadoMap = {
      "timestamp":FieldValue.serverTimestamp(),
      "estadoTransaccion":chat.estadoTransaccion,
      "emailRecipient":chat.vendedorEmail,
    };

    if (potentialChat == null) {
      DocumentReference documentReference =
          await chatsReference.add(chat.toMap());
      chatsReference.document(documentReference.documentID).collection("estadoTransaccion").add(estadoMap);
      return documentReference.documentID;
    } else {
      chatsReference.document(potentialChat.uid).collection("estadoTransaccion").add(estadoMap);
      return potentialChat.uid;
    }
  }

  @override
  Future<void> buyBook() {
    // TODO: implement buyBook
    throw UnimplementedError();
  }

  @override
  Stream<List<Chat>> getVentaChats(User user) {
    return chatsReference
        .where('vendedorEmail', isEqualTo: user.email)
        .orderBy("lastMessageTimestamp",descending: true)
        .snapshots()
        .map((docs) => docs.documents
            .map((doc) => Chat.fromDocumentSnapshot(doc))
            .toList());
  }

  @override
  Stream<List<Chat>> getCompraChats(User user) {
    return chatsReference
        .where('compradorEmail', isEqualTo: user.email)
        .orderBy("lastMessageTimestamp",descending: true)
        .snapshots()
        .map((docs) => docs.documents
            .map((doc) => Chat.fromDocumentSnapshot(doc))
            .toList());
  }

  Stream<Chat> getChat(Chat chatWithUid){
    return chatsReference.document(chatWithUid.uid).snapshots().map((doc) => Chat.fromDocumentSnapshot(doc));
  }

  @override
  Stream<List<Message>> getMessagesWithUid(Chat chat, User user) {
    return chatsReference
        .document(chat.uid)
        .collection("Messages")
        .orderBy("sentTimestamp", descending: true)
        .snapshots()
        .map((docs) => docs.documents
            .map((doc) => createMessageFromDocumentSnapshot(doc))
            .toList());
  }

  Future<Chat> getChatUid(Chat chat, User user) async {
    QuerySnapshot snapshot = await getChatUidDocuments(chat, user);
    print("GetChatUid printing snapshot ${snapshot.toString()}");
    if (snapshot.documents != null && snapshot.documents.isNotEmpty) {
      if (snapshot.documents.length == 1) {
        DocumentSnapshot doc = snapshot.documents.single;
        return Chat.fromDocumentSnapshot(doc);
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

  Future<QuerySnapshot> getChatUidDocuments(Chat chat, User user) {
    return chatsReference
        .where('compradorEmail', isEqualTo: user.email)
        .where('publicacionId', isEqualTo: chat.publicacionId)
        .getDocuments();
  }

  @override
  Future<void> sellBook() {
    // TODO: implement sellBook
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(Chat chat, User user, Message message) {
    chatsReference
        .document(chat.uid)
        .collection("Messages")
        .document()
        .setData(message.toMap());
  }

  //Todo crear funcion para que se cambie el estado de leidoPorCOmpradory asi cuando uno lee un mensaje
  Future<void> updateLeidoByField(Chat chat, ChatRole chatRole) {
    if (chatRole == ChatRole.COMPRADOR) {
      chatsReference
          .document(chat.uid)
          .updateData({"leidoPorElComprador": true});
    } else {
      chatsReference
          .document(chat.uid)
          .updateData({"leidoPorElVendedor": true});
    }
  }

  @override
  Future<void> updateLastMessage(
      Chat currentChat, Message message, ChatRole chatRole) {
    // todo que tambien se cambie lo de leidoPorCOmprador/Vendedor
    chatsReference.document(currentChat.uid).updateData({
      "lastMessage": message.messageText,
      "lastMessageTimestamp": Timestamp.now(),
      "leidoPorElComprador": chatRole == ChatRole.COMPRADOR ? true : false,
      "leidoPorElVendedor": chatRole == ChatRole.VENDEDOR ? true : false
    });
  }

  Future<void> solicitarCompra(Chat chat) {
    Map<String,dynamic> estadoMap = {
      "timestamp":FieldValue.serverTimestamp(),
      "estadoTransaccion":"Oferta",
      "emailRecipient":chat.vendedorEmail,
    };
    chatsReference.document(chat.uid).collection("estadoTransaccion").add(estadoMap);
//    chatsReference
//        .document(chat.uid)
//        .updateData({"estadoTransaccion": "Oferta"});
  }

  @override
  Future<void> cancelarSolicitudDeCompra(Chat chat){
    Map<String,dynamic> estadoMap = {
      "timestamp":FieldValue.serverTimestamp(),
      "estadoTransaccion":"Cancelada",
      "emailRecipient":chat.vendedorEmail,
    };
    chatsReference.document(chat.uid).collection("estadoTransaccion").add(estadoMap);
//    chatsReference
//        .document(chat.uid)
//        .updateData({"estadoTransaccion": "Pregunta"});
  }

  @override
  Future<void> aceptarSolicitudDeCompra(Chat chat) async {
    Map<String,dynamic> estadoMap = {
      "timestamp":FieldValue.serverTimestamp(),
      "estadoTransaccion":"Vendido",
      "emailRecipient":chat.compradorEmail,
    };
    chatsReference.document(chat.uid).collection("estadoTransaccion").add(estadoMap);
//    chatsReference
//        .document(chat.uid)
//        .updateData({"estadoTransaccion": "Vendido"});
//    QuerySnapshot otherDocuments = await chatsReference
//        .where("publicacionId", isEqualTo: chat.publicacionId)
//        .getDocuments();
//    otherDocuments.documents.forEach((document) {
//      if (document.documentID != chat.uid) {
//        chatsReference
//            .document(chat.uid)
//            .updateData({"estadoTransaccion": "Rechazada"});
//      }
//    });
  }

  @override
  Future<void> rechazarSolicitudDeCompra(Chat chat) {
    Map<String,dynamic> estadoMap = {
      "timestamp":FieldValue.serverTimestamp(),
      "estadoTransaccion":"Rechazada",
      "emailRecipient":chat.compradorEmail,
    };
    chatsReference.document(chat.uid).collection("estadoTransaccion").add(estadoMap);
//    chatsReference
//        .document(chat.uid)
//        .updateData({"estadoTransaccion": "Rechazada"});
  }

  @override
  Stream<List<Book>> searchBooks(User downloadedUser, List<String> list) {

    return booksCollectionGroupReference
        .where("indexes", arrayContainsAny: list)
        .where("vendido",isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Book.fromDocumentSnapshot(document))
            .toList());
  }

  @override
  Stream<List<Book>> searchBooksBySchool(User downloadedUser, List<String> list,String colegio) {

    return booksCollectionGroupReference
        .where("colegio",isEqualTo: colegio)
        .where("indexes", arrayContainsAny: list)
        .snapshots()
        .map((snapshot) => snapshot.documents
        .map((document) => Book.fromDocumentSnapshot(document))
        .toList());
  }

  @override
  Future<void> addToken(User user) async {
    String token = await _firebaseMessaging.getToken();
    usersReference
        .document(user.email)
        .collection('Tokens')
        .document('tokens')
        .updateData({
      'tokensList': FieldValue.arrayUnion([token])
    });
  }

  @override
  Future<void> removeToken(User user) async {
    String token = await _firebaseMessaging.getToken();
    usersReference
        .document(user.email)
        .collection('Tokens')
        .document('tokens')
        .updateData({
      'tokensList': FieldValue.arrayRemove([token])
    });
  }

  @override
  Future<void> addSchool(String name, String email) {

    return requestsReference.add({"email": email,"schoolName": name, "timestamp":FieldValue.serverTimestamp(),"type":"add_school"});
  }


}
