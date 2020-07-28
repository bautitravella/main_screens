import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/WidgetsCopy/searchable_dropdown_dev.dart';
import 'package:flutterui/blocs/colegios_bloc/colegios_bloc.dart';
import 'package:flutterui/blocs/colegios_bloc/colegios_bloc_state.dart';
import 'package:flutterui/blocs/uploads_bloc/uploads_bloc.dart';
import 'package:flutterui/blocs/uploads_bloc/uploads_bloc_event.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/values/colors.dart';


import '../size_config.dart';

class SubirLibroPrueba extends StatefulWidget {
  @override
  _SubirLibroPruebaState createState() => _SubirLibroPruebaState();
}

class _SubirLibroPruebaState extends State<SubirLibroPrueba> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color,),
                        SizedBox(width: 10),
                        Text(
                          "Configura tu perfil",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*7),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Subí 3 fotos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sube al menos tres fotos del libro que quieras vender.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Es importante subir fotos de tus libros para que otros usuarios tengan una mejor experiencia al comprar.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Text(
                  "Nombre",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*9),
                SearchableDropdown.single(
                  items:<String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                  value: dropdownValue,
                  underline: "",
                  menuBackgroundColor: Colors.red,
                  displayClearIcon: false,
                  icon: null,
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = dropdownValue;
                    });
                  },
                  isExpanded: true,
                ),
                /* SearchableDropdown.single(
                        items: createDropDownMenuListColegios(state.colegiosData.colegios),
                        value: colegioSelectedValue,
                        hint: "Select one",
                        searchHint: null,
                        onChanged: (value) {
                          setState(() {
                          });
                        },
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                      ),*/
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => /*siguienteBtn(context)*/[],
                    /*color: Color.fromARGB(255, 222, 222, 222),*/
                    color: AppColors.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Finalizar",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ),
        ),
      ),

    );
  }

}
void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showSlideDialogChico(
      context: context,
      child: ErrorDialog(
        title: "Oops...",
        error: errorMessage,
      ),
      animatedPill: false);
}

void showSchoolDialog(BuildContext context, String email) {
  TextEditingController colegioNameTextEditingController = TextEditingController();
  String errorMessage = "No has ingresado ningun colegio.";
  showSlideDialogFull(
      context: context,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Enviar solicitud para\nagregar un colegio",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Sf-r",
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado. Una vez aceptada o rechazada te enviaremos un mail con nuestra decision.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Sf-t",
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      TextField(
                        controller: colegioNameTextEditingController,
                        cursorColor: AppColors.secondaryBackground,
                        decoration: InputDecoration(
                          hintText: "Nombre del colegio que quieres agregar",
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ],
                  )
              ),
              SizedBox(height: 80),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(child:
                  Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                    onPressed: ()=> Navigator.pop(context),
                  ),
                  FlatButton(child:
                  Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: AppColors.secondaryBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                    onPressed: (){
                      if(colegioNameTextEditingController.text != null && colegioNameTextEditingController.text.length > 2){
                        //BlocProvider.of<UploadsBloc>(context).add(AddSchool(colegioNameTextEditingController.text,email));
                        Navigator.pop(context);
                        showLoadingDialog(context);
                        Future.delayed(Duration(seconds: 2)).then((smt)=>Navigator.pop(context));
                      }
                      else{Navigator.pop(context);
                      showErrorDialog(context, errorMessage);
                      }
                    },
                  )
                ],
              )

            ],
          ),
        ),
      )
  );
}
