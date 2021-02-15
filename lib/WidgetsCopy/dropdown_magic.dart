import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class DropDownMagic extends StatelessWidget{

  String title;
  Function onChange;
  List<S2Choice<int>> choiceItems;
  List<int> value;

  DropDownMagic({this.title,this.onChange,this.choiceItems,this.value});



  @override
  Widget build(BuildContext context) {
    return SmartSelect<int>.multiple(
      modalType: S2ModalType.bottomSheet,
      modalHeaderStyle: S2ModalHeaderStyle(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          textStyle: Theme.of(context).textTheme.headline6
      ),
      modalStyle: S2ModalStyle(
          elevation: 10,
          backgroundColor: Theme.of(context).dialogBackgroundColor
      ),
      modalFilter: false,
      title: title,
      value: value,
      choiceItems: choiceItems,
      onChange: onChange,
    );
  }

}