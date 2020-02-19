import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/Models/school_model.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CategoriesColegios extends StatefulWidget {
  CategoriesColegios({Key key}) : super(key: key);
  @override
  _CategoriesColegiosState createState() => _CategoriesColegiosState();
}

class _CategoriesColegiosState extends State<CategoriesColegios> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: SizeConfig.blockSizeVertical * 10,
                  right: 0,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 45,
                    child: Image.asset(
                      "assets/images/destacados-image.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.blockSizeVertical * 6,
                  left: 24,
                  right: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          /* IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),*/
                          Text(
                            "Colegios",
                            style: TextStyle(
                              fontFamily: "Sf-r",
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.search, color: Colors.white, size: 26),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.more_vert, color: Colors.white, size: 26)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 88,
                    minHeight: SizeConfig.blockSizeVertical * 88,
                    color: Colors.transparent,
                    backdropEnabled: false,
                    parallaxEnabled: true,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.transparent,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Container(
          height: 40,
          margin: EdgeInsets.only(left: 22, bottom: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              UnconstrainedBox(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)
                    )
                  ),
                  child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 22,
                          width: 22,
                          child: Image.asset("assets/images/logocolegio-fds.png", fit: BoxFit.fill,),
                        ),
                        Text("Florida Day School",
                          style: TextStyle(
                            fontFamily: "Sf-r",
                            color: Color.fromARGB(255, 27, 27, 27),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                            child: Icon(Icons.close, size: 22,))
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),*/
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: schools.length,
                  itemBuilder: (BuildContext context, int index) {
                   School school = schools[index];
                    return  Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                      height: 151.0,
                      color: Colors.red,
                      width: SizeConfig.blockSizeHorizontal * 100,
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
