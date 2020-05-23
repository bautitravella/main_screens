import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/values/colors.dart';

import '../../../../size_config.dart';
import '../mybooks_view_multi.dart';


class CategorySelectorMulti extends StatefulWidget {



  @override
  _CategorySelectorMultiState createState() => _CategorySelectorMultiState(parentWidget);


  MyBooksViewMultiState parentWidget;
  CategorySelectorMulti(MyBooksViewMultiState parentWidget){
    this.parentWidget = parentWidget;
  }
}
class _CategorySelectorMultiState extends State<CategorySelectorMulti> {
  int selectedIndex = 0;
  final List<String> categories = ['Publicados', 'Vendidos'];
  static MyBooksViewMultiState aux;
  bool isPublicado = true;

  _CategorySelectorMultiState(MyBooksViewMultiState state){
    aux = state;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 28),
          GestureDetector(
            onTap:  () {
              setState(() {
              isPublicado = true;
              aux.changeFunction(isPublicado);
              });
              },
            child: Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: isPublicado == true ?Color.fromARGB(255, 255, 213, 104):Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                        BoxShadow(
                        blurRadius: 20.0,
                        color: isPublicado == true ? Color.fromRGBO(0, 0, 0, 0.15): Colors.transparent,
                      ),
                    ]
                      ),
                      child: Icon(
                        Icons.inbox,
                        color:  Colors.white,
                        size: 30,
                      )),
                  Text(
                    'Publicado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap:  () {
              setState(() {
                isPublicado = false;
                aux.changeFunction(isPublicado);
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: isPublicado == false ?Color.fromARGB(255, 255, 213, 104): Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                        BoxShadow(
                        blurRadius: 20.0,
                        color: isPublicado == false ? Color.fromRGBO(0, 0, 0, 0.15): Colors.transparent,
                      ),
                ]
            ),
                      child: Icon(
                        Icons.call_made,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    'Vendido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        /*  GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.inbox,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Comprado",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
