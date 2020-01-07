
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class SubiFotoPerfilWidget extends StatelessWidget {

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
            Container(
              height: 331,
              margin: EdgeInsets.only(top: 23),
              child: Image.asset(
                "assets/images/phonochico.png",
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 92, right: 91, bottom: 12),
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
            Container(
              margin: EdgeInsets.only(left: 108, right: 107, bottom: 164),
              child: Text(
                "Es importante subir una foto \nen la que salgas bien.\n",
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
          ],
        ),
      ),
    );
  }
}