
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class SignUpWidget extends StatelessWidget {
  
  void onBtnBluePressed(BuildContext context) {
  
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: -1,
              bottom: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 24,
                    margin: EdgeInsets.only(right: 1),
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
                        "Sign Up",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontWeight: FontWeight.w400,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 96,
                      height: 26,
                      margin: EdgeInsets.only(left: 51, top: 92),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 22,
                              height: 22,
                              margin: EdgeInsets.only(top: 4),
                              child: Image.asset(
                                "assets/images/icons8-email-send-96px.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 68,
                              height: 25,
                              margin: EdgeInsets.only(left: 6),
                              child: Opacity(
                                opacity: 0.63,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Correo",
                                    contentPadding: EdgeInsets.all(0),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: AppColors.accentText,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  autocorrect: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 251,
                      height: 3,
                      margin: EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(64, 255, 230, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/path-1541.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 144,
                      height: 26,
                      margin: EdgeInsets.only(left: 51, top: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 26,
                              height: 26,
                              child: Opacity(
                                opacity: 0.7,
                                child: Image.asset(
                                  "assets/images/icons8-lock-96px.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 116,
                              height: 25,
                              margin: EdgeInsets.only(left: 2),
                              child: Opacity(
                                opacity: 0.63,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    contentPadding: EdgeInsets.all(0),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: AppColors.accentText,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  autocorrect: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 252,
                      height: 3,
                      margin: EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(64, 255, 230, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 252,
                      height: 3,
                      margin: EdgeInsets.only(top: 65),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(64, 255, 230, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Text(
                        "Conectate con",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: 27,
                          letterSpacing: -0.43393,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 266,
                      height: 110,
                      margin: EdgeInsets.only(bottom: 23),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 45,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.accentElement,
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromARGB(255, 112, 112, 112),
                                      ),
                                      boxShadow: [
                                        Shadows.secondaryShadow,
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(22.5)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Positioned(
                                  left: 14,
                                  top: 10,
                                  right: 44,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                            "assets/images/icons8-google-96px.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            "Continue in with Google",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 117, 117, 117),
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
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
                          Spacer(),
                          Container(
                            height: 45,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 89, 152),
                                      boxShadow: [
                                        Shadows.secondaryShadow,
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(22.5)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Positioned(
                                  left: 14,
                                  right: 27,
                                  bottom: 11,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                            "assets/images/icons8-facebook-96px-1.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 1),
                                          child: Text(
                                            "Continue in with Facebook",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.secondaryText,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 86,
                      height: 38,
                      child: Opacity(
                        opacity: 0.91,
                        child: FlatButton(
                          onPressed: () => this.onBtnBluePressed(context),
                          color: AppColors.secondaryElement,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/icons-back-light-2.png",),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Siguiente",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 51,
              right: 65,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 26,
                      height: 26,
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          "assets/images/icons8-lock-96px-2.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 216,
                      height: 25,
                      child: Opacity(
                        opacity: 0.63,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Confirmar contraseña",
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 57, 57),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                          autocorrect: false,
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
    );
  }
}