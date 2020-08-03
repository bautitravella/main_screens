import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/blocs/colegios_bloc/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/registrar_info_usuario/curso_padre_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterui/log_in/registrar_info_usuario/padre_datos.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/log_in/registrar_info_usuario/alumno_datos.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';


import 'alumno_datos.dart';


class SubiFotoPerfilWidget extends StatefulWidget {

  _SubiFotoPerfilWidgetState createState() => _SubiFotoPerfilWidgetState();

  User user;

  SubiFotoPerfilWidget(User this.user);

}

class _SubiFotoPerfilWidgetState extends State<SubiFotoPerfilWidget> {
  File _image;
  List<String> imagesList=["assets/images/user_default_pic-14.png","assets/images/user_default_pic-15.png","assets/images/user_default_pic-16.png",
    "assets/images/user_default_pic-17.png","assets/images/user_default_pic-18.png","assets/images/user_default_pic-19.png"];

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/log_in/subi_foto_perfil");
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
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
                            showOptionsDialog(context, "hola");
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
                                    showOptionsDialog(context, "hola");
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
                child: GestureDetector(
                  onTap: () {
                    showProfilePicsDialog(context, "hola");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*10, vertical: SizeConfig.blockSizeVertical*2),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOptionsDialog(BuildContext context, String errorMessage) {
    showSlideDialogChico(
        context: context,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  selectImage();
                  Navigator.pop(context);
                },
                child: Container(
                 /* margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 213, 104),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.add_to_photos,
                            color: Colors.white,
                            size: 30,
                          )),
                      Text(
                        "Fotos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             /* SizedBox(width: 40),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 213, 104),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          )),
                      Text(
                        "Camara",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
        animatedPill: false);
  }
  void showProfilePicsDialog(BuildContext context, String errorMessage) {
    showSlideDialogGrande(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical*3),
            Text(
              "Elije un avatar",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical*6),
            Container(
              height: SizeConfig.blockSizeVertical*30,
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*10),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return  OmitirProfilePic(imagesList[index],selectAvatar);
                        },
                      childCount: 6,
                    ),
                  )
                ],
              )
            ),
          ],
        ),
       );
  }

  siguienteBtn(BuildContext context) {
    if(_image != null){
      widget.user.fotoPerfilRaw = _image;
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => widget.user is Padre? PadreDatos(widget.user):AlumnoDatos(widget.user))
      );
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

  void selectAvatar(String img_path){
    getImageFileFromAssets(img_path).then((value) => {
      setState(() {
    _image = value;
    })});

  }

  Future<File> getImageFileFromAssets(String path) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = directory.path + '/'+ "app.jpg";
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return await File(dbPath).writeAsBytes(bytes);


//    final byteData = await rootBundle.load('assets/$path');
//
//    final file = File('${(await getTemporaryDirectory()).path}/$path');
//    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//
//    return file;
  }

}

class OmitirProfilePic extends StatelessWidget{
  String img_path;
  Function(String) fn;

  OmitirProfilePic(this.img_path,this.fn);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        fn(img_path);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4),
        width: 62,
        height: 62,
        child: CircleAvatar(
          child: Image.asset(img_path),
        ),
      ),
    );
  }
}


void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}
