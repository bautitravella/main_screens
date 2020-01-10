import 'package:flutter/material.dart';

class HomePageTestWidget extends StatefulWidget {
  HomePageTestWidget({Key key}) : super(key: key);
  @override
  _HomePageTestWidgetState createState() => _HomePageTestWidgetState();
}

class _HomePageTestWidgetState extends State<HomePageTestWidget> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(

            title: Text("Todos los libros en \nun solo lugar"),
            centerTitle:true,

            background: Image.asset(
              "assets/images/photo-85889-landscape-850x566.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFillRemaining(
            child: Container(height: 80, child: Text("hello world")))
      ],
    ));
  }
}
