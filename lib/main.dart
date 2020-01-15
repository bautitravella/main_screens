
import 'package:flutter/material.dart';
import 'package:flutterui/firstscreen_widget/firstscreen_widget.dart';
import 'package:flutterui/values/colors.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: FirstscreenWidget(),
      theme: ThemeData(
        accentColor: AppColors.secondaryBackground,
        

      ),
    );
  }
}