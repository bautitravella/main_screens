import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/values/colors.dart';

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


  _CategorySelectorState(MyBooksViewState state){
   aux = state;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 60,
        color: AppColors.secondaryBackground,

        child: Stack(

          children: <Widget>[
                ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                          ),
                          child:  FlatButton(
                            color: index == selectedIndex ? Colors.white : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                    categories[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      color: index == selectedIndex ? AppColors.secondaryBackground : Colors.white60,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0,
                                    ),
                                  ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = index;
                                  aux.changeFunction(index);
                                });
                              }
                          ),

                        ),

                      ],
                  );
                }),
            Positioned(
              left: 150,
              top: 22,
              child: Container(
                margin: EdgeInsets.only(left: 5),
                color: Colors.white,
                height: 15,
                width: 2,
              ),
            )
              ],
        ));
  }
}
