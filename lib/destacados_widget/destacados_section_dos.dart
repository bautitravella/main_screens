import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DestacadosSectionDos extends StatefulWidget {
  DestacadosSectionDos({Key key}) : super(key: key);
  @override
  _DestacadosSectionDosState createState() => _DestacadosSectionDosState();
}

class _DestacadosSectionDosState extends State<DestacadosSectionDos> {
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Destacados",
                              style: TextStyle(
                                fontFamily: "Sf-r",
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.sort),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )
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
                    backdropEnabled: false,
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
    return Container(
      height: 220,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: sc,
          itemCount: books2.length,
          itemBuilder: (BuildContext context, int index) {
            Book2 book = books2[index];

            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  padding: EdgeInsets.fromLTRB(13, 13, 13, 11),
                  height: 127.0,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  decoration: BoxDecoration(
                   /* color: Color.fromARGB(255, 241, 242, 242),*/
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 45,
                                  child: Text(
                                    "${book.name}",
                                    style: TextStyle(
                                      color: Color.fromARGB(200, 0, 0, 0),
                                      fontSize: 16,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${book.author}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Sf-t",
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.star_border),
                                      onPressed: () {},
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 14,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(20, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      book.state.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Sf-r",
                                        color: Color.fromARGB(100, 0, 0, 0),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 62.5,
                                  margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              height: 30,
                                              width: 30,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.asset("assets/images/avatar.png"),
                                              )),
                                          Container(
                                            height: 21,
                                            width: 40,
                                            margin: EdgeInsets.only(left: 4),
                                            padding: EdgeInsets.only(left: 4, right: 4),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(180, 116, 116, 116),
                                              borderRadius: BorderRadius.circular(8.0),
                                              border: Border.all(
                                                  width: 1.0, color: Color.fromARGB(255, 235, 235, 235)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                    Icons.star,
                                                    size: 17,
                                                    color: Colors.white),
                                                Text(
                                                  '${book.rating}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800,
                                                      fontFamily: "Sf-r",
                                                      color: Colors.white
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '\$${book.price}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: "Sf-r",
                                                  color: Color.fromARGB(
                                                      190, 0, 0, 0),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  bottom: 15,
                  top: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                        book.imageUrl,
                      ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                    left: 22,
                    right: 22,
                    child:Container(
                      height: 2,
                      color: Colors.black12,
                    )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
