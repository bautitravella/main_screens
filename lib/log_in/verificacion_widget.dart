import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/registrar_info_usuario/elije_un_rol_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';

import '../auth.dart';

class VerificacionWidget extends StatelessWidget {
  void onGoBack(BuildContext context) {
    Navigator.push(context,MaterialPageRoute(builder: (context) => FirstscreenWidget()));
  }

  void onBtnBluePressed(BuildContext context) {}

  void sendVerificationEmail(BuildContext context) async {
    final auth = Provider.of<BaseAuth>(context,listen: false);
    try{
      auth.currentUser().then((user) => user.sendEmailVerification());
    }catch (e){
      print(e.message);
    }
  }

  void checkIfVerified(BuildContext context){
    final auth = Provider.of<BaseAuth>(context,listen: false);
    try{
      auth.currentUser().then((user) => user.isEmailVerified ? () =>{Navigator.push(context, MaterialPageRoute(builder: (context) => ElijeUnRolWidget(user.email))), print('VERIFICACION TRUE')} : print('VERIFICACION FALSE'));
      //auth.currentUser().then((user) => print('VERIFICACION == ${user.isEmailVerified},userUID = ${user.uid}'));
    }catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context)  {
    try{
      checkIfVerified(context);
      sendVerificationEmail(context);
    }catch(e){
      print(e);
    }
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
              margin: EdgeInsets.only(left: 28, top: 85),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  IconButton(
                    icon: Icon(Icons.refresh, size: 40, color: AppColors.secondaryBackground,),
                    onPressed: () => checkIfVerified(context),
                  ),
                  /*Expanded(
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
                  RaisedButton(
                    onPressed: () => checkIfVerified(context),
                    child: Icon(Icons.refresh),
                  ),*/
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
              margin: EdgeInsets.only(left: 3, right: 3, bottom: 17),
              child: Text(
                "Revisa tu correo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
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
                  fontFamily: "Sf-t",
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
                          onPressed: () => this.onGoBack(context),
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
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w700,
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
                                fontFamily: "Sf-r",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              sendVerificationEmail(context);
                              checkIfVerified(context);
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
