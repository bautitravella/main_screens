import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/seleccion_cursos.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SubirFotoLibro extends StatefulWidget {
  @override
  SubirFotoLibroState createState() => SubirFotoLibroState();
}

class SubirFotoLibroState extends State<SubirFotoLibro> {
  List<File> _image = List(3);
  List<Asset> images = [];
  String _error;
//  void onBtnBlueTwoPressed(BuildContext context) {
//    Navigator.pop(context);
//  }



  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
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
                _imagesListBuilder(),
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
                    onPressed: () => _siguienteBtn()),
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

  _siguienteBtn() {
    //todo que se puedan seleccionar multiples imagenes
    //todo mostrar un error dilog si no hay como minimo 3 fotos subidas
    if (images.length <  3) {
      showErrorDialog(context,
          "Debes seleccionar como minimo 3 imagenes para poder continuar");
    } else {
      showLoadingDialog(context);
      Book book = Book();
      List<Future<ByteData>> futuresList = [];
      List<Future<ByteData>> futuresThumbsList = [];
      images.forEach((image) async{

        futuresList.add(image.getByteData());
        //List<int> imageData = byteData.buffer.asUint8List();

        futuresThumbsList.add(image.getThumbByteData(500, 500,quality: 50));

      });

      Future.wait([
        Future.wait(futuresList).then((value) => value.forEach((element) { book.imagesRaw.add(element.buffer.asUint8List());})),
        Future.wait(futuresThumbsList).then((value) => value.forEach((element) { book.imagesRawThumb.add(element.buffer.asUint8List());})),
      ]).then((value) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeleccionCursos(book),
          ),
        );
      });



    }
  }

  static Widget horizontalPhotos(Book book) {
    return Container(
      height: 185,
      margin: EdgeInsets.only(left: 22, top: 60),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: book.imagesUrl.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 180,
            width: 123,
            margin: EdgeInsets.only(right: 35),
            padding: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: book.getImages() != null && book.getImages().length > 0? //book.images[0],
              Image(
                image: book.getImages()[index],
              )
                  :
              CircularProgressIndicator(),

            ),
          );
        },
      ),
    );
  }

  _imagesListBuilder() {
    return images.length == 0
        ? Stack(
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
                        ]),
                    child: Text(''),
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
                        ]),
                    child: Text(''),
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
                  child: Text(''),
                ),
              ),
              Positioned(
                left: SizeConfig.blockSizeHorizontal * 38.5,
                top: SizeConfig.blockSizeVertical * 10,
                child: Container(
                  width: 90,
                  height: 90,
                  child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: _image[0] == null
                          ? Icon(
                              Icons.cloud_upload,
                              color: AppColors.secondaryBackground,
                              size: 60,
                            )
                          : Icon(
                              Icons.check,
                              color: AppColors.secondaryBackground,
                              size: 60,
                            ),
                      onPressed: () {
                        loadAssets();
                      }),
                ),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.only(left: 22, top: 0),
            //height: 295,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 22, top: 60),
                  height: 225,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 220,
                              padding: EdgeInsets.all(5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: AssetThumb(
                                    asset: images[index],
                                    height: 141,
                                    width: 140,
                                  ) //(book.images[index]),
                                  ),
                            ),
                            Container(
                               width: 55,
                               height: 55,
                               child: FlatButton(
                                   color: Colors.white54,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(100)),
                                   ),
                                   child: Icon(
                                     Icons.edit,
                                     color: Colors.white,
                                     size: 25,
                                   ),
                                   onPressed: () {
                                     loadAssets();
                                   }),
                             )
                          ],
                        ),
                      );
                    },
                  ),
                ),
               /* Row(mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                    RaisedButton(child: Text('Editar fotos elegidas'),onPressed: () => loadAssets()),
                ],
                )*/
              ],
            ));
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList = [];
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Widget _displayMainImage() {
    if (images.length == 0) {
      return Text("");
    } else {
      return images[0] == null
          ? Text("")
          : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: AssetThumb(
                asset: images[0],
                height: 1300,
                width: 1300,
              ));
    }
  }

  Widget _displaySecondImage() {
    return _image[0] == null
        ? Text("")
        : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.file(
              _image[0],
              fit: BoxFit.fill,
            ));
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
