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

  @override
  void initState() {
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          child: Column(children: [
            Text("estas en el \n         RINCON."),
            SizedBox(
              width: 100,
              height: 100,
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

                  suffixIcon: Icon(Icons.remove_red_eye),
                  item:
                      createDropDownMenuListColegios(state.colegiosData.colegios),
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
                );
              }
              return CircularProgressIndicator();
            }),
            errorText != null? Container(child: Text(errorText),):Container(),
            RaisedButton(
              onPressed: () => _siguienteBtn(),
              child: Center(
                child: Text("CAMBIAR DE COLEGIO"),
              ),
            )
          ]),
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
