import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
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

  TextEditingController nombreController = new TextEditingController(), apellidoController = new TextEditingController();
  List<DropdownMenuItem> items = [];
  List<ChildField> hijos = [];
  int _currentIndex = 0;
  bool loadingDialogShown = false;


  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
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
  }

  Widget listViewItem({int index}) {
    // widget layout for listview items
    return GestureDetector(
      onTap: () => selectedItem(index),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 70, width: 70,
        decoration: BoxDecoration(
          color: _currentIndex != index-1 ?Theme.of(context).hintColor: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text("$index", style: Theme.of(context).textTheme.headline1,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:GestureDetector(
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
                      "Puedes ir agregando hijos con el signo ",
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
                        if(index == hijos.length){
                          return GestureDetector(
                          onTap: () => agregarHijo(),
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 70, width: 70,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 191, 131),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(Icons.add, color: Colors.white,),
                            ),
                          ),
                        );}
                        else if(index == hijos.length+1){
                          return   _currentIndex == 0?Container():GestureDetector(
                            onTap: () => borrarHijo(),
                            child: Container(
                              height: 70, width: 70,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 217, 86, 86),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Icon(Icons.delete, color: Colors.white,),
                              ),
                            ),
                          );}
                        else{   return listViewItem(index: index+1);}
                      }
                  ),
                ),
                SizedBox(height: 40),
                hijos[_currentIndex],
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

  siguienteBtn(BuildContext context) {
    String errorMessagePlural = 'Los perfiles de los hijos : ';
    String errorMessageIndividual = 'El perfil del hijo : ';
    String genericErrorMessage = '';
    int cantErrores = 0;
    bool error = false;

    if (nombreController.text.isNotEmpty && apellidoController.text.isNotEmpty) {
      widget.user.nombre = nombreController.text;
      widget.user.apellido = apellidoController.text;

    } else {
      //print("ERROR MESSAGE: ");

      showErrorDialog(context, "Debes escribir tu nombre y apellido para poder continuar.");
    }

    //Mostrar un mensaje de error

    //fijarse si alguno de los hijos creados tiene algun campo incompleto
    for(int i = 0; i<=hijos.length-1 ; i++){
      if(!hijos[i].isComplete()){
        //aca hay que poner el pop up de que ese usuario esta mal
        error = true;
        cantErrores++;
        if(cantErrores >=2) {
          genericErrorMessage += ", ${i + 1} ";
        }else{
          genericErrorMessage += " ${i + 1}";
        }
      }
    }

    if(error == true){
      if(cantErrores> 1 ){
        errorMessagePlural += genericErrorMessage + " tienen campos que estan incompletos.";
        genericErrorMessage = errorMessagePlural;
      }else{
        errorMessageIndividual +=  genericErrorMessage + " tiene campos que estan incompletos.";
        genericErrorMessage = errorMessageIndividual;
      }
      //print("ERROR MESSAGE : " + genericErrorMessage);
      showErrorDialog(context, genericErrorMessage);

    }else{
      hijos.forEach((element) {widget.user.agregarHijo(element.toHijo());});
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TerminosYCondicionesWidget(widget.user)));
    }
  }

  agregarHijo() {
    hijos.add(ChildField(widget.user,key: UniqueKey()));
    setState(() {
      _currentIndex = hijos.length - 1;
    });
  }

  borrarHijo(){
    setState(() {
      _currentIndex --;
    });

    hijos.removeLast();
  }

  selectedItem(index) {
    print("selected $index");
    setState(() {
      _currentIndex= index-1;
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
}

class ChildField extends StatefulWidget {
  ChildField(this.user,{Key key}) : super(key: key);

  @override
  _ChildFieldState createState() => _ChildFieldState();

  Padre user;
  String cursoSelectedValue;
  String colegioSelectedValue;
  TextEditingController nombreController = new TextEditingController();

  Hijo toHijo(){
    return Hijo(nombreController.text.trim(),colegioSelectedValue,cursoSelectedValue);
  }

  bool isComplete(){
    if(cursoSelectedValue != null && colegioSelectedValue != null && nombreController.text != null && nombreController.text.isNotEmpty){
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
                return  Column(
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
                      value: widget.colegioSelectedValue,
                        onChanged: (value) {

                          if (value == "+ Agregar Colegio") {
                            showSchoolDialog(context, widget.user.email);
                          } else {
                            setState(() {
                              widget.colegioSelectedValue = value;
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
            }
        ),
      ),
    );
  }

  void agregarColegio(String email) {
    TextEditingController colegioNameTextEditingController = TextEditingController();
//    if(Platform.isIOS){
//      showCupertinoDialog(context: context, builder: (BuildContext context) => CupertinoAlertDialog(
//        title: Text("Enviar solicitud para agregar un colegio"),
//        content: Container(
//          child:Column(
//            children: <Widget>[
//              Text("La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado."),
//              Container(child: TextField( controller: colegioNameTextEditingController)),
//            ],
//          )
//        ),
//        actions: <Widget>[
//          CupertinoDialogAction(isDefaultAction: false,child: Text("Cancelar"),onPressed: ()=> Navigator.pop(context),),
//          CupertinoDialogAction(isDefaultAction: true,child: Text("Enviar"),onPressed:(){
//            if(colegioNameTextEditingController.text != null && colegioNameTextEditingController.text.length > 2){
//              BlocProvider.of<UploadsBloc>(context).add(AddSchool(colegioNameTextEditingController.text,email));
//            }
//            Navigator.pop(context);
//          },)
//        ],
//      ));
//    }else{

    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text("Enviar solicitud para agregar un colegio"),
      content: Container(
          child:Column(
            children: <Widget>[
              Text("La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado.Una vez aceptada o rechazada te enviaremos un mail con nuestra decision."),
              TextField(
                  controller: colegioNameTextEditingController
              ),
            ],
          )
      ),
      actions: <Widget>[
        FlatButton(child: Text("Cancelar"),
          onPressed: ()=> Navigator.pop(context),
        ),
        FlatButton(child: Text("Enviar"),
          onPressed: (){
            if(colegioNameTextEditingController.text != null && colegioNameTextEditingController.text.length > 2){
              BlocProvider.of<UploadsBloc>(context).add(AddSchool(colegioNameTextEditingController.text,email));
            }
            Navigator.pop(context);
          },)
      ],
    ));
    //}
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
    return dropdownMenuItemList;
  }
}




void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}
void showSchoolDialog(BuildContext context, String email) {
  TextEditingController colegioNameTextEditingController = TextEditingController();
  String errorMessage = "No has ingresado ningun colegio.";
  String input = "";
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
                "Materias de tu año",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 8),
              Text(
                "Podras agregar una por una las materias correspondientes de tu año",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BeautyTextfield(
                    width: SizeConfig.blockSizeHorizontal*60, //REQUIRED
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
                    onChanged: (String value) {
                      input = value;
                    },
                    onSubmitted: (data) {
                      print(data.length);
                    },
                  ),
                  SizedBox(width: 10),

                  FlatButton(
                    child: Icon(
                      Icons.move_to_inbox,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed:(){
                    }
                    )
                ],
              ),
              SizedBox(height: 25),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                    child: Chip(
                      label: Text( "Environmental Management", textAlign: TextAlign.center),
                      labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                      deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                      onDeleted: (){},
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelStyle:  TextStyle(
                          fontFamily: "Sf-r",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).dialogBackgroundColor),
                      backgroundColor: AppColors.secondaryBackground,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                    child: Chip(
                      label: Text( "Physics high", textAlign: TextAlign.center),
                      labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                      deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                      onDeleted: (){},
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelStyle:  TextStyle(
                          fontFamily: "Sf-r",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).dialogBackgroundColor),
                      backgroundColor: AppColors.secondaryBackground,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                    child: Chip(
                      label: Text( "Maths", textAlign: TextAlign.center),
                      labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                      deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                      onDeleted: (){},
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelStyle:  TextStyle(
                          fontFamily: "Sf-r",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).dialogBackgroundColor),
                      backgroundColor: AppColors.secondaryBackground,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                    child: Chip(
                      label: Text( "Philology", textAlign: TextAlign.center),
                      labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                      deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                      onDeleted: (){},
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelStyle:  TextStyle(
                          fontFamily: "Sf-r",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).dialogBackgroundColor),
                      backgroundColor: AppColors.secondaryBackground,
                    ),
                  ),
                ],
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
                    onPressed: (){},
                  )

                ],
              ),
              SizedBox(height:20),
            ],
          ),
        ),
      )
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
