import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/values/values.dart';

class TerminosYCondicionesWidget extends StatelessWidget {
  void onButtonsLargeGreenPressed(BuildContext context) {}

  User user;
  TerminosYCondicionesWidget(this.user);

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
                margin: EdgeInsets.only(left: 25, top: 85),
                child: Text(
                  "Terminos y\nCondiciones",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                    height: 1.26316,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin:
                    EdgeInsets.only(left: 28, top: 20, right: 28, bottom: 19),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 48,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 64),
                              child: Text(
                                "Articulo 1",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, right: 17),
                              child: Text(
                                "Para quien use los servicios",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 10, right: 3),
                              child: Text(
                                "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 120, 132, 158),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 1.38462,
                                ),
                              ),
                            ),
                            Container(
                              height: 206,
                              margin:
                                  EdgeInsets.only(left: 57, top: 18, right: 6),
                              child: Text(
                                "• Step 1: You may use the Services only if you agree to form a binding contract with us and are not a person barred from receiving services under the laws of the applicable jurisdiction. \n\n• Step 2: Our Privacy Policy describes how we handle the information you provide to us when you use our Services.",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 1.38462,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 10, right: 160),
                              child: Text(
                                "Privacidad",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                              margin:
                                  EdgeInsets.only(left: 0, top: 10, right: 3),
                              child: Text(
                                "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 120, 132, 158),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 4,
                      right: 3,
                      bottom: 0,
                      height: 53,
                      child: FlatButton(
                        onPressed: () => siguienteBtn(context),
                        color: AppColors.secondaryElement,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "ACEPTAR Y CONTINUAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("hola crack"),
            content: CircularProgressIndicator(),
          );
        });
    Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
    uploadData().then((smt) => {
          print("PASANDO A LA PROXIMA PANTALLA"),
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeHub())),
        });
  }

  Future uploadData() {
    int amountOfTryouts = 0;
    return uploadImage()
        .then((downloadUrl) => {
              uploadUserInformation(downloadUrl),
              print("DOWNLOAD URL  2: " + downloadUrl),
            })
        .catchError((err) {
      print("HUBO UN ERROR 1, " + err);
    });
  }

  Future<String> uploadImage() async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("agustinTormakhFotardas");
    StorageUploadTask uploadTask = ref.putFile(user.fotoPerfil);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
        (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
  }

  uploadUserInformation(String downloadUrl) {
    Firestore.instance
        .collection('Users')
        .document(user.email)
        .setData({"nombre": "Agustint", "apellido": "Tormakhiano"})
        .then((value) => print("se mando bien la info a firebase" ))
        .catchError((err) => print("HUBO UN ERROR 2"));
  }
}
