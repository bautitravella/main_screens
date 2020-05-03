import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Themes/AppStateNotifier.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'notifications_view.dart';

class CategorySelectorNotification extends StatefulWidget {



  @override
  _CategorySelectorNotificationState createState() => _CategorySelectorNotificationState(parentWidget);


  NotificationViewState parentWidget;
  CategorySelectorNotification(NotificationViewState parentWidget){
    this.parentWidget = parentWidget;
  }
}
class _CategorySelectorNotificationState extends State<CategorySelectorNotification> {
  int selectedIndex = 0;
  final List<String> categories = ['Venta', 'Compra'];
  static NotificationViewState aux;


  _CategorySelectorNotificationState(NotificationViewState state){
    aux = state;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          ),

        ),
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
                            color: index == selectedIndex ? AppColors.secondaryBackground : Colors.transparent,
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
                                color: index == selectedIndex ? Colors.white : Theme.of(context).iconTheme.color.withAlpha(80),
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
              left: 120,
              top: 22,
              child: Container(
                margin: EdgeInsets.only(left: 5),
                color: Color.fromARGB(100, 57, 57, 57),
                height: 15,
                width: 2,
              ),
            )
          ],
        ));

  }
}
