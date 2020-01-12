import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/pages.dart';
import 'package:flutterui/home_hub/pages/home_view.dart';


class HomeHub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeHubState();
  }
}

class _HomeHubState extends State<HomeHub> {
  int _currentIndex = 0;
  final List<Widget> _children = [

    HomeView(),
    ExplorePage(),
    PastTripsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.explore),
              title: new Text("Porongo2"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("Porongo1"),
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}