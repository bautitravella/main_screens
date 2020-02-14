import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/message_model.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/primera_subir_foto.dart';
import 'package:flutterui/home_hub/pages/notifications_view/category_selector_notification.dart';
import 'package:flutterui/home_hub/pages/notifications_view/chat_screen.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/size_config.dart';
import '../../../size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'chat_screen_buck.dart';

class NotificationView extends StatefulWidget {
  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  static Widget listViewVenta = ListViewVenta();
  static Widget listViewCompra = ListViewCompra();

  Widget listView = listViewVenta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: SizeConfig.blockSizeVertical * 23,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  child: listView,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 22, top: 120),
                    child: Text(
                      "Notificaciones",
                      style: TextStyle(
                        fontFamily: "Gibson",
                        color: Color.fromARGB(255, 57, 57, 57),
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Container(
                    height: 143,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 138,
                              height: 143,
                              child: Image.asset(
                                "assets/images/round-underpic.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.blockSizeHorizontal * 4,
                          top: SizeConfig.blockSizeVertical * 5,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2, //
                                  ),
                                  borderRadius: new BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/avatar.png",
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ), //Cartelito "Mis Libros"
              CategorySelectorNotification(this),
            ],
          ),
        ],
      ),
    );
  }

  void changeFunction(int index) {
    if (index == 0) {
      setState(() {
        listView = listViewVenta;
      });
    } else {
      setState(() {
        listView = listViewCompra;
      });
    }
  }
}

class ListViewVenta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            final Message chat = chats[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreenBuck(user: chat.sender),
                  )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: SizeConfig.blockSizeHorizontal * 13,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: chat.unread
                            ? AppColors.secondaryBackground
                            : Colors.white,
                        borderRadius: chat.unread
                            ? BorderRadius.all(Radius.circular(30))
                            : null,
                        // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 10,
                        top: 15,
                        bottom: 25),
                    //decoration: BoxDecoration(
                    // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage(chat.sender.imageUrl),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    chats[index].sender.name,
                                    style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      chat.text,
                                      style: TextStyle(
                                        fontFamily: "Sf",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 57, 57, 57),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    chat.time,
                                    style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            chat.sell ?
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 21,
                                  width: 21,
                                  child: Image.asset('assets/images/sell-icon2.png')
                                ),
                                Container(
                                  height: 21,
                                  width: 2,
                                  color: Color.fromARGB(
                                      255, 57, 57, 57),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10),
                                ),
                                Container(
                                    height: 21,
                                    width: 21,
                                    child: Image.asset('assets/images/sell-icon1.png')
                                ),
                              ],
                            )
                                :
                            Row(
                              children: <Widget>[
                                Text(""),
                                chat.unread
                                    ? Container(
                                  child: Icon(
                                    FontAwesome5Solid.comment,
                                    size: 21,
                                    color:
                                    Color.fromARGB(255, 57, 57, 57),
                                  ),
                                )
                                    : Container(
                                  child: Icon(
                                    FontAwesome5.comment,
                                    size: 21,
                                    color:
                                    Color.fromARGB(255, 57, 57, 57),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 85,
                    right: 85,
                    child: Container(
                      height: 1,
                      width: 100,
                      color: Color.fromARGB(20, 57, 57, 57),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class ListViewCompra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            final Message chat = chats[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreenBuck(user: chat.sender),
                  )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: SizeConfig.blockSizeHorizontal * 13,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: chat.unread
                            ? AppColors.secondaryBackground
                            : Colors.white,
                        borderRadius: chat.unread
                            ? BorderRadius.all(Radius.circular(30))
                            : null,
                        // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 10,
                        top: 15,
                        bottom: 25),
                    //decoration: BoxDecoration(
                    // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage(chat.sender.imageUrl),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    chats[index].sender.name,
                                    style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      chat.text,
                                      style: TextStyle(
                                        fontFamily: "Sf",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 57, 57, 57),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    chat.time,
                                    style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                chat.buy
                                    ? Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        MaterialIcons.shopping_basket,
                                        size: 21,
                                        color: Color.fromARGB(
                                            255, 57, 57, 57),
                                      ),
                                      Container(
                                        height: 21,
                                        width: 2,
                                        color: Color.fromARGB(
                                            255, 57, 57, 57),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                      )
                                    ],
                                  ),
                                )
                                    : Text(""),
                                chat.unread
                                    ? Container(
                                  child: Icon(
                                    FontAwesome5Solid.comment,
                                    size: 21,
                                    color:
                                    Color.fromARGB(255, 57, 57, 57),
                                  ),
                                )
                                    : Container(
                                  child: Icon(
                                    FontAwesome5.comment,
                                    size: 21,
                                    color:
                                    Color.fromARGB(255, 57, 57, 57),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 85,
                    right: 85,
                    child: Container(
                      height: 1,
                      width: 100,
                      color: Color.fromARGB(20, 57, 57, 57),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
