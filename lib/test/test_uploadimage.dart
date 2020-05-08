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
  bool _newBookCheckBox = false;
  bool _universidadCheckBox = false;
  bool _colegioCheckBox = false;

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
                          "Subir libro",
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
                      "Ingresa los datos",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Asegúrate de escribir correctamente los datos del libro que vallas a vender.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Text(
                  "*Nombre",
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
                  "*Autor",
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
                Text(
                  "*Editorial",
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
                Text(
                  "ISBN",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Descripción ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Escribe una breve descripción del  estado del libro que vallas a vender.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child:  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintStyle:TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontFamily: "Sf",
                        fontWeight: FontWeight.w700,
                      ),
                      hintText: "*DESCRIPCIÓN",
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.headline3,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: AppColors.secondaryBackground,
                    autocorrect: true,
                  ),
                ),
                SizedBox(height: 40),
                FlatButton(
                  splashColor: Theme.of(context).backgroundColor,
                  onPressed: () {
                    setState(() {
                      _newBookCheckBox =  !_newBookCheckBox;
                    });
                    print('Click');
                  },
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '¿Es nuevo el libro?',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(width: 30),
                      Center(
                        child: Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                            color: _newBookCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                            borderRadius:  BorderRadius.circular(5.0),
                          ),
                          child: Center(child: Icon(_newBookCheckBox? Icons.done: null, color: Colors.white, size: 17)
                          ),
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
                      "¿Donde lo publicaras?",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Los podrás vender en todos los lugares que tengas habilitados.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                FlatButton(
                  splashColor: Theme.of(context).backgroundColor,
                  onPressed: () {
                    setState(() {
                      _colegioCheckBox =  !_colegioCheckBox;
                    });
                    print('Click');
                  },
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal*50,
                        padding: EdgeInsets.only(left: 20, right: 4, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withAlpha(60),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Opacity(
                            opacity: _colegioCheckBox? 1 : 0.2,
                            child: Text("Colegio", style: Theme.of(context).textTheme.headline2,)),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*15),
                      Center(
                        child: Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                            color: _colegioCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                            borderRadius:  BorderRadius.circular(5.0),
                          ),
                          child: Center(child: Icon(_colegioCheckBox? Icons.done: null, color: Colors.white, size: 17)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _colegioCheckBox
                 ?Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      "Colegio",
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
                      "Año",
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
                    Text(
                      "Materia",
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
                  ],
                )
                 :Container(),
                SizedBox(height: 30),
                FlatButton(
                  splashColor: Theme.of(context).backgroundColor,
                  onPressed: () {
                    setState(() {
                      _universidadCheckBox =  !_universidadCheckBox;
                    });
                    print('Click');
                  },
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal*50,
                        padding: EdgeInsets.only(left: 20, right: 4, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withAlpha(60),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Opacity(
                          opacity: _universidadCheckBox? 1 : 0.2,
                            child: Text("Universidad", style: Theme.of(context).textTheme.headline2,)),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*15),
                      Center(
                        child: Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                            color: _universidadCheckBox? AppColors.secondaryBackground : Theme.of(context).hintColor,
                            borderRadius:  BorderRadius.circular(5.0),
                          ),
                          child: Center(child: Icon(_universidadCheckBox? Icons.done: null, color: Colors.white, size: 17)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _universidadCheckBox
                    ?Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      "Universidad",
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
                      "Carrera",
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
                    Text(
                      "Año",
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
                  ],
                )
                    :Container(),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ponle un precio",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Cuanto mas bajo sea el precio mas fácil te sera venderlo",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 60.0,
                      color: Color.fromARGB(255, 112, 112, 112),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal*60,
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withAlpha(60),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: "PRECIO",
                          hintStyle: TextStyle(
                            fontFamily: "Sf-r",
                            color: Color.fromARGB(20, 0, 0, 0),
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 112, 112, 112),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                        keyboardType: TextInputType.number,
                      ),
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
