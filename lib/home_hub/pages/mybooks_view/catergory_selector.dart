import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/values/colors.dart';

import '../../../size_config.dart';

class CategorySelector extends StatefulWidget {



  @override
  _CategorySelectorState createState() => _CategorySelectorState(parentWidget);


  MyBooksViewState parentWidget;
  CategorySelector(MyBooksViewState parentWidget){
    this.parentWidget = parentWidget;
  }
}
class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Publicados', 'Vendidos'];
  static MyBooksViewState aux;
  bool isPublicado = true;

  _CategorySelectorState(MyBooksViewState state){
   aux = state;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 213, 104),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  child:  FlatButton(
                      color:  isPublicado == true ? Colors.white : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
                      child: Text(
                       'Publicado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Sf-r",
                          color: isPublicado ? AppColors.secondaryBackground : Colors.white60,
                          fontWeight: FontWeight.w800,
                          fontSize: 17.0,
                        ),
                      ),
                      onPressed: () {
                    setState(() {
                      isPublicado = true;
                      aux.changeFunction(isPublicado);
                    });
                      }
                  ),

                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  child:  FlatButton(
                      color:  isPublicado == false ? Colors.white : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
                      child: Text(
                        'Vendidos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Sf-r",
                          color: isPublicado == false ? AppColors.secondaryBackground : Colors.white60,
                          fontWeight: FontWeight.w800,
                          fontSize: 17.0,
                        ),
                      ),
                      onPressed: () {
                    setState(() {
                      isPublicado = false;
                      aux.changeFunction(isPublicado);
                    });
                      }
                  ),

                ),
              ],
            ),
//                ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: categories.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Row(
//                    children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.symmetric(
//                              horizontal: 20,
//                              vertical: 13,
//                          ),
//                          child:  FlatButton(
//                            color: index == selectedIndex ? Colors.white : Colors.transparent,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(10)),
//                              ),
//                              textColor: Color.fromARGB(255, 255, 255, 255),
//                              padding: EdgeInsets.only(left: 15, right: 15),
//                              child: Text(
//                                    categories[index],
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      fontFamily: "Gibson",
//                                      color: index == selectedIndex ? AppColors.secondaryBackground : Colors.white60,
//                                      fontWeight: FontWeight.w600,
//                                      fontSize: 17.0,
//                                    ),
//                                  ),
//                              onPressed: () {
//                                setState(() {
//                                  selectedIndex = index;
//                                  aux.changeFunction(index);
//                                });
//                              }
//                          ),
//
//                        ),                        Padding(
//                        padding: EdgeInsets.symmetric(
//                          horizontal: 20,
//                          vertical: 13,
//                        ),
//                        child:  FlatButton(
//                            color: index == selectedIndex ? Colors.white : Colors.transparent,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.all(Radius.circular(10)),
//                            ),
//                            textColor: Color.fromARGB(255, 255, 255, 255),
//                            padding: EdgeInsets.only(left: 15, right: 15),
//                            child: Text(
//                              categories[index],
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                fontFamily: "Gibson",
//                                color: index == selectedIndex ? AppColors.secondaryBackground : Colors.white60,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 17.0,
//                              ),
//                            ),
//                            onPressed: () {
//                              setState(() {
//                                selectedIndex = index;
//                                aux.changeFunction(index);
//                              });
//                            }
//                        ),
//
//                      ),
//
//                      ],
//                  );
//                }),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                color: Colors.white70,
                height: 15,
                width: 2,
              ),
            )
              ],
        ));
  }
}
