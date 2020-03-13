import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutterui/Models/User.dart';

class Book {
  String nombreVendedor,
      apellidoVendedor,
      autor,
      categoria = "Libros",
      editorial,
      emailVendedor,
      descripcion,
      nombreLibro,
      imageVendedorUrl,uid;
  CachedNetworkImageProvider imageVendedor;
  List<dynamic> colegios = [];
  List<dynamic> cursos = [];
  List<List<int>> imagesRaw = [];
  List<List<int>> imagesRawThumb = [];
  List<dynamic> imagesUrl = [];
  List<CachedNetworkImageProvider> images = [];
  List<dynamic> thumbImagesUrl = [];
  List<CachedNetworkImageProvider> thumbImages = [];
  List<String> materias = [];
  List<String> indexes = [];
  bool vendido, publico;
  int precio,isbn;
  num rating;

  Book();

  Book.fromCloning(Book book){
    this.nombreVendedor = book.nombreVendedor;
    this.apellidoVendedor = book.apellidoVendedor;
    this.autor = book.autor;
    this.categoria = book.categoria;
    this.editorial = book.editorial;
    this.emailVendedor = book.emailVendedor;
    this.descripcion = book.descripcion;
    this.nombreLibro = book.nombreLibro;
    this.imageVendedorUrl = book.imageVendedorUrl;
    this.uid = book.uid;
    this.imageVendedor = book.imageVendedor;
    this.colegios = book.colegios;
    this.cursos = book.cursos;
    this.imagesRaw = book.imagesRaw;
    this.imagesRawThumb = book.imagesRawThumb;
    this.imagesUrl = book.imagesUrl;
    this.images = book.images;
    this.thumbImagesUrl = book.thumbImagesUrl;
    this.thumbImages = book.thumbImages;
    this.materias = book.materias;
    this.indexes = book.indexes;
    this.vendido = book.vendido;
    this.precio = book.precio;
    this.isbn = book.isbn;
    this.rating = book.rating;
  }

  Book.fromDocumentSnapshot(DocumentSnapshot doc) {
    this.nombreVendedor = doc[
        'nombreVendedor']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreVendedor
    this.apellidoVendedor = doc['apellidoVendedor'];
    this.autor = doc['autor'];
    this.categoria = doc['categoria'];
    this.editorial = doc['editorial'];
    this.emailVendedor = doc['emailVendedor'];
    this.nombreLibro = doc[
        'nombreLibro']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreLibro
    this.imageVendedorUrl = doc['imageVendedor'];
    imageVendedor = CachedNetworkImageProvider(imageVendedorUrl);
    this.colegios = doc['colegios'];
    this.cursos = doc['cursos'];
    this.imagesUrl = doc['imagesUrl'];
    //todo volver a habilitar los thumbs

    this.vendido = doc['vendido'];
    this.publico = doc['publico'];
    this.precio = doc['precio'];
    this.isbn = doc['isbn'];
    this.descripcion = doc['descripcion'];
    imagesUrl.forEach((element) {
      images.add(CachedNetworkImageProvider(
//        imageUrl: element,
//        placeholder: (context, url) => CircularProgressIndicator(),
//        fit: BoxFit.fill,
      element));
    });
    if(doc['thumbsUrl'] != null ) {
      this.thumbImagesUrl = doc['thumbsUrl'];
      thumbImagesUrl.forEach((element) {
        thumbImages.add(CachedNetworkImageProvider(
            element));
      });
    }

    this.uid = doc.documentID;
  }

  @override
  String toString() {
    return 'Book{nombreVendedor: $nombreVendedor, apellidoVendedor: $apellidoVendedor, autor: $autor, categoria: $categoria, editorial: $editorial, emailVendedor: $emailVendedor, descripcion: $descripcion, nombreLibro: $nombreLibro, imageVendedor: $imageVendedor, colegios: $colegios, cursos: $cursos, images: $images, thumbImages: $thumbImages, vendido: $vendido, publico: $publico, precio: $precio, isbn: $isbn}';
  }

  List<CachedNetworkImageProvider> getImages() {
    if(thumbImages != null && thumbImages.length > 0){
      return thumbImages;
    }else if(images != null && images.length > 0 ){
      return images;
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> bookMap = Map();
    bookMap['nombreVendedor'] = nombreVendedor;
    bookMap['apellidoVendedor'] = apellidoVendedor;
    bookMap['emailVendedor'] = emailVendedor;
    bookMap['imageVendedor'] = imageVendedorUrl;
    bookMap['vendido'] = vendido;
    bookMap['publico'] = publico;
    bookMap['precio'] = precio;
    bookMap['nombreLibro'] = nombreLibro;
    bookMap['autor'] = autor;
    if(editorial != null) bookMap['editorial'] = editorial;
    bookMap['descripcion'] = descripcion;
    bookMap['categoria'] = categoria;
    bookMap['materias'] = materias;
    bookMap['colegios'] = colegios;
    bookMap['cursos'] = cursos;
    if(indexes != null && indexes.length > 0) bookMap['indexes'] = indexes;
    bookMap['imagesUrl'] = imagesUrl;
    if( thumbImagesUrl != null && thumbImagesUrl.length != 0){
      bookMap['thumbsUrl'] = thumbImagesUrl;
    }
    if (isbn != null) {
      bookMap['isbn'] = isbn;
    }
    if(rating != null){
      bookMap['rating'] = rating;
    }

    return bookMap;
  }

  addUserInformation(User user){
    this.nombreVendedor = user.nombre;
    this.apellidoVendedor = user.apellido;
    this.emailVendedor = user.email;
    this.imageVendedorUrl = user.fotoPerfilUrl;
  }

  Book clone(){
    return Book.fromCloning(this);
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Book &&
              runtimeType == other.runtimeType &&
              nombreVendedor == other.nombreVendedor &&
              apellidoVendedor == other.apellidoVendedor &&
              autor == other.autor &&
              categoria == other.categoria &&
              editorial == other.editorial &&
              emailVendedor == other.emailVendedor &&
              descripcion == other.descripcion &&
              nombreLibro == other.nombreLibro &&
              imageVendedorUrl == other.imageVendedorUrl &&
              uid == other.uid &&
              colegios == other.colegios &&
              cursos == other.cursos &&
              imagesUrl == other.imagesUrl &&
              thumbImagesUrl == other.thumbImagesUrl &&
              materias == other.materias &&
              indexes == other.indexes &&
              vendido == other.vendido &&
              publico == other.publico &&
              precio == other.precio &&
              isbn == other.isbn &&
              rating == other.rating;


  @override
  int get hashCode => uid.hashCode;






}

List<Book> books = [Book()];
