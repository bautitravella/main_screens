import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/log_in/terminos_ycondiciones_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../size_config.dart';
import 'package:flutterui/dialogs/dialogs.dart';


class CursoPadreWidget extends StatefulWidget {
  Padre user;
  CursoPadreWidget(this.user);

  @override
  _CursoPadreWidgetState createState() => _CursoPadreWidgetState();
}

class _CursoPadreWidgetState extends State<CursoPadreWidget> {


  List<DropdownMenuItem> items = [];
  List<ChildField> hijos = [];
  int _currentIndex = 0;
  bool loadingDialogShown = false;

  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      items.add(new DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new Text(
                      'Colegio ' + i.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 38, 65),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        value: 'Colegio ' + i.toString(),
      ));
    }
    super.initState();
    hijos.add(ChildField(
      key: UniqueKey(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      left: 28, top: SizeConfig.blockSizeVertical * 12),
                  child: Text(
                    "Casi listos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 57, 57, 57),
                      fontWeight: FontWeight.w400,
                      fontSize: 38,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 6, bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/phonochico2.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical * 2,
                        bottom: SizeConfig.blockSizeVertical * 26,
                        child: hijos[_currentIndex],
                      ),
                      Positioned(
                        left: 60,
                        right: 60,
                        bottom: SizeConfig.blockSizeVertical * 2,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Completa los \ndatos de tu hijo",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 38, 65),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                                letterSpacing: -0.41786,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Podes agregar mas hijos con el botón de 'agregar otro'",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 118, 118, 118),
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  letterSpacing: -0.1,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 13,
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              child: _currentIndex == 0
                                  ? Icon(
                                      Icons.arrow_forward,
                                      color: Colors.transparent,
                                      size: 22,
                                    )
                                  : Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                              onTap: () => goBack(),
                            ),
                            SizedBox(width: 20),
                            Text(
                                (_currentIndex + 1).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(width: 20),
                            _currentIndex == hijos.length - 1?
                              _currentIndex == 0?
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.transparent,
                                  size: 22,
                                )
                                  :
                              GestureDetector(
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    onTap: () => borrarHijo(),
                                  )
                                : GestureDetector(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    onTap: () => goForward(),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 124,
                      height: 44,
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                      child: FlatButton(
                        color: AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Agregar otro",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () => agregarHijo(),
                      ),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                    ),
                    Container(
                      width: 124,
                      height: 44,
                      margin: EdgeInsets.only(right: 3, bottom: 10),
                      child: FlatButton(
                          color: AppColors.secondaryElement,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icons-back-light-2.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Finalizar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => siguienteBtn(context)),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    String errorMessagePlural = 'Los perfiles de los hijos : ';
    String errorMessageIndividual = 'El perfil del hijo : ';
    String genericErrorMessage = '';
    int cantErrores = 0;
    bool error = false;


    //fijarse si alguno de los hijos creados tiene algun campo incompleto
    for(int i = 0; i<=hijos.length-1 ; i++){
      if(!hijos[i].isComplete()){
        //aca hay que poner el pop up de que ese usuario esta mal
        error = true;
        cantErrores++;
        if(cantErrores >=2) {
          genericErrorMessage += ", ${i + 1} ";
        }else{
          genericErrorMessage += " ${i + 1}";
        }
      }
    }
    if(error == true){
      if(cantErrores> 1 ){
        errorMessagePlural += genericErrorMessage + " tienen campos que estan incompletos.";
        genericErrorMessage = errorMessagePlural;
      }else{
        errorMessageIndividual +=  genericErrorMessage + " tiene campos que estan incompletos.";
        genericErrorMessage = errorMessageIndividual;
      }
      //print("ERROR MESSAGE : " + genericErrorMessage);
      showErrorDialog(context, genericErrorMessage);

    }else{
      hijos.forEach((element) {widget.user.agregarHijo(element.toHijo());});
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TerminosYCondicionesWidget(widget.user)));
    }
  }

  agregarHijo() {
    hijos.add(ChildField(key: UniqueKey()));
    setState(() {
      _currentIndex = hijos.length - 1;
    });
  }

  borrarHijo(){
    setState(() {
      _currentIndex --;
    });

    hijos.removeLast();
  }

  goBack() {
    print("ATRAS BOTON");
    setState(() {
      _currentIndex > 0 ? _currentIndex-- : _currentIndex;
    });
  }

  goForward() {
    setState(() {
      _currentIndex < hijos.length - 1 ? _currentIndex++ : _currentIndex;
    });
  }
}

