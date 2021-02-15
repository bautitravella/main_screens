import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/values/colors.dart';
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
      choiceHeaderStyle:S2ChoiceHeaderStyle(
        textStyle: Theme.of(context).textTheme.headline6,
      ),
      modalHeader: false,
      choiceStyle: S2ChoiceStyle(
        titleStyle: Theme.of(context).textTheme.headline3,
        color: Theme.of(context).iconTheme.color,
        activeColor: AppColors.secondaryBackground,
      ),
      modalConfig: S2ModalConfig(
        type: S2ModalType.bottomSheet,
        enableDrag: true,
      ),
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
      onChange: (data){
        FocusScope.of(context).requestFocus(new FocusNode());
        onChange(data);},
    );
  }

}

createSmartSelectColegiosList(List<String> colegios) {
  List<S2Choice<int>> result = [];
  for(int i=0;i< colegios.length;i++){
    result.add(S2Choice<int>(value: i,title: colegios[i]));
  }
  return result;
}