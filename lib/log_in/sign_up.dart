import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterui/textfield/textfield_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';
import '../auth.dart';
import '../main.dart';
import '../size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';


class SignUp extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }


}

class SignUpState extends State<SignUp>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _email;
  String _password;
  String _errorText = '';

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/sign_up");
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
    }catch (e){
      setState(() {
        _errorText = e.toString();
      });

      showErrorDialog(context, _errorText);
    }


  }

  void logInWithFacebookBtn(BuildContext context) async {
    var facebookLogin = FacebookLogin();
    var result= await facebookLogin.logIn(['email']);

    switch(result.status){
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
        try{
          final auth = Provider.of<BaseAuth>(context, listen: false);
          String userUID = await auth.signInWithFacebook(result.accessToken);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyDecider()),
          );
        }on PlatformException catch (e) {
          setState(() {
            _errorText = "${e.message}";
          });
          showErrorDialog(context, _errorText);
        }catch (e){
          setState(() {
            _errorText = e.toString();
          });

          showErrorDialog(context, _errorText);
        }

        break;

    }
  }

  bool validateEmailAndPassword() {
    _email = emailController.text;
    _password = passwordController.text;

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
    Navigator.pop(context);
    showErrorDialog(context, _errorText);
    return true;
  }

  void _siguienteBtn(BuildContext context) async {
    _email = emailController.text.trim();
    _password = passwordController.text.trim();
    showLoadingDialog(context);
    if (validateEmailAndPassword() == true) {
      try {
        final auth = Provider.of<BaseAuth>(context,listen: false);
        String userUID =
        await auth.createUserWithEmailAndPassword(_email, _password);
        await auth.signInWithEmailAndPassword(_email, _password);
        setState(() {
          _errorText = 'signed in with : ${userUID})';
        });
        auth.currentUser();//.then((msg) => print('MENSAJE: $msg'));
        //Navigator.push(context,MaterialPageRoute(builder: (context) => VerificacionWidget()),);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDecider()),
        );
      }on PlatformException catch (e) {
        setState(() {
          _errorText = "${e.message}";
        });
        showErrorDialog(context, _errorText);
      }catch (e){
        setState(() {
          _errorText = e.toString();
        });

        showErrorDialog(context, _errorText);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                  child: Text(
                    "Registrarse",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  "Correo",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: emailController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor, //Not Focused Color
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
                SizedBox(height: 15),
                Text(
                  "Tendrás que verificar que eres el propietario de esta cuenta de correo electrónico",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 40),
                Text(
                  "Contraseña",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: passwordController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color
                  textColor: Colors.black, //Text Color
                  backgroundColor: Theme.of(context).hintColor, //Not Focused Color
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
                SizedBox(height: 15),
                Text(
                  '$_errorText',
                  style: TextStyle(color: Color.fromARGB(255, 217, 86, 86), fontSize: 15, fontFamily: "Sf", fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40),
                Text(
                  "Conectate con",
                  style: Theme.of(context).textTheme.headline1,
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
                        color: Colors.white,
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
                SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    children:  <TextSpan>[
                      TextSpan(
                        text: "Al hacer clic en Registrarse, indicas que has leído y aceptado los",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      TextSpan(
                        text: " términos y condiciones",
                        style: TextStyle(color: Color.fromARGB(255, 254, 189, 16), fontSize: 15, fontFamily: "Sf", fontWeight: FontWeight.w600, decoration: TextDecoration.underline,),
                      ),
                      TextSpan(
                        text: " y ",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      TextSpan(
                        text: "aviso de privacidad.",
                        style: TextStyle(color: Color.fromARGB(255, 254, 189, 16), fontSize: 15, fontFamily: "Sf", fontWeight: FontWeight.w600, decoration: TextDecoration.underline,),
                      ),
                    ],

                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch(
                            'https://docs.google.com/document/d/1Nlxwy9yRapiRkWzmYDiEp6EklW22LBzkeqiPn1Rv-1Y/edit?usp=sharing');
                      },
                  ),
                ),
                SizedBox(height: 15),
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
                        "Registrarse",
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



void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage) {
  showSlideDialogChico(context: context, child: ErrorDialog(
    title: "Oops...", error: errorMessage,),
      animatedPill: false);
}