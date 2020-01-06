import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/verificacion_widget/verificacion_widget.dart';

class SignUpWidget extends StatelessWidget {
  void onViewPressed(BuildContext context) {}

  void onViewTwoPressed(BuildContext context) {}

  void onBtnBluePressed(BuildContext context) {}

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
              Container(
                height: 35,
                margin: EdgeInsets.only(left: 51, top: 83, right: 62),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        margin: EdgeInsets.only(top: 13),
                        child: Image.asset(
                          "assets/images/icons8-email-send-96px.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 35,
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
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 3,
                margin: EdgeInsets.only(left: 54, top: 6, right: 55),
                child: Image.asset(
                  "assets/images/path-1541.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 37,
                margin: EdgeInsets.only(left: 51, top: 22, right: 62),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(top: 11),
                        child: Opacity(
                          opacity: 0.7,
                          child: Image.asset(
                            "assets/images/icons8-lock-96px.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 37,
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
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 3,
                margin: EdgeInsets.only(left: 54, top: 6, right: 54),
                decoration: BoxDecoration(
                  color: Color.fromARGB(77, 0, 0, 0),
                ),
                child: Container(),
              ),
              Container(
                height: 37,
                margin: EdgeInsets.only(left: 51, top: 22, right: 62),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(top: 11),
                        child: Opacity(
                          opacity: 0.7,
                          child: Image.asset(
                            "assets/images/icons8-lock-96px-2.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 37,
                          margin: EdgeInsets.only(left: 2),
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
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 3,
                margin: EdgeInsets.only(left: 54, top: 6, right: 54),
                decoration: BoxDecoration(
                  color: Color.fromARGB(77, 0, 0, 0),
                ),
                child: Container(),
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
              Container(
                height: 110,
                margin: EdgeInsets.only(left: 47, right: 47, bottom: 37),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () => this.onViewPressed(context),
                        color: AppColors.accentElement,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(112, 112, 112, 112),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(22.5)),
                        ),
                        textColor: Color.fromARGB(255, 117, 117, 117),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/icons8-google-96px.png",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Continuar con Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: FlatButton(
                        onPressed: () => this.onViewTwoPressed(context),
                        color: Color.fromARGB(255, 59, 89, 152),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.5)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/icons8-facebook-96px-1.png",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Continuar con Facebook",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 124,
                  height: 44,
                  margin: EdgeInsets.only(bottom: 40),
                  child: Opacity(
                    opacity: 0.91,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerificacionWidget()),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
