import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/seleccion_materia.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:provider/provider.dart';

class SeleccionCursos extends StatefulWidget {
  Book book;
  SeleccionCursos(this.book);

  @override
  _SeleccionCursosState createState() => _SeleccionCursosState();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _SeleccionCursosState extends State<SeleccionCursos> {
  bool _isChecked = false;

  bool loadingDialogShown = false;

  bool valuesHasBeenCreated = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  Map<String, bool> values = {"holis":true};

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/subir_libro/seleccion_cursos");
    super.initState();
  }
//  = {
//    '1er grado': false,
//    '2do grado': false,
//    '3er grado': false,
//    '4to grado': false,
//    '5to grado': false,
//    '6to grado': false,
//    '7mo grado': false,
//    '1er año': false,
//    '2do año': false,
//    '3er año': false,
//    '4to año': false,
//    '5to año': false,
//    '6to año': false,
//    '7mo año': false,
//  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30.0,
                        color: AppColors.accentText,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ), //BOTON DE IR PARA  ATRAS
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 24),
                child: Text(
                  "Vender",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Gibson",
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w600,
                    fontSize: 38,
                  ),
                ),
              ),
            ), // TEXTO DE "VENDER"
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/phonochico.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: 215,
                      height: 305,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 25, bottom: 15),
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
                          if(valuesHasBeenCreated == false) {
                            values = createMapfromStringsList(
                                state.colegiosData.cursos);
                            valuesHasBeenCreated = true;
                          }
                          return ListView(
                            children: values.keys.map((String key) {
                              return Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                    title: new Text(
                                      key,
                                      style: TextStyle(
                                          fontFamily: "Gibson",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 69, 79, 99)),
                                    ),
                                    value: values[key],
                                    onChanged: (bool value) {
                                      _changeValuesValue(value,key);
//                                      setState(() {
//                                        values[key] = value;
//                                      });
                                    },
                                  ),
                                  Container(
                                    width: 180,
                                    height: 2,
                                    color: Colors.black12,
                                  )
                                ],
                              );
                            }).toList(),
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Text(
                "Seleccioná los \ncursos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 38, 65),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  letterSpacing: -0.41786,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 35),
              child: Text(
                "Selecciona los cursos que pueden estar \ninteresados en comprar este libro.",
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 124,
                height: 44,
                margin: EdgeInsets.only(right: 3, bottom: 30),
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
                          "Siguiente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => _siguienteBtn()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _siguienteBtn() {
    bool canContinue = false;
    values.forEach((key, value) {
      value ? canContinue = true : value;
    });

    if (canContinue) {
      for (String key in values.keys) {
        if (values[key]) {
          widget.book.cursos.add(key);
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SeleccionMateria(widget.book)),
      );
    } else {
      showErrorDialog(
          context, "Debes seleccionar al menos un curso para poder continuar");
    }
  }

  void _changeValuesValue(bool value, String key) {
    setState(() {
      values[key] = value;
    });
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

Map<String, bool> createMapfromStringsList(List<String> stringsList) {
  Map<String, bool> map = Map();
  for (String item in stringsList) {
    map[item] = false;
  }
  return map;
}


