
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class DatosWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: -201,
              top: 0,
              right: -201,
              bottom: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 24,
                    margin: EdgeInsets.symmetric(horizontal: 201),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryElement,
                    ),
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 61),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            top: 5,
                            right: 0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        child: Image.asset(
                                          "assets/images/bg-light-gray.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 97,
                                        child: Container(
                                          width: 283,
                                          height: 326,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryBackground,
                                            border: Border.fromBorderSide(Borders.primaryBorder),
                                            borderRadius: BorderRadius.all(Radius.circular(141.5)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 82,
                                        right: 0,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Container(
                                                  width: 240,
                                                  height: 438,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryBackground,
                                                    boxShadow: [
                                                      Shadows.primaryShadow,
                                                    ],
                                                    borderRadius: Radii.k80pxRadius,
                                                  ),
                                                  child: Container(),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Container(
                                                  width: 240,
                                                  height: 414,
                                                  margin: EdgeInsets.only(top: 14),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryBackground,
                                                    boxShadow: [
                                                      Shadows.primaryShadow,
                                                    ],
                                                    borderRadius: Radii.k80pxRadius,
                                                  ),
                                                  child: Container(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 98,
                                        child: Container(
                                          width: 267,
                                          height: 422,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryBackground,
                                            boxShadow: [
                                              Shadows.primaryShadow,
                                            ],
                                            borderRadius: Radii.k80pxRadius,
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 65,
                                  child: Container(
                                    width: 283,
                                    height: 321,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      border: Border.fromBorderSide(Borders.secondaryBorder),
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Positioned(
                                  top: 319,
                                  child: Container(
                                    width: 269,
                                    height: 174,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 229,
                            top: 0,
                            right: 296,
                            bottom: 56,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Falta poco",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.accentText,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 38,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 170,
                                    height: 39,
                                    margin: EdgeInsets.only(top: 27),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 249, 210, 106),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 102,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 79, top: 56),
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
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                        autocorrect: false,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 154,
                                    height: 3,
                                    margin: EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 81,
                                    height: 21,
                                    margin: EdgeInsets.only(left: 79, top: 27),
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
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                        autocorrect: false,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 121,
                                    height: 3,
                                    margin: EdgeInsets.only(left: 75, top: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 154,
                                    height: 3,
                                    margin: EdgeInsets.only(top: 53),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 59),
                                    child: Text(
                                      "Ingresa tus\ndatos",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 26,
                                        letterSpacing: -0.41786,
                                        height: 1.26923,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 75, top: 19, right: 7),
                                  child: Text(
                                    "Los datos ingresados se podrán\ncambiar mas tarde \ndentro de la app\n",
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
                                Spacer(),
                                Container(
                                  height: 7,
                                  margin: EdgeInsets.only(left: 128, right: 61),
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
                                            "assets/images/ellipse-371.png",
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 107,
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
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}