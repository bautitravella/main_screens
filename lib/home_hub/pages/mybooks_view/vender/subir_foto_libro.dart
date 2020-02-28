import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/seleccion_cursos.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:path_provider/path_provider.dart';

class SubirFotoLibro extends StatefulWidget {

  @override
  SubirFotoLibroState createState() => SubirFotoLibroState();
}


class SubirFotoLibroState extends State<SubirFotoLibro>{

  List<File> _image = List(3);

//  void onBtnBlueTwoPressed(BuildContext context) {
//    Navigator.pop(context);
//  }


  Widget _displayImage() {
    return _image[0] == null?
    Image(
      image: AssetImage(
          "assets/images/bookdescarte.png"
      ),
      fit: BoxFit.fill,
    )
        :
    Image.file(_image[0],fit: BoxFit.fill,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
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
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 46,
                  margin: EdgeInsets.only(
                      left: 28,
                      top: 24,
                      bottom: SizeConfig.blockSizeVertical * 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
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
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 161,
                            height: 215,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 143, 143, 143),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ]
                            ),
                            child:  _displayImage(),
                        ),
                        Container(
                            width: 161,
                            height: 215,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 143, 143, 143),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ]
                            ),
                            child: _displayImage()
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                          width: 161,
                          height: 244,
                          padding: EdgeInsets.only(top: 0),
                          margin: EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ]),
                          child: _displayImage()
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.blockSizeHorizontal*38.5,
                      top: SizeConfig.blockSizeVertical*10,
                      child: Container(
                        width: 90,
                        height: 90,
                        child:FlatButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppColors.secondaryBackground,
                              size: 60,
                            ),
                            onPressed: () {selectImage();}
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      "Subí 3 fotos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        letterSpacing: -0.41786,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Es importante subir fotos de tus libros \npara que otros usuarios tengan \nuna mejor experiencia al comprar.",
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
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Align(
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
                    onPressed: () =>
                      _siguienteBtn()

                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image[0] = image;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image[0].path,
      //ratioX: 1.0,
      aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 3),
    );

    setState(() {
      _image[0] = cropped ?? _image[0];
    });
//    final directory = await getApplicationDocumentsDirectory();
//    File croppedImage = await File(directory.path);
//    var result = await FlutterImageCompress.compressAndGetFile(
//      _image[0].path, croppedImage.path,
//      quality: 1,
//
//    );
//
//
//    setState(() {
//      _image[0] = result;
//    });

  }

  void selectImage() {
    getImage().then((anything) => _cropImage());

  }

  _siguienteBtn(){
    //todo que se puedan seleccionar multiples imagenes
    //todo mostrar un error dilog si no hay como minimo 3 fotos subidas
    if(_image[0] == null){
      showErrorDialog(context, "Debes seleccionar como minimo 3 imagenes para poder continuar");
    }else{
      Book book = Book();

      book.imagesRaw.add(_image[0]);
      book.imagesRaw.add(_image[0]);
      book.imagesRaw.add(_image[0]);


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SeleccionCursos(book),
        ),
      );
    }


  }

}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(context: context, child: LoadingDialog(),animatedPill: true,barrierDismissible: false);
}
void showErrorDialog(BuildContext context,String errorMessage){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: errorMessage,),
      animatedPill: false);
}