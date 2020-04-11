import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterui/log_in/recuperation_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/test/textfield/textfield_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';


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
        Navigator.pop(context);
        showErrorDialog(context, _errorText);
      } catch (error) {
        setState(() {
          _errorText = '$error';
        });
        Navigator.pop(context);
        showErrorDialog(context, _errorText);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8, left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  "Correo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BeautyTextfield(
                  controller: emailController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color
                  textColor: Colors.black, //Text Color
                  backgroundColor: Color.fromARGB(255, 222, 222, 222), //Not Focused Color
                  fontFamily: 'Sf', //Text Fontfamily
                  fontWeight: FontWeight.w500,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.emailAddress,
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
                Text(
                  "Contraseña",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BeautyTextfield(
                  controller: passwordController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color
                  textColor: Colors.black, //Text Color
                  backgroundColor: Color.fromARGB(255, 222, 222, 222), //Not Focused Color
                  textBaseline: TextBaseline.alphabetic,
                  fontFamily: 'Sf', //Text Fontfamily
                  fontWeight: FontWeight.w500,
                  passwordIcon: true,
                  obscureText: true,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text, //REQUIRED//REQUIRED
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecuperationWidget()),
                    );
                  },
                  child: Text(
                    "¿Has olvidado la contraseña?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 100, 100),
                      fontSize: 15,
                      fontFamily: "Sf",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Conectate con",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  width: double.maxFinite,
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
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    textColor: Color.fromARGB(255, 117, 117, 117),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(),
                        ),
                        Text(
                          "Continuar con Google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            "assets/images/login-google.png", scale: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => this.logInWithFacebookBtn(context),
                    color: Color.fromARGB(255, 74, 74, 74),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(112, 112, 112, 112),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    textColor: Color.fromARGB(255, 117, 117, 117),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(),
                        ),
                        Text(
                          "Continuar con Apple",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            "assets/images/login-apple.png", scale: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*9),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => this._siguienteBtn(context),
                    /*color: Color.fromARGB(255, 222, 222, 222),*/
                    color: AppColors.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Iniciar Sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          /*color: Color.fromARGB(255, 174, 174, 174),*/
                          color: Colors.white,
                          fontFamily: "Sf",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
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
