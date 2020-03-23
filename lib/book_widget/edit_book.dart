import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/uploads_bloc/bloc.dart';
import 'package:flutterui/book_widget/editar_colegio_libro.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/precio_libro.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'dart:async';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class EditBookWidget extends StatefulWidget {
  Book book;

  EditBookWidget(this.book);

  @override
  _EditBookWidgetState createState() => _EditBookWidgetState();
}

class _EditBookWidgetState extends State<EditBookWidget> {
  bool _isSelected = false;
  bool _isMarcked = false;
  bool _isTicked = false;

  List<Asset> images = [];
  String _error;

  TextEditingController nombreTextController = new TextEditingController(),
      editorialTextController = new TextEditingController(),
      autorTextController = new TextEditingController(),
      ISBNTextController = new TextEditingController(),
      descripcionTextController = new TextEditingController(),
      precioTextController = new TextEditingController();

  bool imagesChanged = false;
  Book clonedBook;

  @override
  void initState() {
    nombreTextController.text = widget.book.nombreLibro;
    autorTextController.text = widget.book.autor;
    descripcionTextController.text = widget.book.descripcion;
    precioTextController.text = widget.book.precio.toString();
    if(widget.book.editorial != null)editorialTextController.text = widget.book.editorial;
    if(widget.book.isbn != null) ISBNTextController.text = widget.book.isbn.toString();
    clonedBook = widget.book.clone();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UploadsBloc,UploadsBlocState>(
          listener: (BuildContext context,state) async {
            print("STATE CHANGE EDIT BOOK. STATE = ${state.toString()}");
            if(state is InitialUploadsBlocState){
//              showLoadingDialog(context);
            }else if(state is BookEdited){
//              Navigator.popUntil(
//                context,
//                ModalRoute.withName('/home'),
//              );
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);

            }else if(state is FailedToEdit){
              showErrorDialog(context, "Ha habido un error cargando el libro a nuestra base de datos. ${state.errorMessage}");
            }else if(state is EditingState){
              showLoadingDialog(context);
            }

          },


          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: AppColors.accentText,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 28, top: 24),
                    child: Text(
                      "Vender",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Gibson",
                        color: AppColors.accentText,
                        fontWeight: FontWeight.w600,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          width: 50,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 8,
                              right: SizeConfig.blockSizeHorizontal * 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 150,
                                    margin: EdgeInsets.only(top: 5),
                                    child: _imagesListBuilder()
//                                    Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Container(
//                                          width: 97,
//                                          child: Stack(
//                                            children: <Widget>[
//                                              ClipRRect(
//                                                borderRadius:
//                                                BorderRadius.circular(10),
//                                                child: Image(
//                                                  height: 141,
//                                                  width: 97,
//                                                  image: AssetImage("assets/images/bookdescarte.png"),
//                                                  fit: BoxFit.cover,
//                                                ),
//                                              ),
//                                              Center(
//                                                child: Container(
//                                                  width: 40,
//                                                  height: 40,
//                                                  decoration: BoxDecoration(
//                                                      boxShadow: [
//                                                        BoxShadow(
//                                                          color: Colors.black26,
//                                                          offset: Offset(0.0, 2.0),
//                                                          blurRadius: 6.0,
//                                                        )
//                                                      ],
//                                                      color: Colors.white,
//                                                      borderRadius: new BorderRadius.circular(100)),
//                                                  child: OutlineButton(
//                                                      padding: EdgeInsets.symmetric(horizontal: 5),
//                                                      borderSide: BorderSide(color: AppColors.secondaryBackground, width: 2),
//                                                      shape: RoundedRectangleBorder(
//                                                        borderRadius: BorderRadius.all(Radius.circular(100)),
//                                                      ),
//                                                      child: Icon(
//                                                        Icons.edit,
//                                                        color: AppColors.secondaryBackground,
//                                                        size: 20,
//                                                      ),
//                                                      onPressed: () {}),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                        Center(
//                                          child: Container(
//                                            width: 97,
//                                            child: Stack(
//                                              children: <Widget>[
//                                                ClipRRect(
//                                                  borderRadius: BorderRadius.circular(10),
//                                                  child: Image(
//                                                    height: 141,
//                                                    width: 97,
//                                                    image: AssetImage("assets/images/bookdescarte.png"),
//                                                    fit: BoxFit.cover,
//                                                  ),
//                                                ),
//                                                Center(
//                                                  child: Container(
//                                                    width: 40,
//                                                    height: 40,
//                                                    decoration: BoxDecoration(
//                                                        boxShadow: [
//                                                          BoxShadow(
//                                                            color: Colors.black26,
//                                                            offset: Offset(0.0, 2.0),
//                                                            blurRadius: 6.0,
//                                                          )
//                                                        ],
//                                                        color: Colors.white,
//                                                        borderRadius: new BorderRadius.circular(100)),
//                                                    child: OutlineButton(
//                                                        padding: EdgeInsets.symmetric(horizontal: 5),
//                                                        borderSide: BorderSide(
//                                                            color: AppColors.secondaryBackground, width: 2),
//                                                        shape: RoundedRectangleBorder(
//                                                          borderRadius: BorderRadius.all(Radius.circular(100)),
//                                                        ),
//                                                        child: Icon(
//                                                          Icons.edit,
//                                                          color: AppColors.secondaryBackground,
//                                                          size: 20,
//                                                        ),
//                                                        onPressed: () {}),
//                                                  ),
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                        Container(
//                                          width: 97,
//                                          child: Stack(
//                                            children: <Widget>[
//                                              ClipRRect(
//                                                borderRadius:
//                                                BorderRadius.circular(10),
//                                                child: Image(
//                                                  height: 141,
//                                                  width: 97,
//                                                  image: AssetImage(
//                                                      "assets/images/bookdescarte.png"),
//                                                  fit: BoxFit.cover,
//                                                ),
//                                              ),
//                                              Center(
//                                                child: Container(
//                                                  width: 40,
//                                                  height: 40,
//                                                  decoration: BoxDecoration(
//                                                      boxShadow: [
//                                                        BoxShadow(
//                                                          color: Colors.black26,
//                                                          offset: Offset(0.0, 2.0),
//                                                          blurRadius: 6.0,
//                                                        )
//                                                      ],
//                                                      color: Colors.white,
//                                                      borderRadius:
//                                                      new BorderRadius.circular(
//                                                          100)),
//                                                  child: OutlineButton(
//                                                      padding: EdgeInsets.symmetric(
//                                                          horizontal: 5),
//                                                      borderSide: BorderSide(
//                                                          color: AppColors.secondaryBackground,
//                                                          width: 2),
//                                                      shape: RoundedRectangleBorder(
//                                                        borderRadius: BorderRadius.all(Radius.circular(100)),
//                                                      ),
//                                                      child: Icon(
//                                                        Icons.edit,
//                                                        color: AppColors.secondaryBackground,
//                                                        size: 20,
//                                                      ),
//                                                      onPressed: () {}),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Center(
                                  child: RaisedButton(
                                    child: Text('Cambiar Imagenes'),
                                    //Todo cuando se clickee que tambien se aabra lo de seleccionar imagenes
                                    onPressed: () {
                                      loadAssets();
                                      imagesChanged = true;
                                      },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Completa los datos \ndel libro",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 38, 65),
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Asegúrate de escribir correctamente \nlos datos del libro que vallas a vender.",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 38, 65),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      margin: EdgeInsets.only(top: 40),
                                      child: Opacity(
                                        opacity: 0.63,
                                        child: TextField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: "NOMBRE",
                                            contentPadding: EdgeInsets.only(top: 30),
                                            border: InputBorder.none,
                                          ),
                                          controller: nombreTextController,
                                          textCapitalization: TextCapitalization.sentences,
                                          style: TextStyle(
                                            color: Color.fromARGB(180, 69, 79, 99),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                    ),
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Opacity(
                                        opacity: 0.63,
                                        child: TextField(
                                          textCapitalization: TextCapitalization.words,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: "AUTOR",
                                            contentPadding: EdgeInsets.only(top: 30),
                                            border: InputBorder.none,
                                          ),
                                          controller: autorTextController,
                                          style: TextStyle(
                                            color: Color.fromARGB(180, 69, 79, 99),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                    ),
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Opacity(
                                        opacity: 0.63,
                                        child: TextField(
                                          textCapitalization: TextCapitalization.words,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: "EDITORIAL",
                                            contentPadding: EdgeInsets.only(top: 30),
                                            border: InputBorder.none,
                                          ),
                                          controller: editorialTextController,
                                          style: TextStyle(
                                            color: Color.fromARGB(180, 69, 79, 99),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                    ),
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Opacity(
                                        opacity: 0.63,
                                        child: TextField(
                                          textCapitalization: TextCapitalization.words,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: "ISBN",
                                            contentPadding: EdgeInsets.only(top: 30),
                                            border: InputBorder.none,
                                          ),
                                          controller: ISBNTextController,
                                          style: TextStyle(
                                            color: Color.fromARGB(180, 69, 79, 99),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Text(
                                  "Comenta sobre el \nlibro",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 38, 65),
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Escribe una breve descripción \ndel estado en el que se encuentra el libro a vender.",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 53, 38, 65),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              Container(
                                height: 205,
                                margin: EdgeInsets.only(top: 20),
                                child: ListView(
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        TextField(
                                          textCapitalization: TextCapitalization.sentences,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: "Descripcion",
                                            border: InputBorder.none,
                                          ),
                                          controller: descripcionTextController,
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 69, 79, 99),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              height: 2.1),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          autocorrect: true,
                                        ),
                                        Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 50),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                              Container(
                                                color:
                                                Color.fromARGB(255, 69, 79, 99),
                                                height: 2,
                                                margin: EdgeInsets.only(top: 40),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //CHECKBOX ES NUEVO
                                margin: EdgeInsets.only(left: 6, right: 4, top: 15),
                                child: CheckboxListTile(
                                  title: const Text(
                                    'Dale "tick" si es que el libro es nuevo',
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  value: _isSelected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isSelected = newValue;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  "ESTE LIBRO SE PUBLICARA...",
                                  style: TextStyle(
                                    color: Color.fromARGB(180, 69, 79, 99),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                    letterSpacing: -0.41786,
                                  ),
                                ),
                              ),
                              Container(
                                //CHECKBOX SOLO DE PULICARA EL LIBRO DENTRO...
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(left: 0),
                                child: CheckboxListTile(
                                  title: const Text(
                                    'Solo se publicara el libro dentro del colegio predeterminado.',
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  value: _isMarcked,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isMarcked = newValue;
                                      _isTicked = false;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 30,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                        color: Colors.black38,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        textColor: Color.fromARGB(255, 255, 255, 255),
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Cambiar \ncursos",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.secondaryText,
                                                fontFamily: "Sf-r",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Icon(Icons.supervised_user_circle, color: Colors.white, size: 30,)
                                          ],
                                        ),
                                        onPressed: () => []),
                                    SizedBox(width: 10),
                                    FlatButton(
                                        color: Colors.black38,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        textColor: Color.fromARGB(255, 255, 255, 255),
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 12),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Cambiar \ncolegios",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.secondaryText,
                                                fontFamily: "Sf-r",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Image.asset("assets/images/group-1840.png",
                                            height: 30,)
                                          ],
                                        ),
                                        onPressed: () =>EditarColegioLibro),
                                    SizedBox(width: 10),
                                    FlatButton(
                                        color: Colors.black38,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        textColor: Color.fromARGB(255, 255, 255, 255),
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 12),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Cambiar \nmaterias",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.secondaryText,
                                                fontFamily: "Sf-r",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Icon(Icons.collections_bookmark, color: Colors.white, size: 30,)
                                          ],
                                        ),
                                        onPressed: () => []),
                                  ],
                                )
                                /* CheckboxListTile(
                                  title: const Text(
                                    'Se publicara en  todos los colegios.',
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  value: _isTicked,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isTicked = newValue;
                                      _isMarcked = false;
                                    });
                                  },
                                ),*/
                              ),
                              Center(
                                child: Container(
                                    width: 215,
                                    height: 100,
                                    margin:
                                    EdgeInsets.only(left: 4, right: 4, top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
                                          size: 60.0,
                                          color: Color.fromARGB(255, 112, 112, 112),
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 80,
                                              width:
                                              SizeConfig.blockSizeHorizontal * 35,
                                              child: TextField(
                                                controller: precioTextController,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  hintText: "PRECIO",
                                                  hintStyle: TextStyle(
                                                    color:
                                                    Color.fromARGB(20, 0, 0, 0),
                                                  ),
                                                  contentPadding:
                                                  EdgeInsets.only(top: 20),
                                                  border: InputBorder.none,
                                                ),
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 112, 112, 112),
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 30,
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              child: Container(
                                                color: Color.fromARGB(
                                                    105, 112, 112, 112),
                                                height: 2,
                                                width:
                                                SizeConfig.blockSizeHorizontal *
                                                    35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              bottom: 20,
                              top: 30,
                              left: SizeConfig.blockSizeHorizontal * 65),
                          child: FlatButton(
                              color: AppColors.secondaryElement,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons-back-light-2.png",
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Siguiente",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () => _siguienteBtn()),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _siguienteBtn() {

    String nombreLibro = nombreTextController.text;
    String autor = autorTextController.text;
    String editorial = editorialTextController.text;
    String ISBN = ISBNTextController.text;
    String descripcion = descripcionTextController.text;
    String precio = precioTextController.text;

    if (nombreLibro == null ||
        nombreLibro.isEmpty ||
        autor == null ||
        autor.isEmpty ||
        descripcion == null ||
        descripcion.isEmpty ||
        precio == null ||
        precio.isEmpty ||
        (_isMarcked == false && _isTicked == false)) {
      //TODO agregar dialog con el error
      showErrorDialog(context, "Para continuar debes completar todos los campos");
      print("falta completar algun campo");
      return null;
    }else if (images.length <  3 && imagesChanged) {
      showErrorDialog(context,
          "Debes seleccionar como minimo 3 imagenes para poder continuar");
    } else {
      showLoadingDialog(context);
      List<Future<ByteData>> futuresList = [];
      List<Future<ByteData>> futuresThumbsList = [];
      images.forEach((image) async{

        futuresList.add(image.getByteData());
        //List<int> imageData = byteData.buffer.asUint8List();

        futuresThumbsList.add(image.getThumbByteData(500, 500,quality: 50));

      });

      Future.wait([
        Future.wait(futuresList).then((value) => value.forEach((element) { clonedBook.imagesRaw.add(element.buffer.asUint8List());})),
        Future.wait(futuresThumbsList).then((value) => value.forEach((element) { clonedBook.imagesRawThumb.add(element.buffer.asUint8List());})),
      ]).then((smt) {
        Navigator.pop(context);
        clonedBook.nombreLibro = nombreLibro;
        clonedBook.autor = autor;
        clonedBook.descripcion = descripcion;
        clonedBook.precio = num.parse(precio);
        clonedBook.publico = _isTicked;
        if (editorial != null && editorial.isNotEmpty)
          clonedBook.editorial = editorial;
        if (ISBN != null && ISBN.isNotEmpty) clonedBook.isbn = int.parse(ISBN);
        print("todos los campos estan completos");
        if (clonedBook != widget.book &&
            imagesChanged) { //en este caso se modificaron datos del libro e imagenes
          print("11111111111111111111111111111111111111111111111111");
          BlocProvider.of<UploadsBloc>(context).add(EditBook(clonedBook));
        } else
        if (imagesChanged) { //en este caso solo se modificaron las imagenes del libro
          print('2222222222222222222222222222222222222222222222222222');
          BlocProvider.of<UploadsBloc>(context).add(EditBookImages(clonedBook));
        } else if (clonedBook != widget
            .book) { //en este caso se modificaron solo los datos del libro
          print('333333333333333333333333333333333333333333333333333333');
          BlocProvider.of<UploadsBloc>(context).add(EditBookInfo(clonedBook));
        } else { //en este caso
          print('444444444444444444444444444444444444444444444444444444444444');
          Navigator.of(context).pop();
        }
        //TODO cambiar este BlocProvider por otro que llame a update book
        //BlocProvider.of<BooksBloc>(context).add(AddBook(widget.book));
//    uploadBook().then((smt) => Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => MyBooksView()),
//    ));
      });
    }
    }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList = [];
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  static Widget horizontalPhotos(Book book) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: book.imagesUrl.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            width: 95,
            margin: EdgeInsets.only(right: 35),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: book.getImages() != null && book.getImages().length > 0? //book.images[0],
              Image(
                image: book.getImages()[index],
                fit: BoxFit.cover,
              )
                  :
              CircularProgressIndicator(),

            ),
          );
        },
      ),
    );
  }

  _imagesListBuilder() {
    return images.length == 0
        ? horizontalPhotos(widget.book)
        : Container(
        margin: EdgeInsets.only(left: 22, top: 0),
        //height: 295,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 22, top: 60),
              height: 225,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 180,
                    width: 123,
                    margin: EdgeInsets.only(right: 30),
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: AssetThumb(
                          asset: images[index],
                          height: 1300,
                          width: 1300,
                        ) //(book.images[index]),
                    ),
                  );
                },
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                RaisedButton(child: Text('Editar fotos elegidas'),onPressed: () => loadAssets()),
              ],
            )
          ],
        ));
  }
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}