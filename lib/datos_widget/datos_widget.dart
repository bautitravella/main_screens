
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class DatosWidget extends StatelessWidget {
  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  "Falta poco",
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
                        "Ingresa tus\ndatos",
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 0, right: 20, top: 81),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "USERNAME",
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                            maxLines: 1,
                            autocorrect: false,
                          ),
                        ),
                      ),
                    ),
                Align(
                  alignment: Alignment.topCenter,
                  child:Container(
                    height: 2,
                    margin: EdgeInsets.only(left: 115, right: 115, top: 120),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                    child: Container(),
                  ),
                ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 0, right: 20, top: 161),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "NOMBRE",
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                            maxLines: 1,
                            autocorrect: false,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                    child:Container(
                      height: 2,
                      margin: EdgeInsets.only(left: 115, right: 115, top: 200),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                      ),
                      child: Container(),
                    ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 0, right: 20, top: 241),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "APELLIDO",
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                            maxLines: 1,
                            autocorrect: false,
                          ),
                        ),
                      ),
                    ),
                Align(
                  alignment: Alignment.topCenter,
                  child:Container(
                    height: 2,
                    margin: EdgeInsets.only(left: 115, right: 115, top: 280),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                    child: Container(),
                  ),
                ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
              child: Text(
                "Los datos ingresados se podrán\ncambiar mas tarde \ndentro de la app\n",
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

          ],
        ),
      ),
    );
  }
}
