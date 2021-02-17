import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Instituition.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/particular_insituitions_information/particular_instituitions_information_bloc_event.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/WidgetsCopy/dropdown_smartselect/smart_select.dart';

class DropDownMagic extends StatelessWidget{

  String title;
  Function onChange;
  List<S2Choice<int>> choiceItems;
  List<int> value;

  DropDownMagic({this.title,this.onChange,this.choiceItems,this.value});



  @override
  Widget build(BuildContext context) {
    return SmartSelect<int>.multiple(
      /*choiceHeaderStyle:S2ChoiceHeaderStyle(
        textStyle: Theme.of(context).textTheme.headline6,
      ),*/
      modalHeader:true,
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
          textStyle: TextStyle(
            color: Colors.white54,
            fontFamily: "Sf-r",
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
      ),
      modalStyle: S2ModalStyle(
          elevation: 10,
          backgroundColor: Theme.of(context).dialogBackgroundColor
      ),
      modalFilter: true,
      modalFilterAuto: true,
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

createSmartSelectMateriasList(List<String> colegios, Map<String,Instituition> instituitionsMap,BuildContext context, List<String> materiasList){
  List<String> result = [];
  List<S2Choice<int>> resultColegioAclaracion = [];
  int i=0;
  colegios.forEach((colegio) {
    if(instituitionsMap.containsKey(colegio)){
      print("AAAAA" + result.toString() + resultColegioAclaracion.toString() );
      //seguimos para adelante
      School school = instituitionsMap[colegio];
      for(int j=i;j< school.subjects.length;j++,i++){
        result.add(school.subjects[j]);
        print("AAAAA" + result.toString() + (school.subjects[j].toString() + " (" + school.abreviation.toString() + ")"));
        resultColegioAclaracion.add(S2Choice<int>(value: j,title: (school.subjects[j] + " (" + school.abreviation + ")")));
      }
      print("AAAAA" + result.toString() + resultColegioAclaracion.toString() );
    }else{
      //tenemos que solicitar que se cargue la info de este colegio
      BlocProvider.of<ParticularInstituitionsInformationBloc>(context).add(LoadInstituitionInfo(instituition:colegio));
    }
  });
  materiasList=result;
  return resultColegioAclaracion;
}