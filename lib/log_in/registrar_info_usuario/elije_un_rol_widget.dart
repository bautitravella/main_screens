import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/log_in/registrar_info_usuario/subi_foto_perfil_widget.dart';
import '../../size_config.dart';

class ElijeUnRolWidget extends StatelessWidget {

  String email;
  ElijeUnRolWidget(this.email);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeConfig.blockSizeHorizontal*100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onWillPop(context),
                child: Container(
                    margin: EdgeInsets.only(left: 28, top: SizeConfig.blockSizeVertical*7),
                    child: Icon(
                      Icons.arrow_back_ios, size: 25, color: Colors.black87,)
                    ),
              ),
              Container(
                margin: EdgeInsets.only(left: 28, top: SizeConfig.blockSizeVertical*4),
                child: Text(
                  "Tu cuenta",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal*100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*19),
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/parentandchild.png",
                              fit: BoxFit.fill,
                            ),
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*17,right: SizeConfig.blockSizeHorizontal*17, bottom: SizeConfig.blockSizeVertical*7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 99,
                                height: 35,
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                child: FlatButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubiFotoPerfilWidget(new Padre.fromEmail(email))),
                                      );
                                    },
                                    color: Color.fromARGB(200, 57, 57, 57),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(17.5)),
                                    ),
                                    textColor: Color.fromARGB(255, 0, 0, 0),
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      "Padre",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: -0.36,
                                      ),
                                    )
                                )
                            ),
                            Container(
                                width: 99,
                                height: 35,
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                child: FlatButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubiFotoPerfilWidget(new Alumno.fromEmail(email))),
                                      );
                                    },
                                    color: Color.fromARGB(200, 57, 57, 57),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(17.5)),
                                    ),
                                    textColor: Color.fromARGB(255, 0, 0, 0),
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      "Alumno",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: -0.36,
                                      ),
                                    )
                                )
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Elije un rol",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Sf-r",
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            letterSpacing: -0.43393,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5, right:SizeConfig.blockSizeHorizontal*5, bottom: SizeConfig.blockSizeVertical*8),
                          child: Text("Esto determinara cuantos cursos\nestarán disponibles dentro de la app.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 163, 163),
                              fontFamily: "Sf-t",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              letterSpacing: -0.1,
                              height: 1.4,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onWillPop(BuildContext context){
    print("ELIJEUNROL PRINT    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    final auth = Provider.of<BaseAuth>(context,listen: false);
    try{
      auth.signOut();
    }catch(e){
      print(e.toString());
    }
    BlocProvider.of<UserBloc>(context).add(UnloadUser());
    Navigator.popUntil(
    context,
    ModalRoute.withName('/'),
    );

  }
}