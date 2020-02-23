import 'package:flutter/material.dart';
import 'package:flutterui/dialog_widget/custom_dialog.dart';
import 'package:flutterui/dialog_widget/error_dialog.dart';
import 'package:flutterui/dialog_widget/loading_dialog.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutterui/copy_slide_dialog/slide_popup_dialog.dart' as slideDialog;
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
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
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 80,
                    minHeight: SizeConfig.blockSizeVertical * 80,
                    backdropEnabled: false,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.blockSizeVertical*19,
            child: ConfigurableExpansionTile(
              headerExpanded: Container(
                padding: EdgeInsets.fromLTRB(28, 5, 20, 5),
                width: SizeConfig.blockSizeHorizontal * 100,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Perfil",
                          style: TextStyle(
                              fontFamily:"Sf-r",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                        Text(
                          "Nombre, Apellido, Colegio, Curso, Rol",
                          style: TextStyle(
                              fontFamily:"Sf",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 184, 184, 184)
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Positioned(
                            top:8,
                            child: CircleAvatar(
                              radius: 23.0,
                              backgroundImage: AssetImage("assets/images/avatar.png"),
                            ),
                          ),
                          Positioned(
                            right: 25,
                            bottom: 5,
                            child: CircleAvatar(
                              radius: 12.0,
                              backgroundImage: AssetImage( "assets/images/logocolegio-fds.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              header: Container(
                padding: EdgeInsets.fromLTRB(28, 5, 20, 5),
                width: SizeConfig.blockSizeHorizontal * 100,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Perfil",
                          style: TextStyle(
                              fontFamily:"Sf-r",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                        Text(
                          "Nombre, Apellido, Colegio, Curso, Rol",
                          style: TextStyle(
                              fontFamily:"Sf",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 184, 184, 184)
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Positioned(
                            top:8,
                             child: CircleAvatar(
                                radius: 23.0,
                                backgroundImage: AssetImage("assets/images/avatar.png"),
                              ),
                          ),
                          Positioned(
                            right: 25,
                              bottom: 5,
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundImage: AssetImage( "assets/images/logocolegio-fds.png"),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Container(
      height: 220,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: FadingEdgeScrollView.fromScrollView(
        child: ListView(
          controller: sc,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 7),
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Cuenta",
                          style: TextStyle(
                              fontFamily:"Gibson",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Text(
                                "Cambiar mail",
                                style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                "Cambiar contraseña",
                                style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Privacidad",
                          style: TextStyle(
                              fontFamily:"Gibson",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Text(
                                "Contactos bloqueados",
                                style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => CustomDialog(
                                    title: "¿Seguro que quiere eliminar su perfil?",
                                    description:
                                    "Todos sus datos seran eliminados y debera volver a crear una cuenta",
                                    primaryButtonText: "Si",
                                    primaryButtonRoute: "/logOut",
                                    secondaryButtonText: "Cancelar",
                                    secondaryButtonRoute: "/home",
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  "Eliminar cuenta",
                                  style: TextStyle(
                                      fontFamily:"Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Privacidad",
                          style: TextStyle(
                              fontFamily:"Gibson",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Text(
                                "Contactos bloqueados",
                                style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => CustomDialog(
                                    title: "¿Seguro que quiere eliminar su perfil?",
                                    description:
                                    "Todos sus datos seran eliminados y debera volver a crear una cuenta",
                                    primaryButtonText: "Si",
                                    primaryButtonRoute: "/logOut",
                                    secondaryButtonText: "Cancelar",
                                    secondaryButtonRoute: "/home",
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  "Eliminar cuenta",
                                  style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ConfigurableExpansionTile(
                    headerExpanded: Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                      width: SizeConfig.blockSizeHorizontal * 88,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 246, 246),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Privacidad",
                            style: TextStyle(
                                fontFamily:"Gibson",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 57, 57, 57)
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Text(
                                  "Contactos bloqueados",
                                  style: TextStyle(
                                      fontFamily:"Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 57, 57, 57)
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CustomDialog(
                                      title: "¿Seguro que quiere eliminar su perfil?",
                                      description:
                                      "Todos sus datos seran eliminados y debera volver a crear una cuenta",
                                      primaryButtonText: "Si",
                                      primaryButtonRoute: "/logOut",
                                      secondaryButtonText: "Cancelar",
                                      secondaryButtonRoute: "/home",
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Eliminar cuenta",
                                    style: TextStyle(
                                      fontFamily:"Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    header: Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                      width: SizeConfig.blockSizeHorizontal * 88,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 246, 246),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Privacidad",
                            style: TextStyle(
                                fontFamily:"Gibson",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 57, 57, 57)
                            ),
                          ),
                        ],
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
                                fontFamily:"Gibson",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 57, 57, 57)
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: SwitchListTile(
                              title: Text(
                                "Mensajes privados",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
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
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
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
                                    fontFamily:"Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                ),
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
                                fontFamily:"Gibson",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 57, 57, 57)
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              "Ayuda",
                              style: TextStyle(
                                  fontFamily:"Gibson",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 57, 57, 57)
                              ),
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
                                  fontFamily:"Gibson",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 57, 57, 57)
                              ),
                            ),
                          ),
                        onTap: () async {
                          try {
                            final auth = Provider.of<BaseAuth>(
                                context, listen: false);
                            await auth.signOut();
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstscreenWidget(),
                              ),
                            );
                          } catch (e) {
                            print(e.message);
                          }
                        }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
  void _showDialogAyuda() {
    slideDialog.showSlideDialogGrande(
      context: context,
      child: CustomDialog(
        title: "¿Estas seguro?",
        description:
        "Deberas volver a iniciar sesión",
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
    slideDialog.showSlideDialogGrande(
      context: context,
      child: CustomDialog(
        title: "Comparte la app",
        description:
        "www.link.poronga",
        primaryButtonText: "Copiar",
        primaryButtonRoute: "/home",
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  void _showDialogWave() {
    slideDialog.showSlideDialogChico(
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

}
