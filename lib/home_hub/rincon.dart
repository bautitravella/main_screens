import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc_event.dart';
import 'package:flutterui/dialogs/dialog_widget/create_school_dialog.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/home_hub/generic_booklist_screen.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';

import '../size_config.dart';

class Rincon extends StatefulWidget {
  User user;

  Rincon(this.user);

  @override
  _RinconState createState() => _RinconState();
}

class _RinconState extends State<Rincon> {
  String colegioSelectedValue;
  String errorText;
  bool _cambiarColegioButton = false;

  @override
  void initState() {
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                  child: Text(
                    "Solicitud de colegio",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tu solicitud esta\n siendo evaluada!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Te enviaremos un mail en la brevedad informando te del estado de tu solicitud.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    "Verifica que este tu colegio",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                  builder: (context, state) {
                if (state is ColegiosLoaded) {
                  return BeautyDropDown(
                    multiple: false,
                    width: double.maxFinite,
                    //REQUIRED
                    height: 50,
                    //REQUIRED
                    accentColor: Colors.white,
                    // On Focus Color//Text Color
                    backgroundColor: Theme.of(context).hintColor,
                    margin: EdgeInsets.only(top: 10),
                    cornerRadius: BorderRadius.all(Radius.circular(15)),
                    duration: Duration(milliseconds: 300),
                    clearIcon: true,
                    showClearIcon: true,

                    suffixIcon: Icon(Icons.remove_red_eye),
                    item:
                        createDropDownMenuListColegios(state.colegiosData.colegios),
                    isExpanded: true,
                    value: colegioSelectedValue,
                    onClearNew: (){
                      setState(() {
                        //TODO @agus hace que se pueda deseleccionar el colegio--
                        // osea poner el value en null creo. Te tenes q meter en el textfield.dart creo
                        // asi le podes pasar el value sin que te tire error ahi te puse un arroba donde se pasa onClearNew
                        print("borrame todo de una vez");
                      });
                    },
                    onChanged: (value) {
                      if (value == "+ Agregar Colegio") {
                        showSchoolDialog(context, widget.user.email);
                      }
                      if (value == null ){
                        setState(() {
                          _cambiarColegioButton = false;
                        });
                      }
                      else {
                        setState(() {
                          colegioSelectedValue = value;
                          _cambiarColegioButton = true;
                        });
                      }
                    },
                  );
                }
                return CircularProgressIndicator();
              }),
              errorText != null? Container(child: Text(errorText),):Container(),
                _cambiarColegioButton?
              RaisedButton(
                onPressed: () => _siguienteBtn(),
                child: Center(
                  child: Text("CAMBIAR DE COLEGIO"),
                ),
              ):
                Container(),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Image.asset(_cambiarColegioButton?"assets/images/rincon_illustration_cambiarcolegio.png":"assets/images/rincon_illustration.png",fit: BoxFit.fitWidth,),

            ]),
          ),
        ),
      ),
    );
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

  _onWillPop() {
    BlocProvider.of<UserBloc>(context).add(UnloadUser());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FirstscreenWidget(),
      ),
    );
  }

  _siguienteBtn() {
    if (colegioSelectedValue != null) {
      //TODO: @Trave @JUANBA ideal mostrar un dialog aca que diga si estas seguro que queres continuar
      if (widget.user is Padre) {
        Padre auxUser = widget.user;
        auxUser.hijos.forEach((element) {
          element.colegio = colegioSelectedValue;
        });
        BlocProvider.of<UploadsBloc>(context).add(EditUserInfo(auxUser));
      } else if (widget.user is Alumno) {
        Alumno auxUser = widget.user;
        auxUser.colegio = colegioSelectedValue;
        BlocProvider.of<UploadsBloc>(context).add(EditUserInfo(auxUser));
      }
      Navigator.pop(context);
    }
  }
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

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
}
