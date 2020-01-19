import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/catergory_selector.dart';
import 'package:flutterui/values/colors.dart';


class MyBooksView extends StatefulWidget {
  @override
  _MyBooksViewState createState() => _MyBooksViewState();
}

class _MyBooksViewState extends State<MyBooksView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            margin: EdgeInsets.only(left: 22, top: 120),
            child: Text(
              "Mis libros",
              style: TextStyle(
                fontFamily: "Gibson",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
          ),
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: verticalGridViewPublicados
            ),
          )
        ],
      ),
    );
  }

  static Widget verticalGridViewPublicados = Container(
    height: 220,
    margin: EdgeInsets.all(0),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = books[index];

        return Stack(
          children: <Widget>[
            Container(
            color: Colors.red,
            height: 30,
            width: 30,
            )
          ],
        );
      },
    ),
  );
  static Widget verticalGridViewVendidos = Container(
    height: 220,
    margin: EdgeInsets.all(0),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = books[index];

        return Stack(
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 30,
              width: 30,
            )
          ],
        );
      },
    ),
  );
}