class ChildField extends StatefulWidget {
  ChildField({Key key}) : super(key: key);

  @override
  _ChildFieldState createState() => _ChildFieldState();

  String cursoSelectedValue;
  String colegioSelectedValue;
  TextEditingController nombreController = new TextEditingController();

  Hijo toHijo(){
    return Hijo(nombreController.text.trim(),colegioSelectedValue,cursoSelectedValue);
  }

  bool isComplete(){
    if(cursoSelectedValue != null && colegioSelectedValue != null && nombreController.text != null && nombreController.text.isNotEmpty){
      return true;
    }
    return false;
  }
}

class _ChildFieldState extends State<ChildField> {
  List<DropdownMenuItem> items = [];

  bool loadingDialogShown = false;

  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      items.add(new DropdownMenuItem(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    new Text(
                      'Colegio ' + i.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 38, 65),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        value: 'Colegio ' + i.toString(),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: BlocBuilder<ColegiosBloc, ColegiosBlocState>(
          builder: (context, state) {
            if (state is ColegiosLoading) {
              showLoadingDialog(context);
              loadingDialogShown = true;
              return CircularProgressIndicator();
            } else if (state is ColegiosLoaded) {
              if (loadingDialogShown) {
                Navigator.of(context).pop();
                loadingDialogShown = false;
              }
              return Column(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 60,
                    margin: EdgeInsets.only(
                        left: 100, right: 110, top: SizeConfig.blockSizeVertical * 3),
                    child: Opacity(
                      opacity: 0.57,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "NOMBRE",
                          contentPadding: EdgeInsets.only(top: 30),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 38, 65),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                        controller: widget.nombreController,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 180,
                    margin: EdgeInsets.only(left: 100, right: 100),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 45,
                    margin: EdgeInsets.only(
                        left: 110, right: 110, top: SizeConfig.blockSizeVertical * 4),
                    child: Opacity(
                      opacity: 0.37,
                      child: new DropdownButton(
                        icon: Icon(Icons.menu),
                        underline: Text(""),
                        items: createDropDownMenuList(state.colegiosData.colegios),
                        isExpanded: true,
                        value: widget.colegioSelectedValue,
                        hint: new Text(
                          'COLEGIO',
                          style: TextStyle(
                            color: Color.fromARGB(255, 53, 38, 65),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.colegioSelectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 180,
                    margin: EdgeInsets.only(left: 100, right: 100),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 45,
                    margin: EdgeInsets.only(
                        left: 110, right: 110, top: SizeConfig.blockSizeVertical * 4),
                    child: Opacity(
                      opacity: 0.37,
                      child: new DropdownButton(
                        icon: Icon(Icons.menu),
                        underline: Text(""),
                        items: createDropDownMenuList(state.colegiosData.cursos),
                        isExpanded: true,
                        value: widget.cursoSelectedValue,
                        hint: new Text(
                          'CURSO',
                          style: TextStyle(
                            color: Color.fromARGB(255, 53, 38, 65),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.cursoSelectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 180,
                    margin: EdgeInsets.only(left: 100, right: 100),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}

List<DropdownMenuItem> createDropDownMenuList(List<String> lista) {
  List<DropdownMenuItem> dropdownMenuItemList = [];
  for (String item in lista) {
    dropdownMenuItemList.add(DropdownMenuItem(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  new Text(
                    item,
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 38, 65),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ]),
      value: item,
    ));
  }
  return dropdownMenuItemList;
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}
