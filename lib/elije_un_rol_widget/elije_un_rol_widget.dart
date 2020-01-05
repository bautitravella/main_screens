
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class ElijeUnRolWidget extends StatelessWidget {
  
  void onPadrePressed(BuildContext context) {
  
  }
  
  void onAlumnoPressed(BuildContext context) {
  
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
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.secondaryElement,
              ),
              child: Container(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 61),
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
            Container(
              height: 244,
              margin: EdgeInsets.only(top: 25),
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
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 112,
                    top: 45,
                    right: 130,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 3,
                            height: 63,
                            child: Image.asset(
                              "assets/images/path-1545.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        Spacer(),
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
                    left: 44,
                    top: 96,
                    right: 62,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 138,
                            height: 138,
                            child: Image.asset(
                              "assets/images/8e5cfd48fd69252a2f2c90178d05768e.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 138,
                            height: 138,
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              "assets/images/8e5cfd48fd69252a2f2c90178d05768e.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 72,
                    top: 165,
                    right: 101,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 85,
                            height: 25,
                            child: FlatButton(
                              onPressed: () => this.onAlumnoPressed(context),
                              color: Color.fromARGB(0, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
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
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 63,
                            height: 25,
                            margin: EdgeInsets.only(top: 10),
                            child: FlatButton(
                              onPressed: () => this.onPadrePressed(context),
                              color: Color.fromARGB(0, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 90),
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
            Spacer(),
            Container(
              height: 7,
              margin: EdgeInsets.only(left: 156, right: 156, bottom: 78),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 7,
                      height: 7,
                      child: Image.asset(
                        "assets/images/ellipse-371.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 7,
                      height: 7,
                      margin: EdgeInsets.only(left: 7),
                      child: Image.asset(
                        "assets/images/ellipse-373.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 7,
                      height: 7,
                      margin: EdgeInsets.only(right: 7),
                      child: Image.asset(
                        "assets/images/ellipse-373.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 7,
                      height: 7,
                      child: Image.asset(
                        "assets/images/ellipse-373.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}