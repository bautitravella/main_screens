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
import 'package:flutterui/test/elije_un_rol_new.dart';

class ElijeUnRolWidget extends StatelessWidget {

  String email;
  ElijeUnRolWidget(this.email);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child:  Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8,left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
                        SizedBox(width: 10),
                        Text(
                          "Configura tu perfil",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*7),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
                    child: Text(
                      "Elegí un rol",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical*5),
                  CarouselWithIndicator(),
                ],
              ),
            ),
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



