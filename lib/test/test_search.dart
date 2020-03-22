import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';

class Example9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Container(
         width: 230,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Image.asset("assets/images/buymy-hd.png", fit: BoxFit.fitWidth,),
             SizedBox(height: 20),
             CircularProgressIndicator(

               strokeWidth: 4.0,
             )
             /*Container(
               height: 35,
             )*/
           ],
         ),
       ),
     ),
    );
  }
}


