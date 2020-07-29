import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/home_hub/pages/explore_view/explore_view.dart';
import 'package:flutterui/home_hub/pages/favoritos_view/favoritos_view.dart';
import 'package:flutterui/home_hub/pages/home_view/home_view_tres.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view_multi.dart';
import 'package:flutterui/home_hub/pages/notifications_view/notifications_view.dart';
import 'package:flutterui/home_hub/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:provider/provider.dart';



class HomeHub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeHubState();
  }
}

class HomeHubState extends State<HomeHub> {
  int _currentIndex = 0;
  PageController _pageController;
  List<Widget> _children;

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home");
    super.initState();
    _pageController = PageController();
    _children = [

      HomeViewTres(homeHubState: this),
      MyBooksViewMulti(),
      FavoritosView(),
      /*ExploreView(),*/
      NotificationView(),
    ];

//    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
//    analytics.setCurrentScreen(screenName: "/home");
  }

  void changeToHome(){
    setState(() => _currentIndex = 0);
    _pageController.jumpToPage(0);
  }

  void changeToMyBooks(){
      setState(() => _currentIndex = 1);
      _pageController.jumpToPage(1);
  }

  void changeToFavorites(){
    setState(() => _currentIndex = 2);
    _pageController.jumpToPage(2);
  }

  void changeToChats(){
    setState(() => _currentIndex = 3);
    _pageController.jumpToPage(3);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop:() {return _onWillPop();},
      child: Scaffold(
        body: Stack(
          children: [
            _children[_currentIndex],
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
                          "assets/images/round-underpic-shade.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 45,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MiPerfil(),
                          ),
                        );
                      },
                      child: BlocBuilder<UserBloc, UserBlocState>(
                        builder: (context, state) {
                          if (state is UserLoadedState) {
                            return Container(
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
                                child: Hero(
                                  tag: 'avatar',
                                  child: Image(
                                    image: state.user.getProfileImage(),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          showElevation: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            try{
              _pageController?.jumpToPage(index);
            }catch(e){
              //print("HOME HUB: PAGE CONTROLLER ERROR");
            }

          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: Text(
                'Inicio', textAlign: TextAlign.center,
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
              title: Text('Mis libros', textAlign: TextAlign.center,
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
              title: Text('Favoritos', textAlign: TextAlign.center,
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
              title: Text('Mensajes', textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),),
              icon: Icon(FontAwesome5Solid.comment),
              activeColor: Color.fromARGB(255, 254, 189, 16),
              inactiveColor: Color.fromARGB(255, 128, 128, 128),
            ),
          ],
        ),
      ),
    );
  }

  _onWillPop() {
    if(_currentIndex != 0){
      changeToHome();
    }else {
      if(Platform.isIOS){
        return null;
      }else {
        SystemNavigator.pop();
      }
      return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: ListTile(
                  title: Text("Sign Out"),
                  subtitle: Text(
                      "Si presionas Continuar, esto desconectara tu cuenta y te enviara al menu de log in"),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Continuar'),
                    onPressed: () async {
                      try {
                        final auth = Provider.of<BaseAuth>(context,
                            listen: false);
                        await auth.signOut();
                        BlocProvider.of<UserBloc>(context).add(UnloadUser());
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FirstscreenWidget(),
                          ),
                        );
                      } catch (e) {
                        print(e.message);
                      }
                    },
                  ),
                ],
              )
      );
    }
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
  }*/
}