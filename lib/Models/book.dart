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
      imageVendedor;
  List<dynamic> colegios = [];
  List<dynamic> cursos = [];
  List<File> imagesRaw = [];
  List<dynamic> imagesUrl = [];
  List<CachedNetworkImage> images = [];
  List<dynamic> thumbImagesUrl = [];
  List<CachedNetworkImage> thumbImages = [];
  List<String> materias = [];
  List<String> indexes = [];
  bool vendido, publico;
  int precio,isbn;
  num rating;

  Book();

  Book.fromDocumentSnapshot(DocumentSnapshot doc) {
    this.nombreVendedor = doc[
        'nombre']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreVendedor
    this.apellidoVendedor = doc['apellido'];
    this.autor = doc['autor'];
    this.categoria = doc['categoria'];
    this.editorial = doc['editorial'];
    this.emailVendedor = doc['emailVendedor'];
    this.nombreLibro = doc[
        'nombreLibro']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreLibro
    this.imageVendedor = doc['user image'];
    this.colegios = doc['colegios'];
    this.cursos = doc['cursos'];
    this.imagesUrl = doc['imagesUrl'];
    this.thumbImagesUrl = doc['thumbsUrl'];
    this.vendido = doc['vendido'];
    this.publico = doc['publico'];
    this.precio = doc['precio'];
    this.isbn = doc['isbn'];
    this.descripcion = doc['estado'];
    imagesUrl.forEach((element) {
      images.add(CachedNetworkImage(
        imageUrl: element,
        placeholder: (context, url) => CircularProgressIndicator(),
      ));
    });
    thumbImagesUrl.forEach((element) {
      thumbImages.add(CachedNetworkImage(
        imageUrl: element,
        placeholder: (context, url) => CircularProgressIndicator(),
      ));
    });
  }

  @override
  String toString() {
    return 'Book{nombreVendedor: $nombreVendedor, apellidoVendedor: $apellidoVendedor, autor: $autor, categoria: $categoria, editorial: $editorial, emailVendedor: $emailVendedor, descripcion: $descripcion, nombreLibro: $nombreLibro, imageVendedor: $imageVendedor, colegios: $colegios, cursos: $cursos, images: $images, thumbImages: $thumbImages, vendido: $vendido, publico: $publico, precio: $precio, isbn: $isbn}';
  }

  List<dynamic> getImages() {
    return null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> bookMap = Map();
    bookMap['nombreVendedor'] = nombreVendedor;
    bookMap['apellidoVendedor'] = apellidoVendedor;
    bookMap['emailVendedor'] = emailVendedor;
    bookMap['imageVendedor'] = imageVendedor;
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
    //bookMap['indexes'] = indexes;
    bookMap['imagesUrl'] = imagesUrl;
    if( thumbImagesUrl != null && thumbImagesUrl.length != 0){
     // bookMap['thumbsUrl'] = thumbImagesUrl;
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
    this.imageVendedor = user.fotoPerfilUrl;
    this.colegios = user.getColegios();
  }
}

List<Book> books = [Book()];
