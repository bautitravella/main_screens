
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class TerminosYCondicionesWidget extends StatelessWidget {
  
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
                margin: EdgeInsets.only(left: 25, top: 61),
                child: Text(
                  "Terminos y\nCondiciones",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                    height: 1.26316,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 30, top: 19, right: 25, bottom: 19),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Articulo 1",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 69, 79, 99),
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Text(
                                "Para quien use los servicios",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 242,
                                margin: EdgeInsets.only(top: 100, right: 6),
                                child: Text(
                                  "• Step 1: You may use the Services only if you agree to form a binding contract with us and are not a person barred from receiving services under the laws of the applicable jurisdiction. \n\n• Step 2: Our Privacy Policy describes how we handle the information you provide to us when you use our Services.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 69, 79, 99),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    height: 1.38462,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(left: 5, bottom: 10),
                              child: Text(
                                "Privacidad",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 299,
                                margin: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 120, 132, 158),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 72,
                      right: 5,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 299,
                              child: Text(
                                "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the \none that has been opened for us. ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 120, 132, 158),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  height: 1.38462,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 53,
                            margin: EdgeInsets.only(left: 1),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryElement,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(41, 0, 0, 0),
                                  offset: Offset(0, 5),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 66, top: 15),
                                  child: Text(
                                    "CONTINUAR Y ACEPTAR",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}