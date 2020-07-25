import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/dialogs/dialog_widget/error_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/size_config.dart';
import 'package:provider/provider.dart';

class RecuperationWidget extends StatefulWidget {

  bool isSelected = false;
  @override
  State<StatefulWidget> createState() {
    return RecuperationWidgetState();
  }

}

class RecuperationWidgetState extends State<RecuperationWidget>{

  bool isSelected = false;

  String titleMessage = "Recupera tu \ncuenta";
  String bodyMessage = "Danos más datos de tu cuenta";
  String buttonMessage = "Enviar mail";
  int numberOfMails = 0;
  TextEditingController emailTextController = TextEditingController();

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/recuperacion");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
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
                            "¿Olvidaste tu contraseña?",
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
                  Text(
                    "Escribe tu correo electrónico",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 5),
                  BeautyTextfield(
                    controller: emailTextController,
                    textCapitalization: TextCapitalization.words,
                    width: double.maxFinite, //REQUIRED
                    height: 50, //REQUIRED
                    accentColor: Colors.white, // On Focus Color//Text Color
                    backgroundColor: Theme.of(context).hintColor,
                    autofocus: false,
                    maxLines: 1,
                    margin: EdgeInsets.only(top: 10),
                    cornerRadius: BorderRadius.all(Radius.circular(15)),
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,//REQUIRED
                    obscureText: false, //REQUIRED
                    suffixIcon: Icon(Icons.remove_red_eye),
                    onClickSuffix: () {
                      print('Suffix Clicked');
                    },
                    onTap: () {
                      print('Click');
                    },
                    onChanged: (text) {
                      print(text);
                    },
                    onSubmitted: (data) {
                      print(data.length);
                    },
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    child: numberOfMails>8? Container():FlatButton(
                        color: widget.isSelected? Theme.of(context).hintColor.withAlpha(100): AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          buttonMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.isSelected? Theme.of(context).iconTheme.color: Theme.of(context).scaffoldBackgroundColor,
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),//texto de botones
                        ),
                        onPressed: () {
                          sendResetPasswordEmail(context, emailTextController.text);
                        }),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*15),
                  Container(
                    width: SizeConfig.blockSizeHorizontal*30,
                    height: 50,
                    child:  widget.isSelected? FlatButton(
                        color: AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios, color: Theme.of(context).scaffoldBackgroundColor),
                            SizedBox(width: 12),
                            Text(
                              "Atras",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                fontFamily: "Sf",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),//texto de botones
                            ),
                          ],
                        ),
                        onPressed:() => Navigator.pop(context))
                : Container(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }


  sendResetPasswordEmail(BuildContext context,String email) {
    if(numberOfMails >7){
      setState(() {
        titleMessage = "";
        bodyMessage = "Haz excedido el numero de mails que puedes enviar";
        buttonMessage = "";
      });
      return null;
    }
    final auth = Provider.of<BaseAuth>(context,listen: false);
    if(email != null && email.length != 0){
      auth.sendResetEmail(email).then((smt) {
        setState(() {
          titleMessage = "Mail de recuperacion enviado";
          bodyMessage = "Se ha enviado a su email $email un mail de recuperacion para poder acceder nuevamente a su cuenta";
          numberOfMails ++;
          buttonMessage = "Volver a enviar mail";
          widget.isSelected = true;
        });
      });

    }else{
      showErrorDialog(context, "Debes ingresar un email para poder enviar un mail de recuperacion.");
    }

  }
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}