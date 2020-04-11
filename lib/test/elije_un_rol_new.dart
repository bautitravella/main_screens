import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/log_in/registrar_info_usuario/subi_foto_perfil_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/values/values.dart';


final List<String> imgList = [
  "assets/images/rol-padre.png",
  "assets/images/rol-alumno.png",
  "assets/images/rol-universitario.png",
  ];

final List<String> imgText = [
  "Padres",
  "Texto de la imagen 1",
  "Texto de la imagen 2",
];

final List<String> imgSubText = [
  "Esta opcion te dejara ir agregando multiples colegios para cada uno de tus hijos.",
  "Sub Texto de la imagen 1",
  "Sub Texto de la imagen 2",
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
              blurRadius: 10.0,
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(children: <Widget>[
            Image.asset(i, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 25.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      imgText[index],
                      style: TextStyle(
                        fontFamily: "Sf-r",
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      imgSubText[index],
                      style: TextStyle(
                        fontFamily: "Sf-t",
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: child,
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 0.85,
            initialPage: 1,
            enableInfiniteScroll: false,
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
                          ? AppColors.secondaryBackground
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              },
            ),
          ),
        ]);
  }
}
