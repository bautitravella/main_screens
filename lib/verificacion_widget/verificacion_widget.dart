import 'package:flutter/material.dart';
import 'package:flutterui/elije_un_rol_widget/elije_un_rol_widget.dart';
import 'package:flutterui/values/values.dart';

class VerificacionWidget extends StatelessWidget {
  void onBtnBlueTwoPressed(BuildContext context) {
    Navigator.pop(context);
  }

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
            Container(
              height: 46,
              margin: EdgeInsets.only(left: 28, top: 85, right: 102),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Verificación",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.accentText,
                        fontWeight: FontWeight.w400,
                        fontSize: 38,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 29,
                        margin: EdgeInsets.only(left: 11, top: 12),
                        child: Image.asset(
                          "assets/images/icons8-synchronize-100px.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 59, top: 78, right: 58),
                child: Image.asset(
                  "assets/images/gmail-amarillopng.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 73, right: 73, bottom: 17),
              child: Text(
                "Revisa tu correo",
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
              margin: EdgeInsets.only(left: 73, right: 77, bottom: 82),
              child: Text(
                "Se a enviado un mail a tu correo \ny abre el link para que podamos\ncomprobar la dirección ingresada.",
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
            Container(
              height: 54,
              margin: EdgeInsets.only(left: 4, right: 6, bottom: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 124,
                      height: 44,
                      child: Opacity(
                        opacity: 0.91,
                        child: FlatButton(
                          onPressed: () => this.onBtnBlueTwoPressed(context),
                          color: AppColors.secondaryElement,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icons-back-light.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Atras",
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
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 155,
                      height: 44,
                      child: Opacity(
                        opacity: 0.91,
                        child: FlatButton(
                            color: AppColors.secondaryElement,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            textColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Volver a enviar mail",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ElijeUnRolWidget()), // Temporalmente me manda a la siguiente pantalla, deberia esperar a confirmar el mail
                              );
                            }),
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
