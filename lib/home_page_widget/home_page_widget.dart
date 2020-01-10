import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  static Widget dashBoardWidget = Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 269,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/images/photo-85889-landscape-850x566.png",
                                fit: BoxFit.fill,
                                color: Color.fromARGB(80, 0, 0, 0),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ), //BackgroudHeader
                            Positioned(
                                left: null,
                                right: null,
                                bottom: 30,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              "assets/images/buymy-whitelogo.png"),
                                          fit: BoxFit.cover,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Todos los libros en\nun solo lugar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 26,
                                              height: 0.92308,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          child: Text(
                                            "!Encontralos ya!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                          height: 35,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 21),
                                child: Text(
                                  "LIBROS DESTACADOS",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 57, 57, 57),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 98,
                                alignment: Alignment.centerRight,
                                margin:
                                    EdgeInsets.only(top: 0, left: 44, right: 5),
                                child: FlatButton(
                                  onPressed: null,
                                  disabledColor: AppColors.secondaryBackground,
                                  color: Color.fromARGB(255, 251, 187, 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                  child: Text(
                                    "VER TODO",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      horizontalListView,
                      Container(
                        height: 35,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 0, left: 21),
                              child: Text(
                                "LIBROS DESTACADOS",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 57, 57, 57),
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 98,
                              alignment: Alignment.centerRight,
                              margin:
                                  EdgeInsets.only(top: 0, left: 44, right: 5),
                              child: FlatButton(
                                onPressed: null,
                                disabledColor: AppColors.secondaryBackground,
                                color: Color.fromARGB(255, 251, 187, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                                child: Text(
                                  "VER TODO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      horizontalListView,
                    ],
                  ),
                )),
            Container(
              child: Container(
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  static Widget horizontalListView = Container(
    margin: EdgeInsets.only(left: 30, top: 25),
    height: 200.0,
    child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
      Container(
        width: 160.0,
        color: Colors.red,
      ),
      Container(
        width: 160.0,
        color: Colors.blue,
      ),
      Container(
        width: 160.0,
        color: Colors.green,
      ),
      Container(
        width: 160.0,
        color: Colors.red,
      ),
      Container(
        width: 160.0,
        color: Colors.blue,
      ),
      Container(
        width: 160.0,
        color: Colors.green,
      ),
      Container(
        width: 160.0,
        color: Colors.red,
      ),
      Container(
        width: 160.0,
        color: Colors.blue,
      ),
      Container(
        width: 160.0,
        color: Colors.green,
      ),
      Container(
        width: 160.0,
        color: Colors.red,
      ),
      Container(
        width: 160.0,
        color: Colors.blue,
      ),
      Container(
        width: 160.0,
        color: Colors.green,
      ),
    ]),
  );

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    dashBoardWidget,
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
  void onGroup1862Pressed(BuildContext context) {}

  void onGroup1864Pressed(BuildContext context) {}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Star'),
          ),
        ],
      ),
    );
  }
}
