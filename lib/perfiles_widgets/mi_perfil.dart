import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/school_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

import '../auth.dart';

class MiPerfil extends StatefulWidget {
  MiPerfil({Key key}) : super(key: key);

  @override
  _MiPerfilState createState() => _MiPerfilState();
}

bool _isSelected = false;
bool _isMarcked = false;
bool _isTicked = false;

class _MiPerfilState extends State<MiPerfil> {
  String colegioSelectedValue,cursoSelectedValue,hijosSelectedValue;
  List<Hijo> hijos;
  int indexHijo = 0;
  TextEditingController hijoNameController = new TextEditingController();
  User auxUser,originalUser;
  bool editedImage = false;
  File _image;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocBuilder<UserBloc,UserBlocState>(
        builder: (context,state){
          if(state is UserLoadedState){
            User user = state.user;
            originalUser = user;
            auxUser = user.clone();

          return Stack(
            children: <Widget>[
              Container(
                color: AppColors.secondaryBackground,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: SizeConfig.blockSizeVertical * 8,
                      right: 0,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 40,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          "assets/images/destacados-image.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    /* Positioned(
                    left: 22,
                    top: 45,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Bautista Travella",
                                  style: TextStyle(
                                    fontFamily: "Gibson",
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      width: 30,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 243, 243, 243),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      child: Icon(
                                        Icons.star_border,
                                        size: 15,
                                        color: AppColors.secondaryBackground,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "4.8",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Gibson",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Senior 2, Sociales",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(150, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )*/
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 10,
                      left: 28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ajustes",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    height: SizeConfig.blockSizeVertical * 14,
                  ),
                  Expanded(
                    child: Container(
                      child: SlidingUpPanel(
                        panelBuilder: (ScrollController sc) => _scrollingList(sc,auxUser),
                        maxHeight: SizeConfig.blockSizeVertical * 77,
                        minHeight: SizeConfig.blockSizeVertical * 77,
                        backdropEnabled: false,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
          return Container();
          },
      ),
    );
  }

  Widget _scrollingList(ScrollController sc,User user) {

    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Container(
      height: 220,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            child: ListView(
              controller: sc,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 70),
                      ConfigurableExpansionTile(
                        headerExpanded: Container(
                          height: 310,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          width: SizeConfig.blockSizeHorizontal * 92,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 22, right: 22),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Cuenta",
                                              style: TextStyle(
                                                  fontFamily: "Sf-r",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 57, 57, 57)),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(Icons.lock, size: 18)
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Cambiar mail y contraseña, eliminar cuenta",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 184, 184, 184)),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.alternate_email,
                                        size: 40,
                                        color: Color.fromARGB(20, 0, 0, 0))
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 12, right: 12, top: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          Color.fromARGB(100, 112, 112, 112)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText:
                                              "Confirmar contraseña actual",
                                          alignLabelWithHint: true,
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 120, 120, 120),
                                          fontFamily: "Sf-r",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                        maxLines:
                                            1, //TODO resolver tema del overflow
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autocorrect: false,
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeVertical * 10,
                                      height: 34,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 104, 104),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Desbloquear',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 150,
                                margin: EdgeInsets.only(left: 22, right: 22),
                                /* color: Colors.red,*/
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Cambiar mail",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 110, 110, 110)),
                                        ),
                                        Container(
                                          height: 24,
                                          margin: EdgeInsets.only(left: 10),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  50,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  "jbttravellita@gmail.com",
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 120, 120, 120),
                                              fontFamily: "Sf-r",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14,
                                            ),
                                            maxLines:
                                                1, //TODO resolver tema del overflow
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: false,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Nueva contraseña",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 110, 110, 110)),
                                        ),
                                        Container(
                                          height: 24,
                                          margin: EdgeInsets.only(left: 10),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: "***********",
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 120, 120, 120),
                                              fontFamily: "Sf-r",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14,
                                            ),
                                            maxLines:
                                                1, //TODO resolver tema del overflow
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: false,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Eliminar cuenta",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  100, 110, 110, 110)),
                                        ),
                                        Container(
                                          height: 30,
                                          margin: EdgeInsets.only(left: 10),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                200, 0, 191, 131),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Guardar",
                                              style: TextStyle(
                                                  fontFamily: "Sf-r",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        header: Container(
                          height: 80,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                          width: SizeConfig.blockSizeHorizontal * 92,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 22, right: 22),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Cuenta",
                                              style: TextStyle(
                                                  fontFamily: "Sf-r",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 57, 57, 57)),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(Icons.lock, size: 18)
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Cambiar mail y contraseña, eliminar cuenta",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 184, 184, 184)),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.alternate_email,
                                        size: 40,
                                        color: Color.fromARGB(20, 0, 0, 0))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ConfigurableExpansionTile(
                        headerExpanded: Container(
                          height: 310,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          width: SizeConfig.blockSizeHorizontal * 92,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 22, right: 22),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Privacidad",
                                          style: TextStyle(
                                              fontFamily: "Sf-r",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 57, 57, 57)),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Contactos bloqueados, Visibilidad en otros colegios",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 184, 184, 184)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 28,
                                      child: Opacity(
                                        opacity: 0.2,
                                        child: Image.asset(
                                          'assets/images/avatars.png',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 200,
                                margin: EdgeInsets.only(left: 22, right: 22),
                                /* color: Colors.red,*/
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Contactos bloqueados",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 110, 110, 110)),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      height: 90,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: 3,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          School school = schools[index];
                                          return Row(
                                            children: <Widget>[
                                              buildEtiquetaBloqueado(
                                                  school.imageUrl, school.name),
                                              buildEtiquetaBloqueado(
                                                  school.imageUrl, school.name),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: SwitchListTile(
                                        title: Text(
                                          "Tus libros estarán disponibles \nen otros colegios",
                                          style: TextStyle(
                                              fontFamily: "Sf",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 110, 110, 110)),
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        value: _isSelected,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            _isSelected = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        header: Container(
                          height: 80,
                          margin: EdgeInsets.only(left: 0, right: 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          width: SizeConfig.blockSizeHorizontal * 92,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 22, right: 22),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Privacidad",
                                      style: TextStyle(
                                          fontFamily: "Sf-r",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 57, 57, 57)),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Contactos bloqueados, Visibilidad en otros colegios",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 184, 184, 184)),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 28,
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Image.asset(
                                      'assets/images/avatars.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDialogWave,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          width: SizeConfig.blockSizeHorizontal * 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Notificaciones",
                                style: TextStyle(
                                    fontFamily: "Gibson",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: SwitchListTile(
                                  title: Text(
                                    "Mensajes privados",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 57, 57, 57)),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  value: _isSelected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isSelected = newValue;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: SwitchListTile(
                                  title: Text(
                                    "Modificaciones en favoritos",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 57, 57, 57)),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  value: _isMarcked,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isMarcked = newValue;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: SwitchListTile(
                                  title: Text(
                                    "Valoraciones",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 57, 57, 57)),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  value: _isTicked,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _isTicked = newValue;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                        width: SizeConfig.blockSizeHorizontal * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: _showDialogInvita,
                              child: Text(
                                "Invita a un amigo",
                                style: TextStyle(
                                    fontFamily: "Gibson",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Ayuda",
                                  style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 57, 57, 57)),
                                ),
                              ),
                              onTap: _showDialogAyuda,
                            ),
                            GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(
                                    "Cerrar sesión",
                                    style: TextStyle(
                                        fontFamily: "Gibson",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 57, 57, 57)),
                                  ),
                                ),
                                onTap: () async {
                                  try {
                                    final auth = Provider.of<BaseAuth>(context,
                                        listen: false);
                                    await auth.signOut();
                                    BlocProvider.of<UserBloc>(context).add(UnloadUser());
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FirstscreenWidget(),
                                      ),
                                    );
                                  } catch (e) {
                                    print(e.message);
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -0.8,
            child: ConfigurableExpansionTile(
              headerExpanded: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: SizeConfig.blockSizeHorizontal * 100,
                height: 505,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 75,
                      margin: EdgeInsets.only(left:18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 19),
                              Text(
                                "Perfil",
                                style: TextStyle(
                                    fontFamily: "Sf-r",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                              ),
                              Text(
                                "Nombre, Apellido, Colegio, Curso, Rol",
                                style: TextStyle(
                                    fontFamily: "Sf",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 184, 184, 184)),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            child: GestureDetector(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  Positioned(
                                    right: 10,
                                    top: 8,
                                    child: CircleAvatar(
                                      radius: 23.0,
                                      backgroundImage:
                                      editedImage && _image!= null?FileImage(_image):user.fotoPerfil,
                                    ),
                                  ),
                                  Positioned(
                                    right: 35,
                                    top: 30,
                                    child: CircleAvatar(
                                      radius: 12.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/logocolegio-fds.png"),
                                    ),
                                  ),
                                ],
                              ),
                                onTap: () => selectImage(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left:18, right: 18),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Cambiar nombre y apellido",
                            style: TextStyle(
                                fontFamily: "Sf",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(
                                    255, 110, 110, 110)),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 44,
                                width: SizeConfig.blockSizeHorizontal*37,
                                padding: EdgeInsets.only(left: 18),
                                decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    width: 1,
                                    color:
                                    Color.fromARGB(100, 112, 112, 112)),
                              ),
                                child:Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                      user.nombre, // TODO aca va el nombre del usuario registrado
                                      alignLabelWithHint: true,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 120, 120, 120),
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                    maxLines:
                                    1, //TODO resolver tema del overflow
                                    keyboardType:
                                    TextInputType.emailAddress,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                              Container(
                                height: 44,
                                width: SizeConfig.blockSizeHorizontal*37,
                                padding: EdgeInsets.only(left: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                      Color.fromARGB(100, 112, 112, 112)),
                                ),
                                child:Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                      user.apellido, // TODO aca va el nombre del usuario registrado
                                      alignLabelWithHint: true,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 120, 120, 120),
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                    maxLines:
                                    1, //TODO resolver tema del overflow
                                    keyboardType:
                                    TextInputType.emailAddress,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    user.getRole() == "Padre"?
                    createParentLayout(user)
                        :
                    Container(child: Text("Hola Alumne"),),
                  ],
                ),
              ),
              header: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: SizeConfig.blockSizeHorizontal * 100,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 75,
                      margin: EdgeInsets.only(left:18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 19),
                              Text(
                                "Perfil",
                                style: TextStyle(
                                    fontFamily: "Sf-r",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                              ),
                              Text(
                                "Nombre, Apellido, Colegio, Curso, Rol",
                                style: TextStyle(
                                    fontFamily: "Sf",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 184, 184, 184)),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  Positioned(
                                    right: 10,
                                    top: 8,
                                    child: CircleAvatar(
                                      radius: 23.0,
                                      backgroundImage:
                                      user.fotoPerfil,
                                    ),
                                  ),
                                  Positioned(
                                    right: 35,
                                    top: 30,
                                    child: CircleAvatar(
                                      radius: 12.0,
                                      backgroundImage: AssetImage(
                                          "assets/images/logocolegio-fds.png"),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> createDropDownMenuListWithIndexValues(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for(int i=0;i<lista.length;i++) {
      String item = lista[i];
      dropdownMenuItemList.add(DropdownMenuItem<int>(
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
        value: i,
      ));
    }
    return dropdownMenuItemList;
  }

  List<DropdownMenuItem> createDropDownMenuListSmall(List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for (String item in lista) {
      dropdownMenuItemList.add(DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 2, bottom: 2),
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 38, 65),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
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

  Widget createParentLayout(Padre user){
    hijos = user.hijos;
    hijoNameController.text = hijos[indexHijo].nombre;
    return Container(
      constraints: BoxConstraints.expand(height: 300),
      width: SizeConfig.blockSizeHorizontal*70,
      margin: EdgeInsets.only(left: 0, right: 0),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Hijos",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(
                        255, 110, 110, 110)),
              ),

              Container(
                width: SizeConfig.blockSizeHorizontal*25,
                height: 45,
                margin: EdgeInsets.only(right: 5),
                child: new DropdownButton(
                  icon: Icon(Icons.menu),
                  underline: Text(""),
                  items:user is Padre? createDropDownMenuListWithIndexValues( user.getHijosNames() ):createDropDownMenuListWithIndexValues(['No pudimos cargar bien tu informacion']),
                  isExpanded: true,
                  value: indexHijo,
                  hint: new Text(
                    '${hijos[0].nombre}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 38, 65),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      indexHijo = value;
                      hijoNameController.text = hijos[indexHijo].nombre;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            height: 2,
            width: SizeConfig.blockSizeHorizontal*90,
            color:Colors.black12,
          ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Cambiar nombre",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(
                        255, 110, 110, 110)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 24,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: TextField(
                      controller: hijoNameController,
                      decoration: InputDecoration(

                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(
                            255, 120, 120, 120),
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      maxLines:
                      1, //TODO resolver tema del overflow
                      autocorrect: false,
                      textAlign: TextAlign.right,
                      onChanged: (text){
                        hijos[indexHijo].nombre = text;
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.person, size: 18, color:Colors.black38)
                ],
              ),

            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Colegio",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(
                        255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc,ColegiosBlocState>(
                builder: (context,state){
                  if(state is ColegiosLoaded){
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child:                   Container(
                        width: SizeConfig.blockSizeHorizontal*55,
                        height: 15,
                        margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical * 1),
                        child: Opacity(
                          opacity: 0.37,
                          child: new DropdownButton(
                            icon: Icon(Icons.menu),
                            underline: Text(""),
                            items: createDropDownMenuListSmall(state.colegiosData.colegios),
                            isExpanded: true,
                            value: hijos[indexHijo].colegio,
                            hint: new Text(
                              'COLEGIO',
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 38, 65),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 19,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                hijos[indexHijo].colegio = value;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }else{//Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },

              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Curso",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(
                        255, 110, 110, 110)),
              ),
              Container(
                height: 38,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 3),
                      BlocBuilder<ColegiosBloc,ColegiosBlocState>(
                        builder: (context,state){
                          if(state is ColegiosLoaded){
                            return Container(
                              height: 38,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30))),
                              child:                   Container(
                                width: SizeConfig.blockSizeHorizontal*55,
                                height: 15,
                                margin: EdgeInsets.only( top: SizeConfig.blockSizeVertical * 1),
                                child: Opacity(
                                  opacity: 0.37,
                                  child: new DropdownButton(
                                    icon: Icon(Icons.menu),
                                    underline: Text(""),
                                    items: createDropDownMenuListSmall(state.colegiosData.cursos),
                                    isExpanded: true,
                                    value: hijos[indexHijo].curso,
                                    hint: new Text(
                                      'Curso',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 53, 38, 65),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        hijos[indexHijo].curso = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }else{//Colegios loading
                            BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                            return Container(child: Text("LOADING"));
                          }
                        },

                      ),
                    ]),
              ),

            ],
          ),


        ],
      ),
    );
  }

  void aceptarCambios(){
      if(auxUser != null && originalUser != null){
        if(auxUser != originalUser && editedImage == true){
          auxUser.fotoPerfilRaw = _image;
          BlocProvider.of<UploadsBloc>(context).add(EditUserProfile(auxUser));
          if(auxUser != originalUser){
            BlocProvider.of<UploadsBloc>(context).add(EditUserInfo(auxUser));
          }else if(editedImage){
            BlocProvider.of<UploadsBloc>(context).add(EditUserImage(auxUser));
          }
        }
      }
  }

  void cancelarCambios(){
    if(auxUser != null && originalUser!= null){
      setState(() {
        auxUser = originalUser;
      });
    }
  }

  void changeRoles(){
    setState(() {
      if(auxUser!= null){
        auxUser = auxUser.changeRole();
      }
    });
  }


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(auxUser != null){
      setState(() {
        _image = image;
        editedImage = true;
      });
    }

  }

  Future<void> _cropImage() async {
    if(auxUser!= null){
      File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        //ratioX: 1.0,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      setState(() {
        _image = cropped ?? _image;
        editedImage = true;
      });
    }

  }

  void selectImage() {
    try {
      getImage().then((anything) => _cropImage());
    }catch(e){
      editedImage = false;
    }
  }

  void _showDialogAyuda() {
    showSlideDialogGrande(
      context: context,
      child: CustomDialog(
        title: "¿Estas seguro?",
        description: "Deberas volver a iniciar sesión",
        primaryButtonText: "Si",
        primaryButtonRoute: "/logOut",
        secondaryButtonText: "Cancelar",
        secondaryButtonRoute: "/home",
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  void _showDialogInvita() {
    showSlideDialogGrande(
      context: context,
      child: CustomDialog(
        title: "Comparte la app",
        description: "www.link.poronga",
        primaryButtonText: "Copiar",
        primaryButtonRoute: "/home",
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  void _showDialogWave() {
    showSlideDialogChico(
        context: context,
        child: /*LoadingDialog()*/
            ErrorDialog(
          title: "Oops...",
          error: "Parece que no has completado todos los datos.",
        )
        // barrierColor: Colors.white.withOpacity(0.7),
        // pillColor: Colors.red,
        // backgroundColor: Colors.yellow,
        );
  }

  Widget buildEtiquetaBloqueado(String url, String colegioName) {
    return UnconstrainedBox(
      child: Container(
        height: 38,
        margin: EdgeInsets.only(bottom: 10, right: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 25,
            width: 25,
            child: Image.asset(
              url,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 3),
          Container(
            width: 80,
            child: Text(
              colegioName,
              style: TextStyle(
                fontFamily: "Sf-r",
                color: Color.fromARGB(255, 27, 27, 27),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 1, right: 3),
              child: Icon(
                Icons.close,
                size: 22,
              )),
        ]),
      ),
    );
  }


}
