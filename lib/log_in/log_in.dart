import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterui/log_in/recuperation_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth.dart';
import '../main.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _email;
  String _password;
  String _errorText = '';
  FirebaseAnalytics analytics;

   @override
  void initState() {
    analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/log_in");
    super.initState();
  }

  void logInWithGoogleBtn(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);
      String userUID = await auth.signInWithGoogle();

      print("Te logueaste con $userUID");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyDecider()),
      );
    } on PlatformException catch (e) {
      setState(() {
        _errorText = "${e.message}";
      });
      showErrorDialog(context, _errorText);
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });

      showErrorDialog(context, _errorText);
    }
  }

  void logInWithFacebookBtn(BuildContext context) async {
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Surgio un error con el fucking facebook");
        setState(() {
          _errorText = "${result.errorMessage}";
        });
        showErrorDialog(context, _errorText);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          final auth = Provider.of<BaseAuth>(context, listen: false);
          String userUID = await auth.signInWithFacebook(result.accessToken);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyDecider()),
          );
        } on PlatformException catch (e) {
          setState(() {
            _errorText = "${e.message}";
          });
          showErrorDialog(context, _errorText);
          facebookLogin.logOut();
        } catch (e) {
          setState(() {
            _errorText = e.toString();
          });

          showErrorDialog(context, _errorText);
          facebookLogin.logOut();
        }

        break;
    }
  }

  bool validateEmailAndPassword() {
    _email = emailController.text.trim();
    _password = passwordController.text.trim();

    if (_email.isEmpty) {
      setState(() {
        _errorText =
            'Por favor completar el campo de email antes de continuar. ';
      });
      Navigator.pop(context);
      showErrorDialog(context, _errorText);
      return false;
    }
    if (_password.isEmpty) {
      setState(() {
        _errorText +=
            'Por favor completar el campo de password antes de continuar. ';
      });
      Navigator.pop(context);
      showErrorDialog(context, _errorText);
      return false;
    }
    return true;
  }

  void _siguienteBtn(BuildContext context) async {
    showLoadingDialog(context);
    _email = emailController.text;
    _password = passwordController.text;

    if (validateEmailAndPassword() == true) {
      try {
        final auth = Provider.of<BaseAuth>(context, listen: false);
        String userUID =
            await auth.signInWithEmailAndPassword(_email, _password);

//        setState(() {
//          _errorText = 'signed in with : $userUID})';
//        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDecider()),
        );
      }on PlatformException catch(e){
        setState(() {
          _errorText = '${e.message}';
        });
        //Navigator.pop(context);
        showErrorDialog(context, _errorText);
      } catch (error) {
        setState(() {
          _errorText = '$error';
        });
        //Navigator.pop(context);
        showErrorDialog(context, _errorText);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
//    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context);
//    analytics.setCurrentScreen(screenName: "/log_in/log_in");
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: 28, top: SizeConfig.blockSizeVertical * 10),
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
                Container(
                  margin: EdgeInsets.only(
                      left: 38,
                      right: 38,
                      top: SizeConfig.blockSizeVertical * 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: 22,
                                height: 22,
                                child: Icon(Icons.alternate_email)),
                            Expanded(
                              child: Container(
                                height: 35,
                                width: 200,
                                margin: EdgeInsets.only(left: 10),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: "Correo",
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
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
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        margin: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(77, 0, 0, 0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Container(
                                width: 22,
                                height: 22,
                                child: Icon(Icons.lock_outline)),
                            Expanded(
                              child: Container(
                                height: 35,
                                width: 200,
                                margin: EdgeInsets.only(left: 10),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: "Contraseña",
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: AppColors.accentText,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        margin: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(77, 0, 0, 0),
                        ),
                      ),
                      GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 3),
                            child: Text(
                              "¿Has olvidado la contraseña?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(100, 0, 0, 0),
                                fontFamily: "Sf",
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecuperationWidget()),
                            );
                          }),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1),
                        child: Opacity(
                          opacity: 0.93,
                          child: Text(
                            '$_errorText',
                            style: TextStyle(
                              color: Colors.red[500],
                              fontFamily: "Sf",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    margin: EdgeInsets.only(left: 38, right: 38),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Conectate con",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              letterSpacing: -0.43393,
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(bottom: 15),
                          child: FlatButton(
                            onPressed: () => this.logInWithGoogleBtn(context),
                            color: AppColors.accentElement,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromARGB(112, 112, 112, 112),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.5)),
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
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical * 13),
                          child: FlatButton(
                            onPressed: () => this.logInWithFacebookBtn(context),
                            color: Color.fromARGB(255, 59, 89, 152),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.5)),
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
                )
              ],
            ),
            Positioned(
              bottom: 20,
              left: 25,
              child: Container(
                margin: EdgeInsets.only(right: 150),
                child: RichText(
                  text: TextSpan(

                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: "Politica de Privacidad ",style: TextStyle(fontSize: 18,color: AppColors.secondaryBackground, fontFamily: "Sf-r"),recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://docs.google.com/document/d/1Nlxwy9yRapiRkWzmYDiEp6EklW22LBzkeqiPn1Rv-1Y/edit?usp=sharing');
                    },
                  ),

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Container(
                width: 124,
                height: 44,
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
                        Icon(Icons.arrow_forward),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Siguiente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => this._siguienteBtn(context)),
              ),
            )
          ],
        ),
      ),
    );
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

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showSlideDialogChico(
      context: context,
      child: ErrorDialog(
        title: "Oops...",
        error: errorMessage,
      ),
      animatedPill: false);
}
