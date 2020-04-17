import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:flutterui/WidgetsCopy//textfield_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'package:flutterui/dialogs/dialogs.dart';

class AlumnoDatos extends StatefulWidget {
  Alumno user;
  AlumnoDatos(this.user);

  @override
  _AlumnoDatosState createState() => _AlumnoDatosState();
}

class _AlumnoDatosState extends State<AlumnoDatos> {

  TextEditingController nombreController = new TextEditingController(), apellidoController = new TextEditingController();
  String colegioSelectedValue, cursoSelectedValue;
  bool loadingDialogShown = false;
  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/curso_alumno");
    super.initState();
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                          "Configura tu perfil",
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
                      "Ingresa tus datos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Podrás cambiarla mas tarde en la app.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Text(
                  "Nombre",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: nombreController,
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
                  "Apellido",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: apellidoController,
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
                BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                  builder: (context, state) {
                    if (state is ColegiosLoading) {
                      //showLoadingDialog(context);
                      loadingDialogShown = true;
                      return CircularProgressIndicator();
                    } else if (state is ColegiosLoaded) {
                      if (loadingDialogShown) {
                        Navigator.of(context).pop();
                        loadingDialogShown = false;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Colegio",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          BeautyDropDown(
                            width: double.maxFinite, //REQUIRED
                            height: 50, //REQUIRED
                            accentColor: Colors.white, // On Focus Color//Text Color
                            backgroundColor: Theme.of(context).hintColor,
                            margin: EdgeInsets.only(top: 10),
                            cornerRadius: BorderRadius.all(Radius.circular(15)),
                            duration: Duration(milliseconds: 300),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            item: createDropDownMenuListColegios(state.colegiosData.colegios),
                            isExpanded: true,
                            value: colegioSelectedValue,
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
                          SizedBox(height: 40),
                          Text(
                            "Curso",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          BeautyDropDown(
                            width: double.maxFinite, //REQUIRED
                            height: 50, //REQUIRED
                            accentColor: Colors.white, // On Focus Color//Text Color
                            backgroundColor: Theme.of(context).hintColor,
                            margin: EdgeInsets.only(top: 10),
                            cornerRadius: BorderRadius.all(Radius.circular(15)),
                            duration: Duration(milliseconds: 300),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            item: createDropDownMenuList(state.colegiosData.cursos),
                            isExpanded: true,
                            value: cursoSelectedValue,
                            onChanged: (value) {
                              setState(() {
                                cursoSelectedValue = value;
                              });
                            },
                          ),

                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*9),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => siguienteBtn(context),
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
              margin: EdgeInsets.only(top: 10,bottom: 10), //TODO encontrar alternativa para el container overflow
              child: new Text(
                agregarColegio,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 191, 131),
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
                  style: Theme.of(context).textTheme.headline3,
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
    if (cursoSelectedValue != null && colegioSelectedValue != null && nombreController.text.isNotEmpty && apellidoController.text.isNotEmpty) {
      widget.user.colegio = colegioSelectedValue;
      widget.user.curso = cursoSelectedValue;
      widget.user.nombre = nombreController.text;
      widget.user.apellido = apellidoController.text;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TerminosYCondicionesWidget(widget.user)));
    } else {
      //print("ERROR MESSAGE: ");

      showErrorDialog(context,
          nombreController.text.isNotEmpty && apellidoController.text.isNotEmpty? "Debes seleccionar el colegio y curso al que perteneces para poder continuar." : "Debes completar tu nombre y apellido");
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
                        decoration: InputDecoration(
                          hintText: "Nombre del colegio que quieres agregar",
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        autocorrect: false,
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

