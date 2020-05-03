import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/values/colors.dart';

class TestFotoDePerfil extends StatefulWidget {
  @override
  _TestFotoDePerfilState createState() => _TestFotoDePerfilState();
}

class _TestFotoDePerfilState extends State<TestFotoDePerfil> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
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
                      "Ingresa tus datos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Podrás cambiarla mas tarde en la app.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Text(
                  "Nombre",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  /*controller: nombreController,*/
                  textCapitalization: TextCapitalization.words,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,//REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "Apellido",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  /*controller: apellidoController,*/
                  textCapitalization: TextCapitalization.words,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,//REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
               /* BlocBuilder<ColegiosBloc, ColegiosBlocState>(
                  builder: (context, state) {
                    if (state is ColegiosLoading) {
                      //showLoadingDialog(context);
                      loadingDialogShown = true;
                      return CircularProgressIndicator();
                    } else if (state is ColegiosLoaded) {
                      if (loadingDialogShown) {
                        Navigator.of(context).pop();
                        loadingDialogShown = false;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Colegio",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          BeautyDropDown(
                            width: double.maxFinite, //REQUIRED
                            height: 50, //REQUIRED
                            accentColor: Colors.white, // On Focus Color//Text Color
                            backgroundColor: Theme.of(context).hintColor,
                            margin: EdgeInsets.only(top: 10),
                            cornerRadius: BorderRadius.all(Radius.circular(15)),
                            duration: Duration(milliseconds: 300),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            item: createDropDownMenuListColegios(state.colegiosData.colegios),
                            isExpanded: true,
                            value: colegioSelectedValue,
                            onChanged: (value) {
                              if (value == "+ Agregar Colegio") {
                                showSchoolDialog(context, widget.user.email);
                              } else {
                                setState(() {
                                  colegioSelectedValue = value;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Curso",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          BeautyDropDown(
                            width: double.maxFinite, //REQUIRED
                            height: 50, //REQUIRED
                            accentColor: Colors.white, // On Focus Color//Text Color
                            backgroundColor: Theme.of(context).hintColor,
                            margin: EdgeInsets.only(top: 10),
                            cornerRadius: BorderRadius.all(Radius.circular(15)),
                            duration: Duration(milliseconds: 300),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            item: createDropDownMenuList(state.colegiosData.cursos),
                            isExpanded: true,
                            value: cursoSelectedValue,
                            onChanged: (value) {
                              setState(() {
                                cursoSelectedValue = value;
                              });
                            },
                          ),

                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),*/
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ingresa los datos de tus hijos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Puedes ir agregando hijos con el signo ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.maxFinite,
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height: 70, width: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text("1", style: Theme.of(context).textTheme.headline1,),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 70, width: 70,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 191, 131),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 70, width: 70,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 217, 86, 86),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(Icons.delete, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nombre",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    BeautyTextfield(
                      /*controller: nombreController,*/
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Colegio",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  /*  BeautyDropDown(
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      item: createDropDownMenuListColegios(state.colegiosData.colegios),
                      isExpanded: true,
                      value: colegioSelectedValue,
                      onChanged: (value) {
                        if (value == "+ Agregar Colegio") {
                          showSchoolDialog(context, widget.user.email);
                        } else {
                          setState(() {
                            colegioSelectedValue = value;
                          });
                        }
                      },
                    ),*/
                    BeautyTextfield(
                      /*controller: nombreController,*/
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Curso",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                   /* BeautyDropDown(
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      item: createDropDownMenuList(state.colegiosData.cursos),
                      isExpanded: true,
                      value: cursoSelectedValue,
                      onChanged: (value) {
                        setState(() {
                          cursoSelectedValue = value;
                        });
                      },
                    ),*/
                    BeautyTextfield(
                      /*controller: nombreController,*/
                      textCapitalization: TextCapitalization.words,
                      width: double.maxFinite, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');
                      },
                      onChanged: (text) {
                        print(text);
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                  ],
                ),

                SizedBox(height: SizeConfig.blockSizeVertical*9),
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
