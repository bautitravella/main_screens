import 'package:flutter/material.dart';

class PillGesture extends StatelessWidget {
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Color pillColor;
  bool animatedPill = false;

  PillGesture({
    @required this.onVerticalDragStart,
    @required this.onVerticalDragUpdate,
    @required this.onVerticalDragEnd,
    @required this.pillColor,
    this.animatedPill,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
           animatedPill
               ? Container(
             height: 5.0,
             width: 25.0,
             child: ClipRRect(
               borderRadius: BorderRadius.circular(50.0),
               child: LinearProgressIndicator(
                 backgroundColor:  pillColor ?? Colors.blueGrey[200],
               ),
             ),
           )
               :Container(
             height: 5.0,
             width: 25.0,
             decoration: BoxDecoration(
               color: pillColor ?? Colors.blueGrey[200],
               borderRadius: BorderRadius.circular(50.0),
             ),
           ),

           /* Container(
              height: 5.0,
              width: 25.0,
              decoration: BoxDecoration(
                color: pillColor ?? Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),*/
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
