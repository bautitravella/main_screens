import 'package:flutter/material.dart';


import 'package:flutterui/home_hub/pages/mybooks_view/vender/segunda_subir_foto.dart';
import 'package:flutterui/size_config.dart';

import 'package:flutterui/values/values.dart';

class PrimeraSubirFoto extends StatelessWidget {
  void onBtnBlueTwoPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void onBtnBluePressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: AppColors.accentText,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 46,
                  margin: EdgeInsets.only(
                      left: 28,
                      top: 24,
                      bottom: SizeConfig.blockSizeVertical * 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Vender",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Gibson",
                            color: AppColors.accentText,
                            fontWeight: FontWeight.w600,
                            fontSize: 38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 161,
                          height: 215,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 143, 143, 143),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                            BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                            ]
                          ),
                        ),
                        Container(
                          width: 161,
                          height: 215,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 143, 143, 143),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                            BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                          ]
                          ),

                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 161,
                        height: 244,
                        padding: EdgeInsets.only(top: 210),
                        margin: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ]),
                        child: Text(
                          "PORTADA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(170, 118, 118, 118),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: -0.1,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.blockSizeHorizontal*38.5,
                      top: SizeConfig.blockSizeVertical*10,
                      child: Container(
                        width: 90,
                        height: 90,
                        child:FlatButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                            ),
                                child: Icon(
                                  Icons.cloud_upload,
                                  color: AppColors.secondaryBackground,
                                  size: 60,
                                ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SegundaSubirFoto()),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      "Subí 3 fotos",
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
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Es importante subir fotos de tus libros \npara que otros usuarios tengan \nuna mejor experiencia al comprar.",
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
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 124,
                height: 44,
                margin: EdgeInsets.only(right: 3, bottom: 30),
                child: Opacity(
                  opacity: 0.5,
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
                      onPressed: () {}
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
