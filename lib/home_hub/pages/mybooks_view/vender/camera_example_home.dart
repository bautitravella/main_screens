import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraExampleHome extends StatefulWidget {
  List<String> imagePaths;

  CameraExampleHome(this.imagePaths);

  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraExampleHomeState extends State<CameraExampleHome>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;
  int cameraIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
  }

  initializeCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
      onNewCameraSelected(cameras[0]);
      cameraIndex = 0;
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Camera example'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              ),
            ),

          _captureControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cameraTogglesRowWidget(),
                _thumbnailWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

//  /// Toggle recording audio
//  Widget _toggleAudioWidget() {
//    return Padding(
//      padding: const EdgeInsets.only(left: 25),
//      child: Row(
//        children: <Widget>[
//          const Text('Enable Audio:'),
//          Switch(
//            value: enableAudio,
//            onChanged: (bool value) {
//              enableAudio = value;
//              if (controller != null) {
//                onNewCameraSelected(controller.description);
//              }
//            },
//          ),
//        ],
//      ),
//    );
//  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 64,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imagePaths.length,
                  itemBuilder: (BuildContext context, int index){
                    return SizedBox(
                              child: Image.file(File(widget.imagePaths[index])),width: 64.0,height: 64.0,);
                  }),
            ),
//            SizedBox(
//              child: (videoController == null)
//                  ? Image.file(File(imagePath))
//                  : Container(
//                child: Center(
//                  child: AspectRatio(
//                      aspectRatio:
//                      videoController.value.size != null
//                          ? videoController.value.aspectRatio
//                          : 1.0,
//                      child: VideoPlayer(videoController)),
//                ),
//                decoration: BoxDecoration(
//                    border: Border.all(color: Colors.pink)),
//              ),
//              width: 64.0,
//              height: 64.0,
//            ),
          ],
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.yellow,
          onPressed: controller != null &&
              controller.value.isInitialized &&
              !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),



      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {

      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }
    return RaisedButton(child:Text("Change Camera"),onPressed: (){
      if(cameraIndex>= cameras.length){
        cameraIndex = 0;
        onNewCameraSelected(cameras[cameraIndex]);
      }else{
        cameraIndex++;
        onNewCameraSelected(cameras[cameraIndex]);
      }
    },);

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        widget.imagePaths.add(filePath);
        print("PATHS LIST = " + widget.imagePaths.toString());
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
//        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
//
//class CameraApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: CameraExampleHome([]),
//    );
//  }
//}

List<CameraDescription> cameras = [];

//Future<void> main() async {
//  // Fetch the available cameras before initializing the app.
//  try {
//    WidgetsFlutterBinding.ensureInitialized();
//    cameras = await availableCameras();
//  } on CameraException catch (e) {
//    logError(e.code, e.description);
//  }
//  runApp(CameraApp());
//}