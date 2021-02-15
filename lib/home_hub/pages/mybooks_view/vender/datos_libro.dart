import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/AlumnoUniversitario.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/WidgetsCopy/dropdown_magic.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/add_subject_school.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'dart:async';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class DatosLibros extends StatefulWidget {
  Book book;

  DatosLibros(this.book);

  @override
  _DatosLibrosState createState() => _DatosLibrosState();
}


class _DatosLibrosState extends State<DatosLibros> {

  bool _isMarcked = false;
  bool _isTicked = false;
  bool isFocusGlobal = false;
  bool _newBookCheckBox = false;
  bool _universidadCheckBox = false;
  bool _colegioCheckBox = true;

  TextEditingController nombreTextController = new TextEditingController(),
      editorialTextController = new TextEditingController(),
      autorTextController = new TextEditingController(),
      ISBNTextController = new TextEditingController(),
      descripcionTextController = new TextEditingController(),
      precioTextController = new TextEditingController();

  FirebaseAnalytics analytics;

  Map<String, bool> values;
  bool loadingDialogShown = false;
  bool valuesHasBeenCreated = false;
  bool isColegioSelected = false,isUniversidadSelected = false;

  List<int> selectedColegios = [];
  List<int> selectedCursos = [];
  List<int> selectedMaterias = [];

  List<int> selectedUniversidades = [];
  List<int> selectedCarreras = [];
  List<int> selectedYearUniversidad = [];
  List<String> colegiosList,cursosList,materiasList;

