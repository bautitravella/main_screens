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
  List<String> colegios = [];
  List<String> cursos = [];
  List<List<int>> imagesRaw = [];
  List<List<int>> imagesRawThumb = [];
  List<String> imagesUrl = [];
  List<CachedNetworkImageProvider> _images = [];
  List<String> thumbImagesUrl = [];
  List<CachedNetworkImageProvider> _thumbImages = [];
  List<String> materias = [];
  List<String> indexes;
  List<String> palabrasImportantes;
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
    this._images = book._images;
    this.thumbImagesUrl = book.thumbImagesUrl;
    this._thumbImages = book._thumbImages;
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
        'nombreLibro'];
    this.imageVendedorUrl = doc['imageVendedor'];
    imageVendedor = CachedNetworkImageProvider(imageVendedorUrl);
    doc['colegios'].forEach((item) {
      this.colegios.add(item.toString());
    });
    doc['cursos'].forEach((item) {
      this.cursos.add(item.toString());
    });
    doc['materias'].forEach((item) {
      this.materias.add(item.toString());
    });
    doc['imagesUrl'].forEach((item) {
      this.imagesUrl.add(item.toString());
    });
    this.vendido = doc['vendido'];
    this.publico = doc['publico'];
    this.precio = doc['precio'];
    this.isbn = doc['isbn'];
    this.descripcion = doc['descripcion'];
//    imagesUrl.forEach((element) {
//      images.add(CachedNetworkImageProvider(
////        imageUrl: element,
////        placeholder: (context, url) => CircularProgressIndicator(),
////        fit: BoxFit.fill,
//      element));
//    });
    if(doc['thumbsUrl'] != null ) {
      doc['thumbsUrl'].forEach((item) {
        this.thumbImagesUrl.add(item.toString());
      });
//      thumbImagesUrl.forEach((element) {
//        _thumbImages.add(CachedNetworkImageProvider(
//            element));
//      });
    }

    this.uid = doc.documentID;
  }

  @override
  String toString() {
    return 'Book{nombreVendedor: $nombreVendedor, apellidoVendedor: $apellidoVendedor, autor: $autor, categoria: $categoria, editorial: $editorial, emailVendedor: $emailVendedor, descripcion: $descripcion, nombreLibro: $nombreLibro, imageVendedor: $imageVendedor, colegios: $colegios, cursos: $cursos, images: $_images, thumbImages: $_thumbImages, vendido: $vendido, publico: $publico, precio: $precio, isbn: $isbn}';
  }

  List<ImageProvider> getImages() {
    if(thumbImagesUrl != null && thumbImagesUrl.length != 0){
      if(_thumbImages.length  != thumbImagesUrl.length){
        for(int i= 0; i< thumbImagesUrl.length;i++){
          if(_thumbImages.length < i+1){
            _thumbImages.add(CachedNetworkImageProvider(thumbImagesUrl[i]));
          }
        }
      }
      return _thumbImages;
    }else if(imagesUrl != null && imagesUrl.length!= 0){

      if(_images.length  != imagesUrl.length){
        for(int i= 0; i< imagesUrl.length;i++){
          if(_images.length < i+1){
            _images.add(CachedNetworkImageProvider(imagesUrl[i]));
          }
        }
      }
      return _images;
    }
    return [AssetImage(
      "assets/images/icons-back-light-2.png",
    )];
  }

  ImageProvider getFirstImageThumb(){
    if(thumbImagesUrl != null && thumbImagesUrl.length != 0){
      if(_thumbImages.length == 0){
        _thumbImages.add(CachedNetworkImageProvider(thumbImagesUrl.first));
      }
      return _thumbImages.first;

    }else if(imagesUrl!= null && imagesUrl.length != 0){
      if(_images.length == 0){
        _images.add(CachedNetworkImageProvider(imagesUrl.first));
      }
      return _images.first;
    }
    return AssetImage(
      "assets/images/icons-back-light-2.png",
    );
  }

  List<ImageProvider> getHighResImages(){
    if(_images != null && _images.length > 0 ){
      if(_images.length  != imagesUrl.length){
        for(int i= 0; i< imagesUrl.length;i++){
          if(_images.length < i+1){
            _images.add(CachedNetworkImageProvider(imagesUrl[i]));
          }
        }
      }
      return _images;
    }
    return [AssetImage(
      "assets/images/icons-back-light-2.png",
    )];
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
    if(palabrasImportantes!= null && palabrasImportantes.length != 0)bookMap['palabrasImportantes']=palabrasImportantes;

    return bookMap;
  }

  addUserInformation(User user){
    this.nombreVendedor = user.nombre;
    this.apellidoVendedor = user.apellido;
    this.emailVendedor = user.email;
    this.imageVendedorUrl = user.fotoPerfilUrl;
  }

  void createIndexes(){
    indexes = [];
    palabrasImportantes = [];
    List<String> bookSplitList = this.nombreLibro.split(" ");
    for (var value in this.autor.split(" ")) {
      bookSplitList.add(value);
    }


    for (int i = 0; i < bookSplitList.length; i++) {
      for (int j = 2; j < bookSplitList[i].length + 1; j++) {
        indexes.add(bookSplitList[i].substring(0, j).toLowerCase());
      }
      if(bookSplitList[i].length >2 && bookSplitList[i] != "El" && bookSplitList[i] != "La" && bookSplitList[i] != "The" && bookSplitList[i] != "Las"){
        palabrasImportantes.add(bookSplitList[i]);
      }
    }
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
