import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/registrar_info_usuario/datos_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:provider/provider.dart';


class SubiFotoPerfilWidget extends StatefulWidget {

  _SubiFotoPerfilWidgetState createState() => _SubiFotoPerfilWidgetState();

  User user;

  SubiFotoPerfilWidget(User this.user);

}

class _SubiFotoPerfilWidgetState extends State<SubiFotoPerfilWidget> {
  File _image;

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/subi_foto_perfil");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
            body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8,left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
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
              Container(
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "¿Quieres subir \nuna foto?",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Podrás cambiarla mas tarde en la app.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*5),
              Center(
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/uploadimage.png"),
                      Image.asset(
                        "assets/images/phonochico.png",
                        fit: BoxFit.fill,
                      ),
                      FlatButton(
                          color: Color.fromARGB(0, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                          ),
                          textColor: Color.fromARGB(0, 0, 0, 0),
                          child: _image == null ?
                          Icon(
                            FontAwesome.cloud_upload,
                            color: Colors.white,
                            size: 60,
                              )
                             : Container(
                              height: 115,
                              width: 115,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(_image,
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
                                  color: Theme.of(context).focusColor,
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
                                      Icon(
                                        Icons.edit, size: 20, color: Color.fromARGB(255, 254, 189, 16),
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
              SizedBox(height: SizeConfig.blockSizeVertical*5),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8, bottom: SizeConfig.blockSizeVertical*5),
                  child: _image == null ?
                      Text(
                        "Saltar",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: "Sf-r",
                            fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                      :Container(
                        height: 50,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 15),
                        child: FlatButton(
                          onPressed: () => siguienteBtn(context),
                          /*color: Color.fromARGB(255, 222, 222, 222),*/
                          color: AppColors.secondaryBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              "Continuar",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    if(_image != null){
      widget.user.fotoPerfilRaw = _image;
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