  ScrollController _controller;
  _scrollListener() {
    if (_controller.position.pixels !=
        _controller.position.maxScrollExtent) {
     /* FocusScope.of(context).requestFocus(new FocusNode());*/
      // ... call method to load more repositories
    }
  }

@override
  void initState() {
  _controller = ScrollController();
  _controller.addListener(_scrollListener);
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
              setState(() {
                isFocusGlobal=false;
              });
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
                            SizedBox(width: 10),
                            Text(
                              "Subir libro",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ingresa los datos",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Asegúrate de escribir correctamente los datos del libro que vayas a vender.",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*5),
                    Text(
                      "*Nombre",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyTextfield(
                      isFocus: isFocusGlobal,
                      controller: nombreTextController,
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      "*Autor",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyTextfield(
                      isFocus: isFocusGlobal,
                      controller: autorTextController,
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);

                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      "*Editorial",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyTextfield(
                      isFocus: isFocusGlobal,
                      controller: editorialTextController,
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      "ISBN (opcional)",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyTextfield(
                      isFocus: isFocusGlobal,
                      controller: ISBNTextController,
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Descripción ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Escribe una breve descripción del  estado del libro que vayas a vender.",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*5),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child:  TextField(
                        controller: descripcionTextController,
                        textCapitalization: TextCapitalization.sentences,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintStyle:TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: "*DESCRIPCIÓN",
                          border: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.headline3,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: AppColors.secondaryBackground,
                        autocorrect: true,
                      ),
                    ),
                    SizedBox(height: 40),
                    FlatButton(
                      splashColor: Theme.of(context).backgroundColor,
                      onPressed: () {
                        setState(() {
                          _newBookCheckBox =  !_newBookCheckBox;
                        });
                        print('Click');
                      },
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '¿Es nuevo el libro?',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(width: 30),
                          Center(
                            child: Container(
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                color: _newBookCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                                borderRadius:  BorderRadius.circular(5.0),
                              ),
                              child: Center(child: Icon(_newBookCheckBox? Icons.done: null, color: Colors.white, size: 17)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "¿Donde lo publicaras?",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Los podrás vender en todos los lugares que tengas habilitados.",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    BlocBuilder<UserBloc, UserBlocState>(
                        builder: (context, state) {
                          if (state is UserNotLoaded) {
                           /* showLoadingDialog(context);*/
                            loadingDialogShown = true;
                            return CircularProgressIndicator();
                          } else if (state is UserLoadedState) {
                            if (state.user is Alumno || state.user is Padre)_colegioCheckBox=true;
                            colegiosList = state.user.getColegios();
                            return Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                      splashColor: Theme.of(context).backgroundColor,
                                      onPressed: () {
                                        setState(() {
                                          _colegioCheckBox =  !_colegioCheckBox;
                                        });
                                        print('Click');
                                      },
                                      padding: EdgeInsets.only(top: 0, bottom: 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal*50,
                                            padding: EdgeInsets.only(left: 20, right: 4, top: 20, bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).hintColor.withAlpha(60),
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: Opacity(
                                                opacity: _colegioCheckBox? 1 : 0.2,
                                                child: Text("Colegio", style: Theme.of(context).textTheme.headline2,)),
                                          ),
                                          SizedBox(width: SizeConfig.blockSizeHorizontal*15),
                                          Center(
                                            child: Container(
                                              height: 27,
                                              width: 27,
                                              decoration: BoxDecoration(
                                                color: _colegioCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                                                borderRadius:  BorderRadius.circular(5.0),
                                              ),
                                              child: Center(child: Icon(_colegioCheckBox? Icons.done: null, color: Colors.white, size: 17)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _colegioCheckBox
                                        ?Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 40),
                                        /*Text(
                                          "Colegio",
                                          style: Theme.of(context).textTheme.headline2,
                                        ),*/
                                        DropDownMagic(title: 'Colegios',
                                          value: selectedColegios,
                                          choiceItems: createSmartSelectColegiosList(state.user.getColegios()),
                                          onChange: (state) => setState(() => selectedColegios = state.value),
                                        ),//DropDown Colegio
                                        SizedBox(height: 40),
                                        BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                                        builder: (context, state) {
                                        if (state is ColegiosLoaded) {
                                          cursosList = state.colegiosData.cursos;
                                          materiasList = state.colegiosData.materias;
                                         return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                           /* Text(
                                              "Año",
                                              style: Theme.of(context).textTheme.headline2,
                                            ),*/
                                            DropDownMagic(
                                              title: 'Año',
                                              value: selectedCursos,
                                              choiceItems: createSmartSelectColegiosList(state.colegiosData.cursos),
                                              onChange: (state) => setState(() => selectedCursos = state.value),
                                            ),
                                            SizedBox(height: 40),
                                           /* Text(
                                              "Materia",
                                              style: Theme.of(context).textTheme.headline2,
                                            ),*/

                                            DropDownMagic(
                                              title: 'Materias',
                                              value: selectedMaterias,
                                              choiceItems: createSmartSelectColegiosList(state.colegiosData.materias),
                                              onChange: (state) => setState(() => selectedMaterias = state.value),
                                            ),
                                          ],
                                        );
                                        }return CircularProgressIndicator();}),
                                      ],
                                    )
                                        :Container(),
                                    SizedBox(height: 30),
                                    state.user is AlumnoUniversitario
                                    ?FlatButton(
                                      splashColor: Theme.of(context).backgroundColor,
                                      onPressed: () {
                                        setState(() {
                                          _universidadCheckBox =  !_universidadCheckBox;
                                        });
                                        print('Click');
                                      },
                                      padding: EdgeInsets.only(top: 0, bottom: 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal*50,
                                            padding: EdgeInsets.only(left: 20, right: 4, top: 20, bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).hintColor.withAlpha(60),
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: Opacity(
                                                opacity: _universidadCheckBox? 1 : 0.2,
                                                child: Text("Universidad", style: Theme.of(context).textTheme.headline2,)),
                                          ),
                                          SizedBox(width: SizeConfig.blockSizeHorizontal*15),
                                          Center(
                                            child: Container(
                                              height: 27,
                                              width: 27,
                                              decoration: BoxDecoration(
                                                color: _universidadCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                                                borderRadius:  BorderRadius.circular(5.0),
                                              ),
                                              child: Center(child: Icon(_universidadCheckBox? Icons.done: null, color: Colors.white, size: 17)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ):
                                        Container(),
                                    _universidadCheckBox
                                        ?universidadLayout(state.user)
                                        :Container()
                                  ],
                                ),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ponle un precio",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Cuanto mas bajo sea el precio mas fácil te sera venderlo",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          size: 60.0,
                          color: Color.fromARGB(255, 112, 112, 112),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal*60,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withAlpha(60),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: TextField(
                            controller: precioTextController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              hintText: "PRECIO",
                              hintStyle: TextStyle(
                                fontFamily: "Sf-r",
                                color: Color.fromARGB(20, 0, 0, 0),
                              ),
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
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*9),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 15),
                      child: FlatButton(
                        onPressed: () => _siguienteBtn(),
                        /*color: Color.fromARGB(255, 222, 222, 222),*/
                        color: AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: Text(
                            "Finalizar",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }

  List<DropdownMenuItem> createDropDownMenuListColegios(List<String> listaAux) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    String agregarColegio =  "+ Agregar Colegio";
    String item;
    for (int i=0;i<listaAux.length;i++) {
      item=listaAux[i];
      dropdownMenuItemList.add(DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10), //TODO encontrar alternativa para el container overflow
                child: new Text(
                  item,
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
        value: item,
      ));
    };
    return dropdownMenuItemList;
  }

  List<DropdownMenuItem> createDropDownMenuListMaterias(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    String agregarMateria = "+ Agregar Materia";
    for (String item in lista) {
      dropdownMenuItemList.add(DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: 10,
                    bottom:
                    10), //TODO encontrar alternativa para el container overflow
                child: new Text(
                  item,
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
        value: item,
      ));
    }
    dropdownMenuItemList.add(DropdownMenuItem(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: 10,
                  bottom:
                  10), //TODO encontrar alternativa para el container overflow
              child: new Text(
                agregarMateria,
                style: TextStyle(
                  color: AppColors.secondaryBackground,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
      value: agregarMateria,
    ));
    return dropdownMenuItemList;
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
        (_isMarcked == true && _isTicked == true)) {
      if(nombreLibro == null ||
          nombreLibro.isEmpty ||
          nombreLibro.length ==0 ){
        showErrorDialog(
            context, "Para continuar debes completar el nombre del libro");
      }else if(autor == null ||
          autor.isEmpty ||
          autor.length == 0 ){
        showErrorDialog(
            context, "Para continuar debes completar el nombre del autor");
      }else if( descripcion == null ||
          descripcion.isEmpty ||
          descripcion.length == 0 ){
        showErrorDialog(
            context, "Para continuar debes completar la descripcion del libro");
      }else if(precio == null ||
          precio.isEmpty ||
          precio.length ==0){
        showErrorDialog(
            context, "Para continuar debes completar el precio del libro");
      }

      print("falta completar algun campo");
      return null;
    } else if(selectedColegios.length == 0){
      showErrorDialog(
          context, "Para continuar debes seleccionar al menos un colegio");
    }else if(selectedCursos.length == 0){
      showErrorDialog(
          context, "Para continuar debes seleccionar al menos un curso en el que quieras registrar tu libro");
    }else if(selectedMaterias.length == 0){
      showErrorDialog(
          context, "Para continuar debes seleccionar al menos una materia en la que quieras registrar tu libro");
    }else{
      widget.book.nombreLibro = nombreLibro;
      widget.book.autor = autor;
      widget.book.descripcion = descripcion;
      widget.book.precio = num.parse(precio);
      widget.book.publico = _isTicked;
      if(editorial != null && editorial.isNotEmpty) widget.book.editorial = editorial;
      if(ISBN != null && ISBN.isNotEmpty) widget.book.isbn = int.parse(ISBN);
      selectedColegios.forEach((index) {widget.book.colegios.add(colegiosList[index]);});
      selectedCursos.forEach((index) {widget.book.cursos.add(cursosList[index]);});
      selectedMaterias.forEach((index) {widget.book.materias.add(materiasList[index]);});
      print("todos los campos estan completos");
      analytics.logEvent(name: "finish_subir_libro");
      BlocProvider.of<BooksBloc>(context).add(AddBook(widget.book));
//    uploadBook().then((smt) => Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => MyBooksView()),
//    ));
  }
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

  Widget universidadLayout(Padre user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40),
        Text(
          "Universidad",
          style: Theme.of(context).textTheme.headline2,
        ),
        BeautyDropDown(
          multiple: true,
          item: createDropDownMenuListColegios(user.getColegios()),
          selectedItems: selectedUniversidades,
          width: double.maxFinite, //REQUIRED
          height: selectedUniversidades.length>0?(selectedUniversidades.length * 50.0): 50,
          accentColor: Colors.white, // On Focus Color//Text Color
          backgroundColor: Theme.of(context).hintColor,
          autofocus: false,
          selectedValueWidget: (item) {
            print("Item DROP:" +  item.toString());
            return Container(
              child: Chip(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                label: Text(item.toString(), style:  Theme.of(context).primaryTextTheme.headline2),//Tile Estado),
                deleteIcon: Icon(
                  Icons.cancel, color: Theme.of(context).iconTheme.color,
                ),
                onDeleted: (){},
              ),
            );
          },
          margin: EdgeInsets.only(top: 10),
          cornerRadius: BorderRadius.all(Radius.circular(15)),
          duration: Duration(milliseconds: 300),
          onClickSuffix: () {
            print('Suffix Clicked');
          },
          onTap: () {
            print('Click');
          },
          onChanged: (value) {
            setState(() {
              selectedUniversidades = value;
              print("Colegios DROP:" +  selectedUniversidades.toString());
            });
          },
        ),//DropDown Colegio
        SizedBox(height: 40),
        BlocBuilder<ColegiosBloc, ColegiosBlocState>(
            builder: (context, state) {
              if (state is ColegiosLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Carrera",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyDropDown(
                      multiple: true,
                      item: createDropDownMenuListColegios(state.colegiosData.materias),
                      selectedItems: selectedCarreras,
                      width: double.maxFinite, //REQUIRED
                      height: selectedCarreras.length>0?(selectedCarreras.length * 50.0): 50,
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      selectedValueWidget: (item) {
                        print("Item DROP:" +  item.toString());
                        return Container(
                          child: Chip(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            label: Text(item.toString(), style:  Theme.of(context).primaryTextTheme.headline2),//Tile Estado),
                            deleteIcon: Icon(
                              Icons.cancel, color: Theme.of(context).iconTheme.color,
                            ),
                            onDeleted: (){},
                          ),
                        );
                      },
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedCarreras = value;
                          print("Materia DROP:" +  selectedCarreras.toString());
                        });
                      },
                    ),//DropDown Materia
                    SizedBox(height: 40),
                    Text(
                      "Año",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyDropDown(
                      multiple: true,
                      item: createDropDownMenuListColegios(state.colegiosData.cursos),
                      selectedItems: selectedYearUniversidad,
                      width: double.maxFinite, //REQUIRED
                      height: selectedYearUniversidad.length>0?(selectedYearUniversidad.length * 50.0): 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      selectedValueWidget: (item) {
                        print("Item DROP:" +  item.toString());
                        return Container(
                          child: Chip(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            label: Text(item.toString(), style:  Theme.of(context).primaryTextTheme.headline2),//Tile Estado),
                            deleteIcon: Icon(
                              Icons.cancel, color: Theme.of(context).iconTheme.color,
                            ),
                            onDeleted: (){},
                          ),
                        );
                      },
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedYearUniversidad = value;
                          print("Año DROP:" +  selectedYearUniversidad.toString());
                        });
                      },
                    ),//DropDown Año
                  ],
                );
              }return CircularProgressIndicator();}),
      ],
    );
  }


}

createSmartSelectColegiosList(List<String> colegios) {
  List<S2Choice<int>> result = [];
  for(int i=0;i< colegios.length;i++){
    result.add(S2Choice<int>(value: i,title: colegios[i]));
  }
  return result;
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}
void showAddSubjectDialog(BuildContext context,String email,List<String> colegiosList){
  showSlideDialogFull(
  context: context,
  child: AddSubjectToSchoolDialogWidget(email,colegiosList),
  );
}

Map<String, bool> createMapfromStringsList(List<String> stringsList) {
  Map<String, bool> map = Map();
  for (String item in stringsList) {
    map[item] = false;
  }
  return map;
}