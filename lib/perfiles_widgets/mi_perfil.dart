
import 'dart:io';
import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/school_model.dart';
import 'package:flutterui/WidgetsCopy/Animated_screen.dart';
import 'package:flutterui/WidgetsCopy/dropdown_magic.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/create_school_dialog.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/values/colors.dart';
import 'package:simple_animations/simple_animations.dart';


import '../auth.dart';

class MiPerfil extends StatefulWidget {
  MiPerfil({Key key}) : super(key: key);

  bool isSelected = false;
  bool isAllDataCorrect = false;

  @override
  _MiPerfilState createState() => _MiPerfilState();
}

bool _isSelected = false;
bool _isMarcked = false;
bool _isTicked = false;

class _MiPerfilState extends State<MiPerfil> {
  String colegioSelectedValue, cursoSelectedValue, hijosSelectedValue;
  List<Hijo> hijos;
  int indexHijo = 0;
  TextEditingController hijoNameController = new TextEditingController(),
      nombreTextController = new TextEditingController(),
      apellidoTextController = new TextEditingController();
  User auxUser, originalUser;
  bool editedImage = false, variablesHaveBeenSet = false;
  File _image;
  FirebaseAnalytics analytics;

  @override
  void initState() {
    analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/subir_libro/subir_foto_libro");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocBuilder<UserBloc, UserBlocState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            User user = state.user;
            originalUser = user;
            if (variablesHaveBeenSet == false) {
              auxUser = user.clone();
              nombreTextController.text = auxUser.nombre;
              apellidoTextController.text = auxUser.apellido;
              variablesHaveBeenSet = true;
            }

            return Stack(
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        top: SizeConfig.blockSizeVertical * 11,
                        right: 0,
                        child: Container(
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

                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: SlidingUpPanel(
                          panelBuilder: (ScrollController sc) =>
                              _scrollingList(sc, auxUser),
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8,left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
                        SizedBox(width: 10),
                        Text(
                          "Ajustes",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _scrollingList(ScrollController sc, User user) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Container(
      height: 220,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: ListView(
          controller: sc,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ConfigurableExpansionTile(
                  headerExpanded: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: SizeConfig.blockSizeHorizontal * 90,
                    height: SizeConfig.blockSizeVertical * 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withAlpha(60),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 75,
                            margin: EdgeInsets.only(left: 22, right: 5),
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
                                          color: Theme.of(context).textTheme.headline2.color),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Nombre, Apellido, Colegio, Curso, Rol",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          Color.fromARGB(255, 184, 184, 184)),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 60,
                                  child: GestureDetector(
                                    onTap: () => selectImage(),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: <Widget>[
                                        Positioned(
                                          right: 10,
                                          top: 15,
                                          child: CircleAvatar(
                                            radius: 23.0,
                                            backgroundImage:
                                            editedImage && _image != null
                                                ? FileImage(_image)
                                                : user.getProfileImage(),
                                          ),
                                        ),
                                        Positioned(
                                            right: 32,
                                            top: 40,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: AppColors
                                                        .secondaryBackground,
                                                    width: 1.5),
                                              ),
                                              child: Icon(Icons.edit,
                                                  color:
                                                  AppColors.secondaryBackground,
                                                  size: 18),
                                            ) /*CircleAvatar(
                                    radius: 12.0,
                                    backgroundImage: AssetImage(
                                        "assets/images/logocolegio-fds.png"),
                                ),*/
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(left: 18, right: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Nombre",
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
                                    widget.isSelected = false;
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
                                  controller: apellidoTextController,
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
                                    widget.isSelected = false;
                                    print(text);
                                  },
                                  onSubmitted: (data) {
                                    print(data.length);
                                  },
                                ),
                                SizedBox(height: 30),
                                user.getRole() == "Padre"
                                    ? createStudentLayoutNew(user)
                                    : Container(),
                                SizedBox(height: 30),
                                Row(
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
                                              "Mail",
                                              style: TextStyle(
                                                  fontFamily: "Sf-r",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context).textTheme.headline2.color),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(Icons.lock, size: 18)
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          user.email,
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
                                        color: Theme.of(context).iconTheme.color.withAlpha(30))
                                  ],
                                ),


                                SizedBox(height: 80),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 44,
                                      width: SizeConfig.blockSizeHorizontal * 37,
                                      padding: EdgeInsets.only(left: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                            Color.fromARGB(100, 112, 112, 112)),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: nombreTextController,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color:
                                            Color.fromARGB(255, 120, 120, 120),
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                          maxLines:
                                          1, //TODO resolver tema del overflow
                                          keyboardType: TextInputType.emailAddress,
                                          autocorrect: false,
                                          onChanged: (a)=>  widget.isSelected = false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      width: SizeConfig.blockSizeHorizontal * 37,
                                      padding: EdgeInsets.only(left: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                            Color.fromARGB(100, 112, 112, 112)),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: apellidoTextController,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color:
                                            Color.fromARGB(255, 120, 120, 120),
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                          maxLines:
                                          1, //TODO resolver tema del overflow
                                          keyboardType: TextInputType.emailAddress,
                                          autocorrect: false,
                                          onChanged: (a)=>  widget.isSelected = false,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          user.getRole() == "Padre"
                              ? createParentLayout(user)
                              : createStudentLayout(user),
                        ],
                      ),
                    ),
                  ),
                  header: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: SizeConfig.blockSizeHorizontal * 90,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 80,
                            margin: EdgeInsets.only(left: 22, right: 5),
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
                                          color: Theme.of(context).textTheme.headline2.color),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Nombre, Apellido, Colegio, Curso, Rol",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          Color.fromARGB(255, 184, 184, 184)),
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
                                        top: 15,
                                        child: CircleAvatar(
                                          radius: 23.0,
                                          backgroundImage: user.getProfileImage(),
                                        ),
                                      ),
                                      /* Positioned(
                              right: 35,
                              top: 30,
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundImage: AssetImage(
                                    "assets/images/logocolegio-fds.png"),
                              ),
                            ),*///Todo logo colegio
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
                SizedBox(height: 20),
                ConfigurableExpansionTile(
                  headerExpanded: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Theme.of(context).hoverColor,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 75,
                            margin: EdgeInsets.only(left: 18),
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
                                          color: Theme.of(context).textTheme.headline2.color),
                                    ),
                                    Text(
                                      "Nombre, Apellido, Colegio, Curso, Rol",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          Color.fromARGB(255, 184, 184, 184)),
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
                                            editedImage && _image != null
                                                ? FileImage(_image)
                                                : user.getProfileImage(),
                                          ),
                                        ),
                                        Positioned(
                                            right: 32,
                                            top: 30,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: AppColors
                                                        .secondaryBackground,
                                                    width: 1.5),
                                              ),
                                              child: Icon(Icons.edit,
                                                  color:
                                                  AppColors.secondaryBackground,
                                                  size: 18),
                                            ) /*CircleAvatar(
                                  radius: 12.0,
                                  backgroundImage: AssetImage(
                                      "assets/images/logocolegio-fds.png"),
                                ),*/
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
                            margin: EdgeInsets.only(left: 18, right: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Cambiar nombre y apellido",
                                  style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 110, 110, 110)),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 44,
                                      width: SizeConfig.blockSizeHorizontal * 37,
                                      padding: EdgeInsets.only(left: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                            Color.fromARGB(100, 112, 112, 112)),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: nombreTextController,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color:
                                            Color.fromARGB(255, 120, 120, 120),
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                          maxLines:
                                          1, //TODO resolver tema del overflow
                                          keyboardType: TextInputType.emailAddress,
                                          autocorrect: false,
                                          onChanged: (a)=>  widget.isSelected = false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      width: SizeConfig.blockSizeHorizontal * 37,
                                      padding: EdgeInsets.only(left: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                            Color.fromARGB(100, 112, 112, 112)),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: apellidoTextController,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color:
                                            Color.fromARGB(255, 120, 120, 120),
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                          maxLines:
                                          1, //TODO resolver tema del overflow
                                          keyboardType: TextInputType.emailAddress,
                                          autocorrect: false,
                                          onChanged: (a)=>  widget.isSelected = false,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          user.getRole() == "Padre"
                              ? createParentLayout(user)
                              : createStudentLayout(user),
                        ],
                      ),
                    ),
                  ),
                  header: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Theme.of(context).hoverColor,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 75,
                            margin: EdgeInsets.only(left: 18),
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
                                          color: Theme.of(context).textTheme.headline2.color),
                                    ),
                                    Text(
                                      "Nombre, Apellido, Colegio, Curso, Rol",
                                      style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          Color.fromARGB(255, 184, 184, 184)),
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
                                        top: 15,
                                        child: CircleAvatar(
                                          radius: 23.0,
                                          backgroundImage: user.getProfileImage(),
                                        ),
                                      ),
                                      /* Positioned(
                              right: 35,
                              top: 30,
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundImage: AssetImage(
                                    "assets/images/logocolegio-fds.png"),
                              ),
                            ),*///Todo logo colegio
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
                SizedBox(height: 20),
                ConfigurableExpansionTile(
                  headerExpanded: Container(
                    height: 155,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    width: SizeConfig.blockSizeHorizontal * 92,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withAlpha(40),
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
                                            color: Theme.of(context).textTheme.headline2.color),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.lock, size: 18)
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Mail",
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
                                  color: Theme.of(context).iconTheme.color.withAlpha(30)),
                            ],
                          ),
                        ),
                        /* Container(
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
                                margin: EdgeInsets.only(left: 10, top: 10),
                                width: SizeConfig.blockSizeHorizontal * 60,
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
                        ),*/ //TODO para future update confirmar contraseña
                        SizedBox(height: 30),
                        Container(
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
                                    "Mail",
                                    style: Theme.of(context).textTheme.headline2,
                                  ),
                                  Container(
                                    height: 24,
                                    margin: EdgeInsets.only(left: 10),
                                    width:
                                        SizeConfig.blockSizeHorizontal *
                                            50,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: user.email,
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
                              /*SizedBox(height: 30),*/
                              /*Row(
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
                              ),*/ //TODO para future update
                              /*  SizedBox(height: 30),*/
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              ),*/ // TODO para future update eliminar cuenta
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  header: Container(
                    height: 80,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                    width: SizeConfig.blockSizeHorizontal * 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withAlpha(40),
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
                                            color: Theme.of(context).textTheme.headline2.color),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.lock, size: 18)
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Mail",
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
                                  color: Theme.of(context).iconTheme.color.withAlpha(30))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                /*  ConfigurableExpansionTile(
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
                          color: Colors.red,
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
                ),*/ //TODO Para agregar en un futuro
                /*GestureDetector(
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
                ),*/ //TODO para agregar en un futuro
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 60),
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
                              color: Theme.of(context).textTheme.headline4.color),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 5),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Politica de Privacidad ",
                                style: TextStyle(
                                  fontFamily: "Gibson",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                    color: Theme.of(context).textTheme.headline4.color,
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://docs.google.com/document/d/1Nlxwy9yRapiRkWzmYDiEp6EklW22LBzkeqiPn1Rv-1Y/edit?usp=sharing');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 5),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Terminos y condiciones ",
                                style: TextStyle(
                                  fontFamily: "Gibson",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                    color: Theme.of(context).textTheme.headline4.color
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://docs.google.com/document/d/1UxNGanYn83-RnF1BFWZm7dO5uJXW-B-ce9G8aNHZhQo/edit?usp=sharing');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 5),
                          child: Text(
                            "Ayuda",
                            style: TextStyle(
                                fontFamily: "Gibson",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.headline4.color),
                          ),
                        ),
                        onTap: _showDialogAyuda,
                      ),
                      GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 5),
                            child: Text(
                              "Cerrar sesión",
                              style: TextStyle(
                                  fontFamily: "Gibson",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).textTheme.headline4.color),
                            ),
                          ),
                          onTap: _showDialogSignOut),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> createDropDownMenuListWithIndexValues(
      List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for (int i = 0; i < lista.length; i++) {
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
                    fontFamily: "Sf-r",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
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
      dropdownMenuItemList.add(DropdownMenuItem<String>(
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

  List<DropdownMenuItem> createDropDownMenuListSmallColegios(
      List<String> lista) {
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for (String item in lista) {
      dropdownMenuItemList.add(DropdownMenuItem<String>(
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
    String agregarColegio = "+ Agregar Colegio";
    dropdownMenuItemList.add(DropdownMenuItem<String>(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 2, bottom: 2),
              child: new Text(
                agregarColegio,
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
      value: agregarColegio,
    ));
    return dropdownMenuItemList;
  }

  Widget createStudentLayoutNew(Alumno user) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<ColegiosBloc, ColegiosBlocState>(
            builder: (context, state) {
              if (state is ColegiosLoaded) {
                return Column(
                  children: [
                   Container(color: Colors.red,
                   height:20,
                   width: 21,),
                    Container(
                      child: new DropdownButton(
                        icon: Icon(
                          Icons.edit,
                          size: 15,
                        ),
                        underline: Text(""),
                        items: createDropDownMenuListSmallColegios(
                            state.colegiosData.colegios),
                        isExpanded: true,
                        value: user.colegio,
                        hint: new Text(
                          'COLEGIO',
                          style: TextStyle(
                            color: Color.fromARGB(255, 53, 38, 65),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onChanged: (value) {
                          if (value == "+ Agregar Colegio") {
                            showSchoolDialog(context, user.email);
                          } else {
                            setState(() {
                              user.colegio = value;
                              widget.isSelected = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                //Colegios loading
                BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                return Container(child: Text("LOADING"));
              }
            },
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Curso",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                builder: (context, state) {
                  if (state is ColegiosLoaded) {
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 24,
                        height: 15,
                        margin: EdgeInsets.only(top: 6),
                        child: Opacity(
                          opacity: 0.37,
                          child: new DropdownButton(
                            icon: Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            underline: Text(""),
                            items: createDropDownMenuListSmall(
                                state.colegiosData.cursos),
                            isExpanded: true,
                            value: user.curso,
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
                                user.curso = value;
                                widget.isSelected = false;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    //Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FilterChip(
                label: Text('${widget.isSelected ? widget.isAllDataCorrect? 'Guardado':'No se Guardo' : 'Guardar'}', textAlign: TextAlign.center,),
                labelPadding: EdgeInsets.only(top: 2, bottom: 2, right: 10, left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                labelStyle: widget.isSelected
                    ?TextStyle(
                    fontFamily: "Sf-r",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)
                    : TextStyle(
                  fontFamily: "Sf-r",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,),
                selected: widget.isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    widget.isSelected = !widget.isSelected;
                    widget.isAllDataCorrect = aceptarCambios();
                  });
                },
                backgroundColor: Color.fromARGB(200, 0, 191, 131),
                selectedColor: widget.isAllDataCorrect? AppColors.secondaryBackground: Colors.red,
                checkmarkColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget createStudentLayout(Alumno user) {
    return Container(
      constraints: BoxConstraints.expand(height: 380),
      width: SizeConfig.blockSizeHorizontal * 70,
      margin: EdgeInsets.only(left: 0, right: 0),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Container(
            height: 2,
            width: SizeConfig.blockSizeHorizontal * 90,
            color: Colors.black12,
          ),
          SizedBox(height: 45),
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
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                builder: (context, state) {
                  if (state is ColegiosLoaded) {
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 45,
                        height: 15,
                        margin: EdgeInsets.only(top: 6),
                        child: Opacity(
                          opacity: 0.37,
                          child: Center(
                            child: new DropdownButton(
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              underline: Text(""),
                              items: createDropDownMenuListSmallColegios(
                                  state.colegiosData.colegios),
                              isExpanded: true,
                              value: user.colegio,
                              hint: new Text(
                                'COLEGIO',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 38, 65),
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onChanged: (value) {
                                if (value == "+ Agregar Colegio") {
                                  showSchoolDialog(context, user.email);
                                } else {
                                  setState(() {
                                    user.colegio = value;
                                    widget.isSelected = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    //Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Curso",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                builder: (context, state) {
                  if (state is ColegiosLoaded) {
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 24,
                        height: 15,
                        margin: EdgeInsets.only(top: 6),
                        child: Opacity(
                          opacity: 0.37,
                          child: new DropdownButton(
                            icon: Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            underline: Text(""),
                            items: createDropDownMenuListSmall(
                                state.colegiosData.cursos),
                            isExpanded: true,
                            value: user.curso,
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
                                user.curso = value;
                                widget.isSelected = false;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    //Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FilterChip(
                label: Text('${widget.isSelected ? widget.isAllDataCorrect? 'Guardado':'No se Guardo' : 'Guardar'}', textAlign: TextAlign.center,),
                labelPadding: EdgeInsets.only(top: 2, bottom: 2, right: 10, left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                labelStyle: widget.isSelected
                    ?TextStyle(
                    fontFamily: "Sf-r",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)
                    : TextStyle(
                  fontFamily: "Sf-r",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,),
                selected: widget.isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    widget.isSelected = !widget.isSelected;
                    widget.isAllDataCorrect = aceptarCambios();
                  });
                },
                backgroundColor: Color.fromARGB(200, 0, 191, 131),
                selectedColor: widget.isAllDataCorrect? AppColors.secondaryBackground: Colors.red,
                checkmarkColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget createParentLayout(Padre user) {
    hijos = user.hijos;
    hijoNameController.text = hijos[indexHijo].nombre;
    return Container(
      constraints: BoxConstraints.expand(height: 380),
      width: SizeConfig.blockSizeHorizontal * 70,
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
              GestureDetector(
                onTap: () => addHijo(user),
                child: Row(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.7,
                      child: Container(
                        height: 19,
                        width: 19,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Hijos",
                      style: TextStyle(
                          fontFamily: "Sf",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 110, 110, 110)),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 25,
                height: 45,
                margin: EdgeInsets.only(right: 5),
                child: new DropdownButton(
                  icon: Icon(Icons.menu),
                  underline: Text(""),
                  items: user is Padre
                      ? createDropDownMenuListWithIndexValues(
                          user.getHijosNames())
                      : createDropDownMenuListWithIndexValues(
                          ['No pudimos cargar bien tu informacion']),
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
            width: SizeConfig.blockSizeHorizontal * 90,
            color: Colors.black12,
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
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 24,
                    width: SizeConfig.blockSizeHorizontal * 30,
                    child: TextField(
                      controller: hijoNameController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 120, 120, 120),
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),

                      maxLines: 1, //TODO resolver tema del overflow
                      autocorrect: false,
                      textAlign: TextAlign.right,
                      onChanged: (text) {
                        hijos[indexHijo].nombre = text;
                        widget.isSelected = false;
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.person, size: 18, color: Colors.black38)
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
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                builder: (context, state) {
                  if (state is ColegiosLoaded) {
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 45,
                        height: 15,
                        margin: EdgeInsets.only(top: 6),
                        child: Opacity(
                          opacity: 0.37,
                          child: Center(
                            child: new DropdownButton(
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              underline: Text(""),
                              items: createDropDownMenuListSmallColegios(
                                  state.colegiosData.colegios),
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
                                textAlign: TextAlign.center,
                              ),
                              onChanged: (value) {
                                if (value == "+ Agregar Colegio") {
                                  showSchoolDialog(context, user.email);
                                } else {
                                  setState(() {
                                    hijos[indexHijo].colegio = value;
                                    widget.isSelected = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    //Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Curso",
                style: TextStyle(
                    fontFamily: "Sf",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 110, 110, 110)),
              ),
              BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                builder: (context, state) {
                  if (state is ColegiosLoaded) {
                    return Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 24,
                        height: 15,
                        margin: EdgeInsets.only(top: 6),
                        child: Opacity(
                          opacity: 0.37,
                          child: new DropdownButton(
                            icon: Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            underline: Text(""),
                            items: createDropDownMenuListSmall(
                                state.colegiosData.cursos),
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
                                widget.isSelected = false;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    //Colegios loading
                    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
                    return Container(child: Text("LOADING"));
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              user.getHijosNames().length > 1
                  ? GestureDetector(
                      onTap: () => eliminarHijo(user),
                      child: Text(
                        "Eliminar perfil \n de hijo",
                        style: TextStyle(
                            fontFamily: "Sf",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(100, 110, 110, 110)),
                      ),
                    )
                  : Container(),

              FilterChip(
                label: Text('${widget.isSelected ? widget.isAllDataCorrect? 'Guardado':'No se Guardo' : 'Guardar'}', textAlign: TextAlign.center,),
                labelPadding: EdgeInsets.only(top: 2, bottom: 2, right: 10, left: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                labelStyle: widget.isSelected
                    ?TextStyle(
                    fontFamily: "Sf-r",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)
                    : TextStyle(
                    fontFamily: "Sf-r",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,),
                selected: widget.isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    widget.isSelected = !widget.isSelected;
                    widget.isAllDataCorrect = aceptarCambios();
                  });
                },
                backgroundColor: Color.fromARGB(200, 0, 191, 131),
                selectedColor: widget.isAllDataCorrect? AppColors.secondaryBackground: Colors.red,
                checkmarkColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool aceptarCambios() {
    print("BOTON DE ACEPTAR CAMBIOS ACEPTADO");
    if (auxUser != null && originalUser != null) {
      print("BOTON DE ACEPTAR CAMBIOS ACEPTADO--------1");
      auxUser.nombre = nombreTextController.text;
      auxUser.apellido = apellidoTextController.text;
      if (auxUser.nombre == null ||
          auxUser.nombre.length == 0 ||
          auxUser.apellido == null ||
          auxUser.apellido.length == 0) {
        print('0');
        showErrorDialog(context,
            "Debes completar tu nombre y apellido para poder guardar los cambios.");
        return false;
      }

      if (auxUser is Padre) {
        Padre auxauxUser = auxUser;
        auxauxUser.hijos.forEach((hijo) {
          if (hijo.nombre == null ||
              hijo.nombre == "Nombre" ||
              hijo.nombre.isEmpty) {
            print('1');
            showErrorDialog(context,
                "Debes ingresar un nombre valido para todos tus hijos.");
            return false;
          }
          if (hijo.colegio == null || hijo.colegio.isEmpty) {
            print('2');
            showErrorDialog(context,
                "Debes ingresar un colegio de la lista para cada uno de tus hijos.");
            return false;
          }
          if (hijo.curso == null || hijo.curso.isEmpty) {
            print('3');
            showErrorDialog(context,
                "Debes ingresar un curso de la lista para cada uno de tus hijos.");
            return false;
          }
        });
      }
      if (auxUser is Alumno) {
        auxUser.getColegios().forEach((colegio) {
          if (colegio == null) {
            showErrorDialog(context,
                "Debes ingresar un colegio de la lista para poder continuar.");
            return false;
          }
        });
        auxUser.getCursos().forEach((curso) {
          if (curso == null) {
            showErrorDialog(context,
                "Debes ingresar un curso de la lista para poder continuar.");
            return false;
          }
        });
      }
      if (auxUser != originalUser && editedImage == true) {
        print("BOTON DE ACEPTAR CAMBIOS ACEPTADO-------2");
        auxUser.fotoPerfilRaw = _image;
        BlocProvider.of<UploadsBloc>(context).add(EditUserProfile(auxUser));
      } else if (editedImage){
        print("BOTON DE ACEPTAR CAMBIOS ACEPTADO------4");
        if (_image != null) {
          auxUser.fotoPerfilRaw = _image;
          BlocProvider.of<UploadsBloc>(context).add(EditUserImage(auxUser));
        }
      } else{
        print("BOTON DE ACEPTAR CAMBIOS ACEPTADO-----3");
        BlocProvider.of<UploadsBloc>(context).add(EditUserInfo(auxUser));
      }
      return true;
    }
  }

  void cancelarCambios() {
    if (auxUser != null && originalUser != null) {
      setState(() {
        auxUser = originalUser;
      });
    }
  }

  eliminarHijo(Padre user) {
    print("ELIMINEEE HIJOOOOO -------------------------------------");
    if (user is Padre) {
      setState(() {
        int aux = indexHijo;
        if (indexHijo == user.getHijosNames().length - 1) {
          indexHijo -= 1;
        }
        user.removeHijo(aux);
      });
    }
  }

  addHijo(Padre user) {
    if (user is Padre) {
      setState(() {
        user.agregarHijo(Hijo("Nombre", "Florida Day School", "1er grado"));
      });
    }
  }

  void changeRoles() {
    setState(() {
      if (auxUser != null) {
        auxUser = auxUser.changeRole();
      }
    });
  }

  void showLoadingDialog(BuildContext context) {
    showSlideDialogChico(
        context: context,
        child: LoadingDialog(),
        animatedPill: true,
        barrierDismissible: false);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (auxUser != null) {
      setState(() {
        _image = image;
        editedImage = true;
      });
    }
  }

  Future<void> _cropImage() async {
    if (auxUser != null) {
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
    } catch (e) {
      editedImage = false;
    }
  }

  void _showDialogSignOut() {
    showSlideDialogGrande(
      context: context,
      child: CustomDialog.customFunctions(
        title: "¿Estas seguro?",
        description: "Deberas volver a iniciar sesión",
        primaryButtonText: "Cancelar",
        primaryFunction: () {
          Navigator.pop(context);
        },
        secondaryButtonText: "Cerrar Sesion",
        secondaryFunction: () async {
          try {
            final auth = Provider.of<BaseAuth>(context, listen: false);
            await auth.signOut();
            BlocProvider.of<UserBloc>(context).add(UnloadUser());
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => FirstscreenWidget(),
              ),
            );
          } catch (e) {
            print(e.message);
          }
        },
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  void _showDialogAyuda() {
    showSlideDialogGrande(
      context: context,
      child: CustomDialog.customFunctions(
        title: "Contactanos",
        description:
            "Ante cualquier problema o duda, no dudes en enviarnos un mail a \n buymy.customerservice@gmail.com",
        primaryButtonText: "Cancelar",
        primaryFunction: () {
          Navigator.pop(context);
        },
        secondaryButtonText: "Enviar Mail",
        secondaryFunction: () async {
          try {
//            if (Platform.isAndroid) {
//              AndroidIntent intent = AndroidIntent(
//                action: 'android.intent.action.MAIN',
//                category: 'android.intent.category.APP_EMAIL',
//              );
//              intent.launch().catchError((e) {
//                print(e.message);
//              });
//            } else if (Platform.isIOS) {
//              //launch("message://")
            launch("mailto:buymy.customerservice@gmail.com?subject=Duda/Consulta BuyMy&body=Estimados,les notifico que me ocurrio ...")
                .catchError((e) {
              print(e.message);
            });
            // }
          } catch (e) {
            print(e.message);
          }
        },
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  void _showDialogInvita() async {
    final auth = Provider.of<BaseAuth>(context, listen: false);
    final FirebaseUser firebaseUser = await auth.currentUser();
    final String userEmail = firebaseUser.email;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://buymy.page.link',
      link: Uri.parse('https://buymy.com.ar/'),
      androidParameters: AndroidParameters(
        packageName: 'com.tormakhindustries.buymy',
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tormakhindustries.buymypro',
        minimumVersion: '1.0',
        appStoreId: '1504741317',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'App invite',
        medium: 'app',
        source: '$userEmail',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Invitacion a BuyMy',
        description:
            'Te invito a que pruebes esta nueva app "BuyMy" para comprar y vender libros en forma agil y gratis.',
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    Share.share(shortUrl.toString());
    analytics.logShare(contentType: "invitation");
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
}
