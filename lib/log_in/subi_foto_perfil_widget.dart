import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/datos_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';


class SubiFotoPerfilWidget extends StatefulWidget {

  _SubiFotoPerfilWidgetState createState() => _SubiFotoPerfilWidgetState();

  User user;

  SubiFotoPerfilWidget(User this.user);

}

class _SubiFotoPerfilWidgetState extends State<SubiFotoPerfilWidget> {
  File _image;

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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: SizeConfig.blockSizeVertical*12),
                child: Text(
                  "Perfil",
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
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*6, bottom: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/phonochico.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      right: SizeConfig.blockSizeHorizontal*30,
                      top: SizeConfig.blockSizeVertical*10,
                      left: SizeConfig.blockSizeHorizontal*30,
                      height: 160,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/uploadimage.png",
                              fit: BoxFit.fill,
                            ),
                            Center(
                              child: FlatButton(
                                  color: Color.fromARGB(0, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                  ),
                                  textColor: Color.fromARGB(0, 0, 0, 0),
                                  child: _image == null
                                      ? Image.asset(
                                    "assets/images/logo.png",
                                    fit: BoxFit.none,
                                    alignment: Alignment.center,
                                  )
                                      : Container(
                                    height: 115,
                                    width: 115,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    selectImage();
                                  }

//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => DatosWidget(user)),
//                              );

                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 85, top: 85),
                                child:  _image == null
                                    ? Text("")
                                    : Container(
                                  width: 58,
                                  height: 58,
                                  child: Opacity(
                                    opacity: 1,
                                    child: FlatButton(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color.fromARGB(255, 254, 189, 16),
                                            width: 2,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(100)),
                                        ),
                                        textColor: Color.fromARGB(0, 0, 0, 0),
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/icons8-edit-96px-11.png",
                                              fit: BoxFit.none,
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          selectImage();
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    Positioned(
                      left:80,
                      right: 80,
                      bottom: SizeConfig.blockSizeVertical*5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Subí una foto",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Sf-r",
                              fontWeight: FontWeight.w700,
                              fontSize: 26,

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2,),
                            child: Text(
                              "Es importante subir una foto \nen la que salgas bien.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 163, 163, 163),
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                      _image == null
                  ? Text("")
                  : Container(
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
                                  "Siguiente",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Sf-r",
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
          ],
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    if(_image != null){
      widget.user.fotoPerfil = _image;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DatosWidget(widget.user)));
    }else{
      showErrorDialog(context, "Debe seleccionar una imagen para poder continuar");
    }

  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      //ratioX: 1.0,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    setState(() {
      _image = cropped ?? _image;
    });
  }

  void selectImage() {
    getImage().then((anything) => _cropImage());

  }
}


void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}
