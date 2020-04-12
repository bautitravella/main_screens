import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';

class TestRol extends StatelessWidget {
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
                SizedBox(height: 80),
                Text(
                  "Correo",
                  style: Theme.of(context).textTheme.headline2,
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
                SizedBox(height: 15),
                SizedBox(height: 40),
                Text(
                  "Conectate con",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
