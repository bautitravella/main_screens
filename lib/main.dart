
import 'package:flutter/material.dart';
import 'package:flutterui/firstscreen_widget/firstscreen_widget.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/values/colors.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: FirstscreenWidget(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => HomeHub(),
        '/logOut': (BuildContext context) => FirstscreenWidget(),

      },
      theme: ThemeData(
        accentColor: AppColors.secondaryBackground,
        

      ),
    );
  }
}