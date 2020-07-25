import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/registrar_info_usuario/elije_un_rol_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../auth.dart';
import '../size_config.dart';

class VerificacionWidget extends StatelessWidget {

  String titleMessage = "Revisa tu correo";
  String bodyMessage = "Se ha enviado un link a tu correo electrónico.";
  String buttonMessage = "Enviar mail";

  void onGoBack(BuildContext context) {
    Navigator.pop(context);
  }


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
      auth.isVerified().then((bool) async {
        if(bool){
        FirebaseUser user = await auth.currentUser();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ElijeUnRolWidget(user.email)));
        print('VERIFICACION TRUE');
      }else{
          print('VERIFICACION FALSE');
        }
      });


      //auth.currentUser().then((user) => print('VERIFICACION == ${user.isEmailVerified},userUID = ${user.uid}'));
    }catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context)  {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/verificacion");
    try{
      checkIfVerified(context);
      sendVerificationEmail(context);
    }catch(e){
      print(e);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
                        SizedBox(width: 10),
                        Text(
                          "Verificación",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      titleMessage,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      bodyMessage,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Center(
                  child: Image.asset(
                    "assets/images/verificacion_ mail.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: IconButton(
                        icon: Icon(FontAwesome.refresh, size: 28, color: Theme.of(context).iconTheme.color.withAlpha(180)),
                        onPressed: () => checkIfVerified(context),
                      ),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal*4),
                    Container(
                      width: SizeConfig.blockSizeHorizontal*67,
                      child: Text(
                        "Actualiza para verificar que hayas activado tu cuenta correspondiente.",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                ],),
                SizedBox(height: 60),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                      onPressed: () {
                        sendVerificationEmail(context);
                        checkIfVerified(context);},
                    /*color: Color.fromARGB(255, 222, 222, 222),*/
                    color: AppColors.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Volver a enviar mail",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
