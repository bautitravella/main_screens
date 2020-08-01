import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/uploads_bloc/bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/AlumnoUniversitario.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/book_widget/edit_book_colegio.dart';
import 'package:flutterui/book_widget/edit_book_curso.dart';
import 'package:flutterui/book_widget/edit_book_materias.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/precio_libro.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'dart:async';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';

import 'book_section.dart';


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

  bool _newBookCheckBox = false;
  bool _universidadCheckBox = false;
  bool _colegioCheckBox = false;

  FirebaseAnalytics analytics;

  Map<String, bool> values;
  bool loadingDialogShown = false;
  bool valuesHasBeenCreated = false;
  bool isColegioSelected = false,isUniversidadSelected = false,isSchoolListLoaded = false,isCoursesListLoaded=false;

  List<int> selectedColegios = [];
  List<int> selectedCursos = [];
  List<int> selectedMaterias = [];

  List<int> selectedUniversidades = [];
  List<int> selectedCarreras = [];
  List<int> selectedYearUniversidad = [];


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
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/edit_book");
    nombreTextController.text = widget.book.nombreLibro;
    autorTextController.text = widget.book.autor;
    descripcionTextController.text = widget.book.descripcion;
    precioTextController.text = widget.book.precio.toString();
    if (widget.book.editorial != null)
      editorialTextController.text = widget.book.editorial;
    if (widget.book.isbn != null)
      ISBNTextController.text = widget.book.isbn.toString();
    clonedBook = widget.book.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UploadsBloc, UploadsBlocState>(
      listener: (BuildContext context, state) async {
        print("STATE CHANGE EDIT BOOK. STATE = ${state.toString()}");
        if (state is InitialUploadsBlocState) {
//              showLoadingDialog(context);
        } else if (state is BookEdited) {
//              Navigator.popUntil(
//                context,
//                ModalRoute.withName('/home'),
//              );
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is FailedToEdit) {
          showErrorDialog(context,
              "Ha habido un error cargando el libro a nuestra base de datos. ${state.errorMessage}");
        } else if (state is EditingState) {
          showLoadingDialog(context);
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
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
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
                          "Editar libro",
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
                      "Cambia los datos",
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
                _imagesListBuilder(),
                SizedBox(height: 40),
                Text(
                  "*Nombre",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
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
                  "ISBN",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
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
                        //BUSCO DE LA LISTA de COLEGIOS cual es el indice de los colegios en los que ya estaba anotado el libro
                        if(!isSchoolListLoaded){
                          isSchoolListLoaded = true;
                          List<String> colegiosUser = state.user.getColegios();
                          for(String colegio in widget.book.colegios){
                            int index = colegiosUser.indexOf(colegio);
                            if(index != -1)selectedColegios.add(index);
                          }
                          isColegioSelected = true;

                        }
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
                                    Text(
                                      "Colegio",
                                      style: Theme.of(context).textTheme.headline2,
                                    ),
                                    BeautyDropDown(
                                      multiple: true,
                                      item: createDropDownMenuListColegios(state.user.getColegios()),
                                      selectedItems: selectedColegios,
                                      width: double.maxFinite, //REQUIRED
                                      height: selectedColegios.length>0?(selectedColegios.length * 50.0): 50,
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
                                            onDeleted: (){
                                              print("Deleted + " + item.toString());
                                              setState(() {

                                                selectedColegios.remove(state.user.getColegios().indexOf(item.toString()));
                                                if(selectedColegios != null && selectedColegios.length != 0){
                                                  isColegioSelected = true;
                                                }else{
                                                  isColegioSelected = false;
                                                }
                                              });

                                            },
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
                                        if(value != null && value.length != 0){
                                          isColegioSelected = true;
                                        }else{
                                          isColegioSelected = false;
                                        }
                                        setState(() {
                                          selectedColegios = value;
                                          print("Colegios DROP:" +  selectedColegios.toString());
                                        });
                                      },
                                    ),//DropDown Colegio
                                    SizedBox(height: 40),
                                    BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                                        builder: (context, state) {
                                          if (state is ColegiosLoaded) {
                                            //BUSCO DE LA LISTA de COLEGIOS  DATA cual es el indice de los cursos y materias en los que ya estaba anotado el libro
                                            if(!isCoursesListLoaded){
                                              for(String curso in widget.book.cursos){
                                                int index = state.colegiosData.cursos.indexOf(curso);
                                                if(index != -1) selectedCursos.add(index);
                                              }
                                              print("MATERIAS COLEGIOS = " + state.colegiosData.materias.toString()
                                                  + '\n MATERIAS LIBRO = ' + widget.book.materias.toString() );
                                              for(String materia in widget.book.materias){
                                                int index = state.colegiosData.materias.indexOf(materia);
                                                if(index != -1) selectedMaterias.add(index);
                                              }
                                              isCoursesListLoaded = true;
                                            }
                                            return isColegioSelected?Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Año",
                                                  style: Theme.of(context).textTheme.headline2,
                                                ),
                                                BeautyDropDown(
                                                  multiple: true,
                                                  item: createDropDownMenuListColegios(state.colegiosData.cursos),
                                                  selectedItems: selectedCursos,
                                                  width: double.maxFinite, //REQUIRED
                                                  height: selectedCursos.length>0?(selectedCursos.length * 50.0): 50, //REQUIRED
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
                                                      selectedCursos = value;
                                                      print("Año DROP:" +  selectedCursos.toString());
                                                    });
                                                  },
                                                ),//DropDown Año
                                                SizedBox(height: 40),
                                                Text(
                                                  "Materia",
                                                  style: Theme.of(context).textTheme.headline2,
                                                ),
                                                BeautyDropDown(
                                                  multiple: true,
                                                  item: createDropDownMenuListColegios(state.colegiosData.materias),
                                                  selectedItems: selectedMaterias,
                                                  width: double.maxFinite, //REQUIRED
                                                  height: selectedMaterias.length>0?(selectedMaterias.length * 50.0): 50,
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
                                                      selectedMaterias = value;
                                                      print("Materia DROP:" +  selectedMaterias.toString());
                                                    });
                                                  },
                                                ),//DropDown Materia
                                              ],
                                            ):Container();
                                          }
                                          BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                                          return CircularProgressIndicator();}),
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
    List<String> lista=["gosho","fds", "sanja", "san lucas"];
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
        precio.isEmpty //||
        //(_isMarcked == false && _isTicked == false)
    ){

      showErrorDialog(
          context, "Para continuar debes completar todos los campos");
      print("falta completar algun campo");
      return null;
    } else if (images.length < 3 && imagesChanged) {
      showErrorDialog(context,
          "Debes seleccionar como minimo 3 imagenes para poder continuar");
    } else {
      showLoadingDialog(context);
      List<Future<ByteData>> futuresList = [];
      List<Future<ByteData>> futuresThumbsList = [];
      images.forEach((image) async {
        futuresList.add(image.getByteData());
        //List<int> imageData = byteData.buffer.asUint8List();

        futuresThumbsList.add(image.getThumbByteData(500, 500, quality: 50));
      });

      Future.wait([
        Future.wait(futuresList).then((value) => value.forEach((element) {
              clonedBook.imagesRaw.add(element.buffer.asUint8List());
            })),
        Future.wait(futuresThumbsList).then((value) => value.forEach((element) {
              clonedBook.imagesRawThumb.add(element.buffer.asUint8List());
            })),
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
        if (clonedBook != widget.book && imagesChanged) {
          //en este caso se modificaron datos del libro e imagenes
          print("11111111111111111111111111111111111111111111111111");
          BlocProvider.of<UploadsBloc>(context).add(EditBook(clonedBook));
        } else if (imagesChanged) {
          //en este caso solo se modificaron las imagenes del libro
          print('2222222222222222222222222222222222222222222222222222');
          BlocProvider.of<UploadsBloc>(context).add(EditBookImages(clonedBook));
          //} else if (clonedBook != widget.book) {
        }else{
          //en este caso se modificaron solo los datos del libro
          print('333333333333333333333333333333333333333333333333333333');
          BlocProvider.of<UploadsBloc>(context).add(EditBookInfo(clonedBook));
          Navigator.pop(context);
        }
//        else {
//          //en este caso
//          print('444444444444444444444444444444444444444444444444444444444444');
//          Navigator.of(context).pop();
//        }
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
          return Stack(
            children: [
              Container(
                height: 150,
                width: 95,
                margin: EdgeInsets.only(right: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: book.getImages() != null && book.getImages().length > 0
                      ? //book.images[0],
                      Image(
                          image: book.getImages()[index],
                          fit: BoxFit.cover,
                        )
                      : CircularProgressIndicator(),
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360)),
                  child: Icon(
                  Icons.edit,
                  color: AppColors.secondaryBackground,
                  size: 30,
                  ),
                  onPressed: () {}),
                ),
              ),
            ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text('Editar fotos elegidas'),
                        onPressed: () => loadAssets()),
                  ],
                )
              ],
            ));
  }
}

void open(BuildContext context, final int index,Book book) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        galleryItems: book.getImages(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection:  Axis.horizontal,
      ),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showSlideDialogChico(
      context: context,
      child: ErrorDialog(
        title: "Oops...",
        error: errorMessage,
      ),
      animatedPill: false);
}
