
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class ElijeUnRolWidget extends StatelessWidget {

  void onAlumnoPressed(BuildContext context) {

  }

  void onPadrePressed(BuildContext context) {

  }

  void onViewValueChanged(BuildContext context) {

  }

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
                  "Tu cuenta",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 25, bottom: 85),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 49,
                      top: 0,
                      child: Image.asset(
                        "assets/images/icons8-bird-100px-1.png",
                        fit: BoxFit.none,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 18,
                      right: 0,
                      child: Image.asset(
                        "assets/images/path-1544.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 44,
                      top: 45,
                      right: 130,
                      bottom: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 95),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 68,
                                    top: 0,
                                    child: Image.asset(
                                      "assets/images/path-1545.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 51,
                                    right: 0,
                                    child: Image.asset(
                                      "assets/images/8e5cfd48fd69252a2f2c90178d05768e.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    left: 24,
                                    top: 111,
                                    child: FlatButton(
                                      onPressed: () => this.onAlumnoPressed(context),
                                      color: Color.fromARGB(0, 0, 0, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(0)),
                                      ),
                                      textColor: Color.fromARGB(255, 255, 255, 255),
                                      padding: EdgeInsets.all(0),
                                      highlightColor: Colors.transparent,
                                      child: Text(
                                        "Alumno",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 3,
                              height: 72,
                              margin: EdgeInsets.only(top: 3),
                              child: Image.asset(
                                "assets/images/path-1546.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 106,
                      right: 62,
                      child: Image.asset(
                        "assets/images/8e5cfd48fd69252a2f2c90178d05768e.png",
                        fit: BoxFit.none,
                      ),
                    ),
                    Positioned(
                      top: 166,
                      right: 85,
                      child: FlatButton(
                        onPressed: () => this.onPadrePressed(context),
                        color: Color.fromARGB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        highlightColor: Colors.transparent,
                        child: Text(
                          "Padre",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 111, top: 85, right: 110),
              child: Text(
                "Elije un rol",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  letterSpacing: -0.41786,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 12),
                child: Text(
                  "Esto determinara cuantos cursos \nestarán disponibles dentro de la app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 118, 118),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    letterSpacing: -0.1,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            Container(
              height: 37,
              margin: EdgeInsets.only(left: 137, right: 137, bottom: 72),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}