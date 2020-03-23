import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/dialogs/dialog_widget/error_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';

class RecuperationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecuperationWidgetState();
  }

}

class RecuperationWidgetState extends State<RecuperationWidget>{

  String titleMessage = "Ingresa tu mail";
  String bodyMessage = "Se enviara un mail para \npoder cambiar tu contraseña";
  String buttonMessage = "Enviar mail";
  int numberOfMails = 0;
  TextEditingController emailTextController = TextEditingController();


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
                    "Recuperación",
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
                              controller: emailTextController,
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
                height: 2,
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
                    titleMessage,
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
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
                child: Text(
                  bodyMessage,
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
                            onPressed: () => Navigator.pop(context),
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
                          child: numberOfMails>8? Container():FlatButton(
                              color: AppColors.secondaryElement,
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
                                  color: AppColors.secondaryText,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                sendResetPasswordEmail(context, emailTextController.text);
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          titleMessage = "Mail de Recuperacion Enviado";
          bodyMessage = "Se ha enviado a su email $email un mail de recuperacion para poder acceder nuevamente a su cuenta";
          numberOfMails ++;
          buttonMessage = "Volver a enviar mail";
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