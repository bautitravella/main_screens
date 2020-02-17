import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Book {
  String nombre,
      apellido,
      autor,
      categoria,
      editorial,
      emailVendedor,
      estado,
      nombreLibro,
      imageVendedor,
      isbn;
  List<dynamic> colegios = [];
  List<dynamic> cursos = [];
  List<File> imagesRaw = [];
  List<dynamic> imagesUrl = [];
  List<CachedNetworkImage> images = [];
  List<dynamic> thumbImagesUrl = [];
  List<CachedNetworkImage> thumbImages = [];
  List<String> materias = [];
  bool vendido, infoCompleta, disponibleTodosColegios;
  String precio;
  num rating;

  Book();

  Book.fromDocumentSnapshot(DocumentSnapshot doc) {
    this.nombre = doc[
        'nombre']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreVendedor
    this.apellido = doc['apellido'];
    this.autor = doc['autor'];
    this.categoria = doc['categoria'];
    this.editorial = doc['editorial'];
    this.emailVendedor = doc['emailVendedor'];
    this.nombreLibro = doc[
        'nombre del libro']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreLibro
    this.imageVendedor = doc['user image'];
    this.colegios = doc['colegios'];
    this.cursos = doc['cursos'];
    this.imagesUrl = doc['images url'];
    this.thumbImages = doc['thumbs url'];
    this.vendido = doc['vendido'];
    this.infoCompleta = doc['infoCompleta'];
    this.disponibleTodosColegios = doc['disponibles para todos los colegios'];
    this.precio = doc['precio'];
    this.isbn = doc['isbn'];
    this.estado = doc['isbn'];
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
    return 'Book{nombre: $nombre, apellido: $apellido, autor: $autor, categoria: $categoria, editorial: $editorial, emailVendedor: $emailVendedor, estado: $estado, nombreLibro: $nombreLibro, imageVendedor: $imageVendedor, colegios: $colegios, cursos: $cursos, images: $images, thumbImages: $thumbImages, vendido: $vendido, infoCompleta: $infoCompleta, disponibleTodosColegios: $disponibleTodosColegios, precio: $precio, isbn: $isbn}';
  }

  List<dynamic> getImages() {
    return null;
  }
}

List<Book> books = [Book()];
