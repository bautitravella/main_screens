library slide_popup_dialog;

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutterui/dialogs/slide_dialog.dart';

/// Display slide dialog.
/// 
/// `barrierColor` Color of outside dialog. Defaults to Colors.black.withOpacity(0.7).
/// 
/// `barrierDismissible` Can be dismissed by tapping outside dialog. Defaults to true.
/// 
/// `transitionDuration` Duration of slide transition. Defaults to Duration(milliseconds: 300).
/// 
/// `pillColor` Color of pill inside dialog. Defaults to Colors.blueGrey[200].
/// 
/// `backgroundColor` Color of dialog background. Defaults to Theme.of(context).canvasColor.
///

Future<T> showSlideDialogNotification<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
  bool animatedPill = false,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    /*barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.1),*/
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogNotification(
            child: child,
            pillColor: pillColor ?? Colors.blueGrey[200],
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            animatedPill: animatedPill,
          ),
        ),
      );
    },
  );
}



Future<T> showSlideDialogChico<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
  bool animatedPill = false,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.4),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogChico(
            child: child,
            pillColor: pillColor ?? Colors.blueGrey[200],
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            animatedPill: animatedPill,
          ),
        ),
      );
    },
  );
}


Future<T> showSlideDialogGrande<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.4),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: SlideDialogGrande(
              child: child,
              pillColor: pillColor ?? Colors.blueGrey[200],
              backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            ),
          ),
        ),
      );
    },
  );
}


Future<T> showSlideDialogFull<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {},
    barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.4),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: SlideDialogFull(
              child: child,
              pillColor: pillColor ?? Colors.blueGrey[200],
              backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            ),
          ),
        ),
      );
    },
  );
}
