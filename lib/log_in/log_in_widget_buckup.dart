import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/recuperation_widget.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LogInWidgetBuckup extends StatefulWidget {
  @override
  _LogInWidgetBuckupState createState() => _LogInWidgetBuckupState();
}

class _LogInWidgetBuckupState extends State<LogInWidgetBuckup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _email;
  String _password;
  String _errorText = '';


  void logInWithGoogleBtn(BuildContext context) async {
    try{
      final auth = Provider.of<BaseAuth>(context,listen: false);
      String userUID = await auth.signInWithGoogle();

      print("Te logueaste con $userUID");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyDecider()),
      );
    }catch(e){
      setState(() {
        _errorText = "$e";
      });
    }


  }

  void logInWithFacebookBtn(BuildContext context) {}

  bool validateEmailAndPassword() {
    _email = emailController.text;
    _password = passwordController.text;

    if (_email.isEmpty) {
      setState(() {
        _errorText =
            'Por favor completar el campo de email antes de continuar. ';
      });
      return false;
    }
    if (_password.isEmpty) {
      setState(() {
        _errorText +=
            'Por favor completar el campo de password antes de continuar. ';
      });
      return false;
    }
    return true;
  }

  void _siguienteBtn(BuildContext context) async {
    _email = emailController.text;
    _password = passwordController.text;

    if (validateEmailAndPassword() == true) {
      try {
        final auth = Provider.of<BaseAuth>(context,listen: false);
        String userUID =
            await auth.signInWithEmailAndPassword(_email, _password);

        setState(() {
          _errorText = 'signed in with : ${userUID})';
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDecider()),
        );
      } catch (error) {
        setState(() {
          _errorText = '$error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                    "Log In",
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
                              controller: emailController,
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
              ), //Icono Email y EmailTextField
              Container(
                height: 2,
                margin: EdgeInsets.only(left: 54, top: 6, right: 54),
                decoration: BoxDecoration(
                  color: Color.fromARGB(77, 0, 0, 0),
                ),
                child: Container(),
              ), //Linea Abajo de EmailTextField
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
                              controller: passwordController,
                              obscureText: true,
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
                height: 2,
                margin: EdgeInsets.only(left: 54, top: 6, right: 54),
                decoration: BoxDecoration(
                  color: Color.fromARGB(77, 0, 0, 0),
                ),
                child: Container(),
              ),
              Container(
                height: 47,
                margin: EdgeInsets.only(left: 101, top: 36, right: 100),
                child: Opacity(
                  opacity: 0.56,
                  child: FlatButton(
                      color: Color.fromARGB(0, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      textColor: Color.fromARGB(255, 0, 0, 0),
                      padding: EdgeInsets.all(0),
                      child: Text(
                        "¿Has olvidado la contraseña?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecuperationWidget()),
                        );
                      }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 51, top: 22, right: 62),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Opacity(
                      opacity: 0.93,
                      child: Text(
                        '$_errorText',
                        style: TextStyle(
                          color: Colors.red[500],
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ), //Texto de error
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
              ), //Texto de "conectate con"
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
                        onPressed: () => this.logInWithGoogleBtn(context),
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
                        onPressed: () => this.logInWithFacebookBtn(context),
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
              ), //Botones de google y facebook
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
                        onPressed: () => this._siguienteBtn(context)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
    print("Hola , ");
    print(_googleSignIn.currentUser.email);
  } catch (error) {
    print(error);
  }
}
