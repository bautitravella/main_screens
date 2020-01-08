import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  static Widget dashBoardWidget = Container(
    padding: EdgeInsets.all(0),
    child: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 228, 228, 228),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 262,
                    /*shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                        )
                      ),*/
                    decoration: BoxDecoration(
                      color: Color.fromARGB(115, 57, 57, 57),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  left: 54,
                  top: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 143,
                        margin: EdgeInsets.only(left: 100),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 38,
                                  margin: EdgeInsets.only(
                                      top: 94, right: 23, left: 23),
                                  child: Image.asset(
                                    "assets/images/buymy-whitelogo.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 138,
                                height: 143,
                                child: Image.asset(
                                  "assets/images/round-underpic.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 14, right: 53),
                        child: Text(
                          "Todos los libros en\nun solo lugar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            height: 0.92308,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 21, top: 14, right: 71),
                        child: Opacity(
                          opacity: 0.71941,
                          child: Text(
                            "!Encontralos ya!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 43,
                  right: 18,
                  child: Container(
                    width: 50,
                    height: 51,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(41, 0, 0, 0),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/1005-viernes-fluvial-mari-343-3.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text('Hola maquina, segui asi'),
          ),
          horizontalListView, //Acaaaaaaaaaaaa podes seguir agragando las cosas que quieras agregar abajo de lafotito de los libros
        ],
      ),
    ),
  );

  static Widget horizontalListView = Container(
    margin: EdgeInsets.symmetric(vertical: 20.0),
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
