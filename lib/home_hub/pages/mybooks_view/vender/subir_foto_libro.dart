import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/camera_example_home.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/datos_libro.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/seleccion_cursos.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/subir_libro/subir_foto_libro");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    BlocProvider.of<ColegiosBloc>(context).add(LoadColegios());
    return Scaffold(
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8, left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
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
                        "Subí 3 fotos",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Sube al menos tres fotos del libro que quieras vender.",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Es importante subir fotos de tus libros para que otros usuarios tengan una mejor experiencia al comprar.",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*5),
                _imagesListBuilder(),
                SizedBox(height: SizeConfig.blockSizeVertical*9),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8, bottom: 15),
                  child: FlatButton(
                    onPressed: () => _siguienteBtn(),
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

              ],
            ),
          ),
        ),
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
            builder: (context) => DatosLibros(book),
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
                  SizedBox(width: 10,),
                  Container(
                    width: SizeConfig.blockSizeHorizontal*40,
                    height: SizeConfig.blockSizeHorizontal*68,
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
                    width: SizeConfig.blockSizeHorizontal*40,
                    height: SizeConfig.blockSizeHorizontal*68,
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
                  SizedBox(width: 10,),
                ],
              ),
              Center(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal*45,
                  height: SizeConfig.blockSizeHorizontal*75,
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
                  child: Center(
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
                            /*loadAssets();*/
                            showOptionsDialog(context, "hola");
                          }),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(

            //height: 295,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*4.5),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: 141,
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

  void showOptionsDialog(BuildContext context, String errorMessage) {
    showSlideDialogChico(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  loadAssets();
                  Navigator.pop(context);
                },
                child: Container(
                  /*margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),*/
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
                          color: Theme.of(context).textTheme.headline4.color,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraExampleHome([]),
                    ),
                  );
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
                          color: Theme.of(context).textTheme.headline4.color,
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


