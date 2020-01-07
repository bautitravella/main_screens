import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';

class SubiFotoPerfilWidget extends StatelessWidget {
  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

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
                      left: 103,
                      top: 50,
                      right: 103,
                      bottom: 50,
                      child: Image.asset(
                        "assets/images/uploadimage.png",
                        fit: BoxFit.none,
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 105,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 33, bottom: 33),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                          onPressed: () => this.onBtnBlueTwoPressed(context),
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
                                "assets/images/logo.png",
                                fit: BoxFit.none,
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
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
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
          ],
        ),
      ),
    );
  }
}
