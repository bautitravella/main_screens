import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/datos_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';


class SubiFotoPerfilWidget extends StatefulWidget {
  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

  _SubiFotoPerfilWidgetState createState() => _SubiFotoPerfilWidgetState(user);

  User user;

  SubiFotoPerfilWidget(User this.user);

}

class _SubiFotoPerfilWidgetState extends State<SubiFotoPerfilWidget> {
  File _image;
  User user;

  _SubiFotoPerfilWidgetState(this.user);

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
                margin: EdgeInsets.only(left: 28, top: 85),
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
                margin: EdgeInsets.only(top: 39, bottom: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 92,
                      right: 91,
                      bottom: 0,
                      child: Text(
                        "Subí una foto",
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
                      left: 103,
                      top: 50,
                      right: 103,
                      bottom: 50,
                      child: Image.asset(
                        "assets/images/uploadimage.png",
                        fit: BoxFit.none,
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 160,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 33, bottom: 33),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            textColor: Color.fromARGB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _image == null
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
                              ],
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
                    ),
                    _image == null
                        ? Text("")
                        : Container(
                            width: 58,
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 90, top: 110, bottom: 33),
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
                          )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
              child: Text(
                "Es importante subir una foto \nen la que salgas bien.\n",
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
              child: _image == null
                  ? Text("")
                  : Container(
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
                          onPressed: () => siguienteBtn(context)),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    if(_image != null){
      user.fotoPerfil = _image;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DatosWidget(user)));
    }else{
      //Mostrar un mensaje de error
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
