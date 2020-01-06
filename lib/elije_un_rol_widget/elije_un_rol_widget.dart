import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';

class ElijeUnRolWidget extends StatelessWidget {

  void onViewValueChanged(BuildContext context) {

  }

  void onButtonPressed(BuildContext context) {

  }

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
                  "Tu cuenta",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 57, 57, 57),
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
            Container(
              height: 285,
              margin: EdgeInsets.only(top: 50),
              child: AspectRatio(
                aspectRatio: 409 / 245,
                child: Image.asset(
                  "assets/images/cartel_blank.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 111, top: 74, right: 110),
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
            Container(
              margin: EdgeInsets.only(left: 0, top: 9, right: 0),
              child: Text(
                "Esto determinara cuantos cursos \nestarán disponibles dentro de la app.",
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
            Spacer(),
          ],
        ),
      ),
    );
  }
}
