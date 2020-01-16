import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        auth: Auth(),
        child: MyDecider(),
      ),
    );
  }
}

class MyDecider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context).auth;
    return StreamBuilder<String> (
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool loggedIn = snapshot.hasData;
          return loggedIn ? HomeHub() : FirstscreenWidget();
        }
        return CircularProgressIndicator();
      },
    );
  }


}