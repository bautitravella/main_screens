import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/message_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/create_school_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
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
  bool _sinColegioCheckBoxVisible = false;
  bool _sinColegioCheckBox = false;
  bool _colegioAgregado = false;

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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Colegio",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              BeautyDropDown(
                                multiple: false,
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
                                      _sinColegioCheckBoxVisible =  true;
                                      colegioSelectedValue = value;
                                    });
                                  }
                                },
                                onTap: (){
                                  print('Click');
                                  setState(() {
                                    _sinColegioCheckBoxVisible =  true;
                                  });

                                },
                              ),
                              _sinColegioCheckBoxVisible?
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor.withAlpha(60),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _sinColegioCheckBox =  !_sinColegioCheckBox;
                                        });
                                        print('Click');
                                       },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal*60,
                                            child: Text(
                                              "Mi colegio no se encuentra en la lista de colegios disponibles",
                                              style: Theme.of(context).textTheme.headline4,
                                            ),
                                          ),
                                          Container(
                                            height: 27,
                                            width: 27,
                                            decoration: BoxDecoration(
                                              color: _sinColegioCheckBox? AppColors.secondaryBackground: Theme.of(context).hintColor,
                                              borderRadius:  BorderRadius.circular(5.0),
                                            ),
                                            child:  _sinColegioCheckBox?
                                                Center(
                                                child: Icon(
                                                  Icons.done,
                                                    color: Colors.white,
                                                    size: 17)
                                            ):
                                                Container()
                                          ),
                                        ],
                                      ),
                                    ),
                                    _sinColegioCheckBox?
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _colegioAgregado =  true;
                                          showSchoolDialog(context, widget.user.email);
                                        });
                                        print('Click');
                                      },
                                      child:Container(
                                        margin: EdgeInsets.only(top: 25),
                                      child: _colegioAgregado?
                                      Opacity(
                                        opacity: 0.5,
                                        child: Text(
                                          "Agregar colegio",
                                          style:  Theme.of(context).textTheme.headline4,
                                        ),
                                      )
                                          :Text(
                                        "Agregar colegio",
                                        style:  TextStyle(
                                          color: Color.fromARGB(255, 0, 191, 131),
                                          fontSize: 15,
                                          fontFamily: "Sf",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ) ,
                                      )
                                    )
                                    :Container(),

                                  ],
                                ),
                              ): Container()
                            ],
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Curso",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          BeautyDropDown(
                            multiple: false,
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

//      Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => TerminosYCondicionesWidget(widget.user)));
      showLoadingDialog(context);
      FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
      //SUBIR PERFIL
      analytics.setUserProperty(name: "rol", value: "Alumno");
      analytics.logEvent(name: "create_user");

      //todo cambiar toda esta poronga por un buen Future.wait
      uploadData2(context).then((smt) => {
        Future.delayed(Duration(seconds: 2)).then((value) {
          print("PASANDO A LA PROXIMA PANTALLA");
          BlocProvider.of<UserBloc>(context).add(LoadUser(widget.user.email));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeHub()),
          );
        }),
      }).catchError((err) {
        print("HUBO UN ERROR 1, " + err.toString());
        Navigator.pop(context);
        showErrorDialog(context,
            "Hubo un error al intentar cargar tus datos.Error: ${err.toString()}");
      }
      );
    } else {
      //print("ERROR MESSAGE: ");

      showErrorDialog(context,
          nombreController.text.isNotEmpty && apellidoController.text.isNotEmpty? "Debes seleccionar el colegio y curso al que perteneces para poder continuar." : "Debes completar tu nombre y apellido");
    }

    //Mostrar un mensaje de error
  }


  Future<void> uploadData2(BuildContext context)async{
    String downloadUrl = await uploadImage();
    widget.user.fotoPerfilUrl = downloadUrl;
    widget.user.hasAcceptedTerms = true;
    return Future.wait([uploadUserInformation(downloadUrl, context),createFavoritesDocument(),createTokensDocument()]);
  }


  Future<String> uploadImage() async {
    StorageReference ref =
    FirebaseStorage.instance.ref().child("profile_images2/" + widget.user.email + ".jpg");
    StorageUploadTask uploadTask = ref.putFile(widget.user.fotoPerfilRaw);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
    (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
  }

  Future uploadUserInformation(String downloadUrl, BuildContext context) {
    return Firestore.instance
        .collection('Users')
        .document(widget.user.email)
        .setData(widget.user.toMap())
        .then((value) => print("se mando bien la info a firebase"))
        .catchError((err) => {
      Navigator.pop(context),
      showErrorDialog(context,
          "Hubo un error al intentar cargar tus datos.Error: ${err.toString()}")
    });
  }

  Future createFavoritesDocument() {
    return  Firestore.instance.collection('Users').document(widget.user.email).collection('Favoritos').document('favoritos').setData({'favoritosList':[]});
  }

  Future createTokensDocument(){
    return Firestore.instance.collection('Users').document(widget.user.email).collection('Tokens').document('tokens').setData({'tokensList':[]});
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
  TextEditingController colegioNameTextEditingController =
  TextEditingController();
  String errorMessage = "No has ingresado ningun colegio.";
  String input = "";
  showSlideDialogFull(
    context: context,
    child: CreateSchoolDialogWidget(email),
  );
}

