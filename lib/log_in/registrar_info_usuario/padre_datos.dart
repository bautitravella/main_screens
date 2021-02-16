import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/create_school_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/registrar_info_usuario/terminos_ycondiciones_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';

class PadreDatos extends StatefulWidget {
  Padre user;
  PadreDatos(this.user);

  @override
  _PadreDatosState createState() => _PadreDatosState();
}

class _PadreDatosState extends State<PadreDatos> {
  TextEditingController nombreController = new TextEditingController(),
      apellidoController = new TextEditingController();
  List<DropdownMenuItem> items = [];
  List<ChildField> hijos = [];
  int _currentIndex = 0;
  bool loadingDialogShown = false;

  @override
  void initState() {
    FirebaseAnalytics analytics =
        Provider.of<FirebaseAnalytics>(context, listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/curso_padre");

    for (int i = 0; i < 20; i++) {
      items.add(new DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new Text(
                      'Colegio ' + i.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 38, 65),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        value: 'Colegio ' + i.toString(),
      ));
    }
    super.initState();
    hijos.add(ChildField(
      widget.user,
      key: UniqueKey(),
    ));
    print("USER = " + widget.user.toString());
  }

  Widget listViewItem({int index}) {
    // widget layout for listview items
    return GestureDetector(
      onTap: () => selectedItem(index),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: _currentIndex != index - 1
              ? Theme.of(context).hintColor
              : AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            "$index",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 8,
              right: SizeConfig.blockSizeHorizontal * 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 8),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Configura tu perfil",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ingresa tus datos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Podrás cambiarlos mas tarde en la app.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 5),
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
                  inputAction: TextInputAction.done, //REQUIRED
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
                  inputAction: TextInputAction.done, //REQUIRED
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
                /* BlocBuilder<ColegiosBloc, ColegiosBlocState>(
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
                ),*/
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ingresa los datos de tus hijos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Puedes ir agregando hijos con el signo "+" ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.maxFinite,
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hijos.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == hijos.length) {
                          return GestureDetector(
                            onTap: () => agregarHijo(),
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 191, 131),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (index == hijos.length + 1) {
                          return _currentIndex == 0
                              ? Container()
                              : GestureDetector(
                                  onTap: () => borrarHijo(),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 217, 86, 86),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                        } else {
                          return listViewItem(index: index + 1);
                        }
                      }),
                ),
                SizedBox(height: 40),
                hijos[_currentIndex],
                SizedBox(height: SizeConfig.blockSizeVertical * 9),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => siguienteBtn(context),
                    /*color: Color.fromARGB(255, 222, 222, 222),*/
                    color: AppColors.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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

  siguienteBtn(BuildContext context) {
    String errorMessagePlural = 'Los perfiles de los hijos : ';
    String errorMessageIndividual = 'El perfil del hijo : ';
    String genericErrorMessage = '';
    int cantErrores = 0;
    bool error = false;

    if (nombreController.text.isNotEmpty &&
        apellidoController.text.isNotEmpty) {
      widget.user.nombre = nombreController.text;
      widget.user.apellido = apellidoController.text;


      //fijarse si alguno de los hijos creados tiene algun campo incompleto
      for (int i = 0; i <= hijos.length - 1; i++) {
        if (!hijos[i].isComplete()) {
          //aca hay que poner el pop up de que ese usuario esta mal
          error = true;
          cantErrores++;
          if (cantErrores >= 2) {
            genericErrorMessage += ", ${i + 1} ";
          } else {
            genericErrorMessage += " ${i + 1}";
          }
        }
      }

      if (error == true) {
        widget.user.hijos.clear();
        if (cantErrores > 1) {
          errorMessagePlural +=
              genericErrorMessage + " tienen campos que estan incompletos.";
          genericErrorMessage = errorMessagePlural;
        } else {
          errorMessageIndividual +=
              genericErrorMessage + " tiene campos que estan incompletos.";
          genericErrorMessage = errorMessageIndividual;
        }
        //print("ERROR MESSAGE : " + genericErrorMessage);
        showErrorDialog(context, genericErrorMessage);
      } else {
        hijos.forEach((element) {
          widget.user.agregarHijo(element.toHijo());
        });
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => TerminosYCondicionesWidget(widget.user)));
        FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
        Padre auxUser = widget.user;
        analytics.setUserProperty(name: "rol", value: "Padre");
        analytics.setUserProperty(name: "cant_hijos", value: auxUser.hijos.length.toString());
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
      }

    } else {
      //print("ERROR MESSAGE: ");
      showErrorDialog(
          context, "Debes escribir tu nombre y apellido para poder continuar.");

    }

  }

  agregarHijo() {
    hijos.add(ChildField(widget.user, key: UniqueKey()));
    setState(() {
      _currentIndex = hijos.length - 1;
    });
  }

  borrarHijo() {
    setState(() {
      _currentIndex--;
    });

    hijos.removeLast();
  }

  selectedItem(index) {
    print("selected $index");
    setState(() {
      _currentIndex = index - 1;
    });
  }

  goBack() {
    print("ATRAS BOTON");
    setState(() {
      _currentIndex > 0 ? _currentIndex-- : _currentIndex;
    });
  }

  goForward() {
    setState(() {
      _currentIndex < hijos.length - 1 ? _currentIndex++ : _currentIndex;
    });
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

class ChildField extends StatefulWidget {
  ChildField(this.user, {Key key}) : super(key: key);

  bool _sinColegioCheckBoxVisible = false;
  bool _sinColegioCheckBox = false;
  static bool _colegioAgregado = false;

  @override
  _ChildFieldState createState() => _ChildFieldState();

  Padre user;
  String cursoSelectedValue;
  String colegioSelectedValue;
  TextEditingController nombreController = new TextEditingController();

  Hijo toHijo() {
    return Hijo(
        nombreController.text.trim(), colegioSelectedValue, cursoSelectedValue);
  }

  bool isComplete() {
    if (cursoSelectedValue != null &&
        colegioSelectedValue != null &&
        nombreController.text != null &&
        nombreController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}

class _ChildFieldState extends State<ChildField> {
  List<DropdownMenuItem> items = [];

  List createSchoolSubjects = List();

  bool loadingDialogShown = false;



  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      items.add(new DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new Text(
                      'Colegio ' + i.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 38, 65),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        value: 'Colegio ' + i.toString(),
      ));
    }
    super.initState();
    createSchoolSubjects.add("English Literature");
    createSchoolSubjects.add("Math");
    createSchoolSubjects.add("History");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Nombre",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: widget.nombreController,
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
                  inputAction: TextInputAction.done, //REQUIRED
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
                  "Colegio",
                  style: Theme.of(context).textTheme.headline2,
                ),
                widget._sinColegioCheckBox?
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withAlpha(100),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    )
              : BeautyDropDown(
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  item: createDropDownMenuListColegios(
                      state.colegiosData.colegios),
                  isExpanded: true,
                  value: widget.colegioSelectedValue,
                  onChanged: (value) {
                    if (value == "+ Agregar Colegio") {
                      showSchoolDialog(context, widget.user.email);
                    } else {
                      setState(() {
                        widget._sinColegioCheckBoxVisible =  true;
                        widget.colegioSelectedValue = value;
                      });
                    }
                  },
                ),
                widget._sinColegioCheckBoxVisible?
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
                           widget._sinColegioCheckBox =  !widget._sinColegioCheckBox;
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
                                  color: widget._sinColegioCheckBox? AppColors.secondaryBackground: Theme.of(context).hintColor,
                                  borderRadius:  BorderRadius.circular(5.0),
                                ),
                                child: widget._sinColegioCheckBox?
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
                      widget._sinColegioCheckBox?
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              ChildField._colegioAgregado =  true;
                              showSchoolDialog(context, widget.user.email);
                            });
                            print('Click');
                          },
                          child:Container(
                            margin: EdgeInsets.only(top: 25),
                            child: ChildField._colegioAgregado?
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
                ): Container(),
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
                  value: widget.cursoSelectedValue,
                  onChanged: (value) {
                    setState(() {
                      widget.cursoSelectedValue = value;
                    });
                  },
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
  //NO SE USA ESTO
  void agregarColegio(String email) {
    TextEditingController colegioNameTextEditingController =
    TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Enviar solicitud para agregar un colegio"),
          content: Container(
              child: Column(
                children: <Widget>[
                  Text(
                      "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado.Una vez aceptada o rechazada te enviaremos un mail con nuestra decision."),
                  TextField(controller: colegioNameTextEditingController),
                ],
              )),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("Enviar"),
              onPressed: () {
                if (colegioNameTextEditingController.text != null &&
                    colegioNameTextEditingController.text.length > 2) {
                  BlocProvider.of<UploadsBloc>(context).add(AddSchool(
                      colegioNameTextEditingController.text, ["holaaaa"],email));
                }
                Navigator.pop(context);
              },
            )
          ],
        ));
    //}
  }

  List<DropdownMenuItem> createDropDownMenuListColegios(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    String agregarColegio = "+ Agregar Colegio";
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
                agregarColegio,
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
    return dropdownMenuItemList;
  }
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




