
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Book {
  String nombre,apellido,autor,categoria,editorial,emailVendedor,estado,nombreLibro,imageVendedor,isbn;
  List<dynamic> colegios = [];
  List<dynamic> cursos = [];
  List<dynamic> images = [];
  List<dynamic> thumbImages = [];
  bool vendido,infoCompleta,disponibleTodosColegios;
  String precio;

  Book();

  Book.fromDocumentSnapshot(DocumentSnapshot doc){
    this.nombre = doc['nombre']; //Idealmente estaria bueno cambiar este campo en la base de datos a nombreVendedor
    this.apellido = doc['apellido'];
    this.autor = doc['autor'];
    this.categoria = doc['categoria'];
    this.editorial = doc['editorial'];
    this.emailVendedor = doc['emailVendedor'];
    this.nombreLibro = doc['nombre del libro'];//Idealmente estaria bueno cambiar este campo en la base de datos a nombreLibro
    this.imageVendedor = doc['user image'];
    this.colegios = doc['colegios'];
    this.cursos = doc['cursos'];
    this.images = doc['images url'];
    this.thumbImages = doc['thumbs url'];
    this.vendido = doc['vendido'];
    this.infoCompleta = doc['infoCompleta'];
    this.disponibleTodosColegios = doc['disponibles para todos los colegios'];
    this.precio = doc['precio'];
    this.isbn = doc['isbn'];
    this.estado = doc['isbn'];
  }

  @override
  String toString() {
    return 'Book{nombre: $nombre, apellido: $apellido, autor: $autor, categoria: $categoria, editorial: $editorial, emailVendedor: $emailVendedor, estado: $estado, nombreLibro: $nombreLibro, imageVendedor: $imageVendedor, colegios: $colegios, cursos: $cursos, images: $images, thumbImages: $thumbImages, vendido: $vendido, infoCompleta: $infoCompleta, disponibleTodosColegios: $disponibleTodosColegios, precio: $precio, isbn: $isbn}';
  }


}