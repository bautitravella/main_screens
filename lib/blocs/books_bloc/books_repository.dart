import 'package:flutterui/Models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BooksRepository {

//BOOKS
  Future<void> addNewBook(Book book);

  Future<void> deleteBook(Book book);

  Stream<List<Book>> getAllBooks();

  Future<void> updateBook(Book todo);

}

class FirebaseBooksRepository extends BooksRepository{

  final booksReference = Firestore.instance.collection("Publicaciones");


  @override
  Future<void> addNewBook(Book book) {
    return booksReference.document().setData(book.toMap());
  }

  @override
  Future<void> deleteBook(Book book) {
    // TODO: implement deleteBook
    throw UnimplementedError();
  }

  @override
  Stream<List<Book>> getAllBooks() {
    // TODO: implement getAllBooks
    throw UnimplementedError();
  }

  @override
  Future<void> updateBook(Book todo) {
    // TODO: implement updateBook
    throw UnimplementedError();
  }

}