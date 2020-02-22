import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/explore_view/explore_view.dart';
import 'package:flutterui/home_hub/pages/home_view/home_view_tres.dart';
import 'file:///C:/Users/trave/AndroidStudioProjects/main_screens/lib/home_hub/pages/home_view/home_view_dos.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/home_hub/pages/notifications_view/notifications_view.dart';
import 'package:flutterui/home_hub/pages/pages.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';



class HomeHub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeHubState();
  }
}

class _HomeHubState extends State<HomeHub> {
  int _currentIndex = 0;
  PageController _pageController;
  final List<Widget> _children = [

    HomeViewTres(),
    MyBooksView(),
    FavoriteView(),
    /*ExploreView(),*/
    NotificationView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text(
                'Home', textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              icon: Icon(Icons.home),
            activeColor: Color.fromARGB(255, 254, 189, 16),
            inactiveColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavyBarItem(
              title: Text('My Books', textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              icon: Icon(Icons.inbox),
    activeColor: Color.fromARGB(255, 254, 189, 16),
    inactiveColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavyBarItem(
              title: Text('Favoritos',textAlign: TextAlign.center,
    style: TextStyle(
    fontFamily: "Sf-r",
    fontWeight: FontWeight.w800,
    fontSize: 15,
    ),
              ),
              icon: Icon(Icons.favorite),
            activeColor: Color.fromARGB(255, 254, 189, 16),
            inactiveColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavyBarItem(
              title: Text('Notifications', textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),),
              icon: Icon(Icons.notifications),
            activeColor: Color.fromARGB(255, 254, 189, 16),
            inactiveColor: Color.fromARGB(255, 128, 128, 128),
          ),
        ],
      ),
    );
  }
/* int _currentIndex = 2;
  final List<Widget> _children = [

  MyBooksView(),
  ExploreView(),
  HomeViewTres(),
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
*/

}