import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/home_view_dos.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/home_hub/pages/notifications_view/notifications_view.dart';
import 'package:flutterui/home_hub/pages/pages.dart';



class HomeHub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeHubState();
  }
}

class _HomeHubState extends State<HomeHub> {
  int _currentIndex = 2;
  final List<Widget> _children = [

  MyBooksView(),
  ExplorePage(),
  HomeViewDos(),
  FavoriteView(),
  NotificationView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          unselectedItemColor: Color.fromARGB(255, 112, 112, 112),
          selectedItemColor: Color.fromARGB(255, 254, 189, 16),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.inbox),
              title: new Text("My Books"),
              activeIcon: new Icon(Icons.archive),
            ),


            BottomNavigationBarItem(
              icon: new Icon(Icons.explore),
              title: new Text("Porongo2"),
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.star),
              title: new Text("Favorite"),
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications),
              title: new Text("Notifications"),
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