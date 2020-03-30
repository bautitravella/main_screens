import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/message_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/log_in/registrar_info_usuario/terminos_ycondiciones_widget.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/values/values.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../../size_config.dart';
import 'package:flutterui/dialogs/dialogs.dart';

class CursoAlumnoWidget extends StatefulWidget {
  Alumno user;
  CursoAlumnoWidget(this.user);

  @override
  _CursoAlumnoWidgetState createState() => _CursoAlumnoWidgetState();
}

class _CursoAlumnoWidgetState extends State<CursoAlumnoWidget> {
  String colegioSelectedValue, cursoSelectedValue;

  bool loadingDialogShown = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      left: 28, top: SizeConfig.blockSizeVertical * 12),
                  child: Text(
                    "Casi listos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 57, 57, 57),
                      fontWeight: FontWeight.w400,
                      fontSize: 38,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 6, bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/phonochico.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical * 4,
                        child: BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                          builder: (context, state) {
                            if (state is ColegiosLoading) {
                              showLoadingDialog(context);
                              loadingDialogShown = true;
                              return CircularProgressIndicator();
                            } else if (state is ColegiosLoaded) {
                              if (loadingDialogShown) {
                                Navigator.of(context).pop();
                                loadingDialogShown = false;
                              }
                              return Column(
                                children: <Widget>[
                                  Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 50,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      margin: EdgeInsets.only(
                                          left: 100, right: 110),
                                      child: ClipRRect(
                                        child: Image.asset(
                                          "assets/images/group-1840.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal*55,
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        left: 110,
                                        right: 110,
                                        top: SizeConfig.blockSizeVertical * 3),
                                    child: Opacity(
                                      opacity: 0.37,
                                      child: new DropdownButton(
                                        icon: Icon(Icons.menu),
                                        underline: Text(""),
                                        items: createDropDownMenuListColegios(state.colegiosData.colegios),
                                        isExpanded: true,
                                        value: colegioSelectedValue,
                                        hint: new Text(
                                          'COLEGIO',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 53, 38, 65),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value == "+ Agregar Colegio") {
                                            showSchoolDialog(context, widget.user.email);
                                          } else {
                                            setState(() {
                                              colegioSelectedValue = value;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 2,
                                    width: SizeConfig.blockSizeHorizontal*60,
                                    margin:
                                        EdgeInsets.only(left: 100, right: 100),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(77, 0, 0, 0),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal*55,//TODO encontrar alternativa para el container overflow
                                    height: 45,
                                    margin: EdgeInsets.only(
                                        left: 110,
                                        right: 110,
                                        top: SizeConfig.blockSizeVertical * 4),
                                    child: Opacity(
                                      opacity: 0.37,
                                      child: new DropdownButton(
                                        icon: Icon(Icons.menu),
                                        underline: Text(""),
                                        items: createDropDownMenuList(state.colegiosData.cursos),
                                        isExpanded: true,
                                        value: cursoSelectedValue,
                                        hint: new Text(
                                          'CURSO',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 53, 38, 65),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            cursoSelectedValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 2,
                                    width: SizeConfig.blockSizeHorizontal*60,
                                    margin:
                                        EdgeInsets.only(left: 100, right: 100),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(77, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                      Positioned(
                        left: 70,
                        right: 70,
                        bottom: SizeConfig.blockSizeVertical * 4,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Selecciona\ncolegio y curso",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 38, 65),
                                fontFamily: "Sf-r",
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                                letterSpacing: -0.41786,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Los datos ingresados se podrán\ncambiar mas tarde dentro de la app",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 163, 163, 163),
                                  fontFamily: "Sf-t",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 124,
                  height: 44,
                  margin: EdgeInsets.only(right: 3, bottom: 10),
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
                              fontFamily: "Sf-r",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => siguienteBtn(context)),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> createDropDownMenuListColegios(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    String agregarColegio =  "+ Agregar Colegio";
    for (String item in lista) {
      dropdownMenuItemList.add(DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10), //TODO encontrar alternativa para el container overflow
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 38, 65),
                    fontFamily: "Sf-r",
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
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
              margin: EdgeInsets.only(top: 10,bottom: 10), //TODO encontrar alternativa para el container overflow
              child: new Text(
                agregarColegio,
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 38, 65),
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
      value: agregarColegio,
    ));
    return dropdownMenuItemList;
  }

  List<DropdownMenuItem> createDropDownMenuList(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for (String item in lista) {
      dropdownMenuItemList.add(DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 38, 65),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
        value: item,
      ));
    }
    return dropdownMenuItemList;
  }

  siguienteBtn(BuildContext context) {
    if (cursoSelectedValue != null && colegioSelectedValue != null) {
      widget.user.colegio = colegioSelectedValue;
      widget.user.curso = cursoSelectedValue;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TerminosYCondicionesWidget(widget.user)));
    } else {
      //print("ERROR MESSAGE: ");
      showErrorDialog(context,
          "Debes seleccionar el colegio y curso al que perteneces para poder continuar.");
    }

    //Mostrar un mensaje de error
  }
}
// siguienteBtn(BuildContext context){
//chequear si el usuario eligio un colegio y un curso

//agregar los datos al usuario

//pasar a la siguiente pantalla
//  }
//}

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

void showSchoolDialog(BuildContext context, String email) {
  TextEditingController colegioNameTextEditingController = TextEditingController();
  String errorMessage = "No has ingresado ningun colegio.";
  showSlideDialogFull(
      context: context,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Enviar solicitud para\nagregar un colegio",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Sf-r",
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    children: <Widget>[
                      Text(
                          "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado. Una vez aceptada o rechazada te enviaremos un mail con nuestra decision.",
                        style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Sf-t",
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      TextField(
                           controller: colegioNameTextEditingController,
                        cursorColor: AppColors.secondaryBackground,
                      ),
                    ],
                  )
              ),
              SizedBox(height: 80),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(child:
                  Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                    onPressed: ()=> Navigator.pop(context),
                  ),
                  FlatButton(child:
                  Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: AppColors.secondaryBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                    onPressed: (){
                      if(colegioNameTextEditingController.text != null && colegioNameTextEditingController.text.length > 2){
                        BlocProvider.of<UploadsBloc>(context).add(AddSchool(colegioNameTextEditingController.text,email));
                        Navigator.pop(context);
                        showLoadingDialog(context);
                        Future.delayed(Duration(seconds: 2)).then((smt)=>Navigator.pop(context));
                      }
                      else{Navigator.pop(context);
                      showErrorDialog(context, errorMessage);
                      }
                    },
                   )
                ],
              )

            ],
          ),
        ),
      )
  );
}

