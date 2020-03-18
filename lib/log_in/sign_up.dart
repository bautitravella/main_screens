import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
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
  final passwordVerificationController = TextEditingController();
  String _email;
  String _password;
  String _passwordVerification;
  String _errorText = '';


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
    _passwordVerification = passwordVerificationController.text;

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
    if(_password != _passwordVerification){
      setState(() {
        _errorText += 'La password y la pasword de verificacion no coinciden';
      });
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
      resizeToAvoidBottomInset: false,
      body: Container(
        width: SizeConfig.blockSizeHorizontal*100,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28, top: SizeConfig.blockSizeVertical*10),
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
                Container(
                  margin: EdgeInsets.only(left: 38, right: 38, top: SizeConfig.blockSizeVertical*8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: 22,
                                height: 22,
                                child: Icon(
                                    Icons.alternate_email
                                )
                            ),
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
                                      contentPadding: EdgeInsets.only(bottom: 10),
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
                                child: Icon(
                                    Icons.lock_outline
                                )
                            ),
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
                                      contentPadding: EdgeInsets.only(bottom: 10),
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
                                child: Icon(
                                    Icons.lock_outline
                                )
                            ),
                            Expanded(
                              child: Container(
                                height: 35,
                                width: 200,
                                margin: EdgeInsets.only(left: 10),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    controller: passwordVerificationController,
                                    decoration: InputDecoration(
                                      hintText: "Confirmar contraseña",
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.only(bottom: 10),
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
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*1),
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
                    width: SizeConfig.blockSizeHorizontal*100,
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
                          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*13),
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
                  ),
                )
              ],
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
                        Icon(
                            Icons.arrow_forward
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


void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}