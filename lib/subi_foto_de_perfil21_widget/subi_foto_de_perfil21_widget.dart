
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';

import '../datos_widget/datos_widget.dart';
import '../datos_widget/datos_widget.dart';


class SubiFotoDePerfil21Widget extends StatelessWidget {
  void onLogoPressed(BuildContext context) {}
  void onProfilePicture(BuildContext context) {}
  void onButtonPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 85),
                child: Text(
                  "Perfil",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 57, 57, 57),
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 39, bottom: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 92,
                      right: 91,
                      bottom: 0,
                      child: Text(
                        "Subí una foto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 38, 65),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                          letterSpacing: -0.41786,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/phonochico.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 50,
                      right: 80,
                      bottom: 50,
                      child: Image.asset(
                        "assets/images/uploadimage.png",
                        fit: BoxFit.none,
                      ),
                    ),
                    Container(
                      width: 155,
                      height: 155,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 33, bottom: 33),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                          onPressed: () => this.onProfilePicture(context),
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                            ),
                            textColor: Color.fromARGB(0, 0, 0, 0),
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/avatar.png",
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                    Container(
                      width: 58,
                      height: 58,
                      margin: EdgeInsets.only(
                          left: 90, top: 110, bottom: 33),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                            color: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 254, 189, 16),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                            ),
                            textColor: Color.fromARGB(0, 0, 0, 0),
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/icons8-edit-96px-11.png",
                                  fit: BoxFit.none,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SubiFotoDePerfil21Widget()),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 50),
              child: Text(
                "Es importante subir una foto \nen la que salgas bien.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 118, 118),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: -0.1,
                  height: 1.4,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 124,
                height: 44,
                margin: EdgeInsets.only(right: 3, bottom: 30),
                child: FlatButton(
                    color: AppColors.secondaryElement,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons-back-light-2.png",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Siguiente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DatosWidget()),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
