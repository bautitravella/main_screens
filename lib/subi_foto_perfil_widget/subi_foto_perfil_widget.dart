
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class SubiFotoPerfilWidget extends StatelessWidget {
  
  void onEllipsePressed(BuildContext context) {
  
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
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 61, bottom: 22),
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
                      right: 292,
                      bottom: 56,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Perfil",
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
                              width: 155,
                              height: 155,
                              margin: EdgeInsets.only(top: 131),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(74, 254, 189, 16),
                                borderRadius: BorderRadius.all(Radius.circular(77.30447)),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 20,
                                    child: FlatButton(
                                      onPressed: () => this.onEllipsePressed(context),
                                      color: AppColors.secondaryBackground,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(56.36784)),
                                      ),
                                      textColor: Color.fromARGB(255, 0, 0, 0),
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        "",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Image.asset(
                                      "assets/images/icons8-upload-to-cloud-96px-1.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 73),
                              child: Text(
                                "Subí una foto",
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
                          Container(
                            margin: EdgeInsets.only(left: 80, top: 12, right: 16),
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
                          Spacer(),
                          Container(
                            height: 7,
                            margin: EdgeInsets.only(left: 128, right: 65),
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