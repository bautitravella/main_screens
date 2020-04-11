import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/log_in/registrar_info_usuario/subi_foto_perfil_widget.dart';

final List<String> imgList = [
  "assets/images/rol-padre.png",
  "assets/images/rol-alumno.png",
  "assets/images/rol-universitario.png",
  ];

final List<String> imgText = [
  "Texto de la imagen 0",
  "Texto de la imagen 1",
  "Texto de la imagen 2",
];

final List<Widget> imgNavigatorPush = [
  SubiFotoPerfilWidget(Padre()),
  SubiFotoPerfilWidget(Alumno()),
  SubiFotoPerfilWidget(Alumno()),
];

final Widget placeholder = Container(color: Colors.grey);



final List child = map2<Widget>(imgList,imgText,imgNavigatorPush, (index, i) {
    return GestureDetector(
      onTap: () => print("tapped in box number $index"),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(245, 245, 245, 245),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(children: <Widget>[
            Image.asset(i, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  imgText[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    return Container(child: Text(""));
  },
).toList();


List<T> map2<T>(List imageList,List imgText, List<Widget> imgWidget, Function handler) {
  List<T> result = [];
  for (var i = 0; i < imageList.length; i++) {
    result.add(handler(i, imageList[i]));
  }

  return result;
}

List<T> map<T>(List imageList, Function handler) {
  List<T> result = [];
  for (var i = 0; i < imageList.length; i++) {
    result.add(handler(i, imageList[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          CarouselSlider(
            items: child,
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 0.8,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              imgList,
                  (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
