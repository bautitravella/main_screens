import 'package:flutter/material.dart';
import 'package:flutterui/dialog_widget/custom_dialog.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

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
                Positioned(
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
                )
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
                    maxHeight: SizeConfig.blockSizeVertical * 90,
                    minHeight: SizeConfig.blockSizeVertical * 90,
                    backdropEnabled: false,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Container(
              height: 143,
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  //Positioned(
                  //                    right: 0,
                  //                    top: 0,
                  //                    child: Align(
                  //                      alignment: Alignment.topRight,
                  //                      child: Container(
                  //                        width: 138,
                  //                        height: 143,
                  //                        child: Image.asset(
                  //                          "assets/images/round-underpic-shade.png",
                  //                          fit: BoxFit.fill,
                  //                        ),
                  //                      ),
                  //                    ),
                  //                  ),
                  Positioned(
                    right: SizeConfig.blockSizeHorizontal * 4,
                    top: SizeConfig.blockSizeVertical * 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MiPerfil(),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 2, //
                            ),
                            borderRadius: new BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/avatar.png",
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: SizeConfig.blockSizeHorizontal * 12,
                    top: SizeConfig.blockSizeVertical * 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MiPerfil(),
                          ),
                        );
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/logocolegio-fds.png",
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Color.fromARGB(200, 57, 57, 57),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Ajustes",
                          style: TextStyle(
                            fontFamily:"Gibson",
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 57, 57, 57)
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                title: "Comparte la app",
                                description:
                                "www.link.poronga",
                                primaryButtonText: "Copiar",
                                primaryButtonRoute: "/home",
                              ),
                            );
                          },
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
                        Container(
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                title: "¿Estas seguro?",
                                description:
                                "Deberas volver a iniciar sesión",
                                primaryButtonText: "Si",
                                primaryButtonRoute: "/logOut",
                                secondaryButtonText: "Cancelar",
                                secondaryButtonRoute: "/home",
                              ),
                            );
                          },
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
}
