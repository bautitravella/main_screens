import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/precio_libro.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'dart:async';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class DatosLibros2 extends StatefulWidget {
  Book book;

  DatosLibros2(this.book);

  @override
  _DatosLibros2State createState() => _DatosLibros2State();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _DatosLibros2State extends State<DatosLibros2> {
  bool _isSelected = false;
  bool _isMarcked = false;
  bool _isTicked = false;

  bool _newBookCheckBox = false;
  bool _universidadCheckBox = false;
  bool _colegioCheckBox = false;

  TextEditingController nombreTextController = new TextEditingController(),
      editorialTextController = new TextEditingController(),
      autorTextController = new TextEditingController(),
      ISBNTextController = new TextEditingController(),
      descripcionTextController = new TextEditingController(),
      precioTextController = new TextEditingController();

  FirebaseAnalytics analytics;

  @override
  void initState() {
    analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/subir_libro/datos_libro");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<BooksBloc,BooksBlocState>(
          listener: (BuildContext context,state) async {
            print("STATE HAS CHANGED. STATE = ${state.toString()}");
            if(state is UploadingBook){
              showLoadingDialog(context);
            }else if(state is ErrorUploadingBook){
              Navigator.of(context).pop();
              showErrorDialog(context, "Ha habido un error cargando el libro a nuestra base de datos. ${state.errorMessage}");
            }else if(state is UploadedBook){
//               await Future.delayed(const Duration(milliseconds: 100));
//               Navigator.of(context).popUntil( ModalRoute.withName('/home'),);
              //todo cambiar este push por un popUntil como habia hecho en terminos y condiciones
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeHub()),
              );
            }

          },


          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
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
                                        height: 200,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10, top: 0),
                                            //height: 295,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 10, top: 5),
                                                  height: 160,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: widget.book.imagesRaw.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(right: 20),
                                                        child: Stack(
                                                          alignment: Alignment.center,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 140,
                                                              height: 140,
                                                              padding: EdgeInsets.all(5),
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  child: Image.memory(
                                                                    widget.book.imagesRaw[index],
                                                                    height: 140,
                                                                    width: 140,
                                                                  ) //(book.images[index]),
                                                              ),
                                                            ),
//                                                    Container(
//                                                      width: 55,
//                                                      height: 55,
//                                                      child: FlatButton(
//                                                          color: Colors.white54,
//                                                          shape: RoundedRectangleBorder(
//                                                            borderRadius: BorderRadius.all(Radius.circular(100)),
//                                                          ),
//                                                          child: Icon(
//                                                            Icons.edit,
//                                                            color: Colors.white,
//                                                            size: 25,
//                                                          ),
//                                                          onPressed: () {
//                                                            loadAssets();
//                                                          }),
//                                                    )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                /* Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                      RaisedButton(child: Text('Editar fotos elegidas'),onPressed: () => loadAssets()),
                  ],
                  )*/
                                              ],
                                            ))
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(
                                    "Completa los datos \ndel libro",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 53, 38, 65),
                                      fontFamily: "Montserrat",
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
                                      fontFamily: "Montserrat",
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
                                    "ESTE LIBRO SE PUBLICARÁ...",
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
                                      'Solo se publicará el libro dentro del colegio predeterminado.',
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
                                    top: 10,
                                  ),
                                  child: CheckboxListTile(
                                    title: const Text(
                                      'Se publicará en  todos los colegios.',
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
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      width: SizeConfig.blockSizeHorizontal*80,
                                      height: 100,
                                      margin: EdgeInsets.only(left: 4, right: 4, top: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                width: SizeConfig.blockSizeHorizontal * 35,
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
    }
    widget.book.nombreLibro = nombreLibro;
    widget.book.autor = autor;
    widget.book.descripcion = descripcion;
    widget.book.precio = num.parse(precio);
    widget.book.publico = _isTicked;
    if(editorial != null && editorial.isNotEmpty) widget.book.editorial = editorial;
    if(ISBN != null && ISBN.isNotEmpty) widget.book.isbn = int.parse(ISBN);
    print("todos los campos estan completos");
    analytics.logEvent(name: "finish_subir_libro");
    BlocProvider.of<BooksBloc>(context).add(AddBook(widget.book));
//    uploadBook().then((smt) => Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => MyBooksView()),
//    ));
  }

  Future uploadBook() async {
    try {
      uploadBookImages().then((urlList) => {
        urlList.forEach((url) {
          widget.book.imagesUrl.add(url);
        }),
        uploadBookInfo(),
      });
    } catch (error) {
      showSlideDialogChico(
          context: context,
          child: /*LoadingDialog()*/
          ErrorDialog(
            title: "Oops...",
            error: "Parece que no has completado todos los datos. " + error.toString(),
          )
        // barrierColor: Colors.white.withOpacity(0.7),
        // pillColor: Colors.red,
        // backgroundColor: Colors.yellow,
      );

    }

    return Future.delayed(Duration(seconds: 60));
  }

  Future<List<String>> uploadBookImages() async {
    List<String> urlList = [];
    for(int i = 0; i< widget.book.imagesRaw.length -1; i++){
      urlList.add(await uploadBookImage(i));
    }
    return urlList;
  }

  Future uploadBookImage(int i) async {
    StorageReference ref =
    FirebaseStorage.instance.ref().child("publicaciones_images2/foto" + i.toString() + ".jpg");
    StorageUploadTask uploadTask = ref.putData(widget.book.imagesRaw[i]);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
    (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
  }

  uploadBookInfo() {
    Firestore.instance
        .collection('books')
        .document()
        .setData(widget.book.toMap())
        .then((value) => print("se mando bien la info a firebase" ))
        .catchError((err) => print("HUBO UN ERROR 2"));
  }
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}