/*
void showSchoolDialog(BuildContext context, String email) {
  TextEditingController colegioNameTextEditingController = TextEditingController();
  String errorMessage = "No has ingresado ningun colegio.";
  showSlideDialogFull(
      context: context,
      child: Container(
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical*7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enviar solicitud para\nagregar un colegio",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado. Una vez aceptada o rechazada te enviaremos un mail con nuestra decision.",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Nombre del colegio a agregar",
                style: Theme.of(context).textTheme.headline2,
              ),
              BeautyTextfield(
                controller: colegioNameTextEditingController,
                width: double.maxFinite, //REQUIRED
                height: 50, //REQUIRED
                accentColor: Colors.white, // On Focus Color//Text Color
                backgroundColor: Theme.of(context).hintColor,
                autofocus: false,
                maxLines: 1,
                margin: EdgeInsets.only(top: 10),
                cornerRadius: BorderRadius.all(Radius.circular(15)),
                duration: Duration(milliseconds: 300),
                inputType: TextInputType.emailAddress,
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
                "Curso",
                style: Theme.of(context).textTheme.headline2,
              ),
              BeautyTextfield(
                controller: colegioNameTextEditingController,
                width: double.maxFinite, //REQUIRED
                height: 50, //REQUIRED
                accentColor: Colors.white, // On Focus Color//Text Color
                backgroundColor: Theme.of(context).hintColor,
                autofocus: false,
                maxLines: 1,
                margin: EdgeInsets.only(top: 10),
                cornerRadius: BorderRadius.all(Radius.circular(15)),
                duration: Duration(milliseconds: 300),
                inputType: TextInputType.emailAddress,
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
                "Curso",
                style: Theme.of(context).textTheme.headline2,
              ),
              BeautyTextfield(
                controller: colegioNameTextEditingController,
                width: double.maxFinite, //REQUIRED
                height: 50, //REQUIRED
                accentColor: Colors.white, // On Focus Color//Text Color
                backgroundColor: Theme.of(context).hintColor,
                autofocus: false,
                maxLines: 1,
                margin: EdgeInsets.only(top: 10),
                cornerRadius: BorderRadius.all(Radius.circular(15)),
                duration: Duration(milliseconds: 300),
                inputType: TextInputType.emailAddress,
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
                      color: Theme.of(context).iconTheme.color.withAlpha(200),
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
}*/
