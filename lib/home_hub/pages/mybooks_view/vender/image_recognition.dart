
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageRecognition extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return ImageRecognitionState();
  }


}

class ImageRecognitionState extends State<ImageRecognition>{

  bool _isDetecting = false;

  VisionText _textScanResults;

  CameraLensDirection _direction = CameraLensDirection.back;

  CameraController _camera;

  final TextRecognizer _textRecognizer =
  FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
    await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      setState(() {
        _isDetecting = true;
      });
      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
            (results) {
          setState(() {
            if (results != null) {
              setState(() {
                _textScanResults = results;
              });
            }
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _camera == null
              ? Container(
            color: Colors.black,
          )
              : Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 150,
              child: CameraPreview(_camera)),
          _buildResults(_textScanResults),
        ],
      ),
    );
  }

  Widget _buildResults(VisionText scanResults) {
    CustomPainter painter;
    if (scanResults != null) {
      final Size imageSize = Size(
        _camera.value.previewSize.height - 100,
        _camera.value.previewSize.width,
      );
      painter = TextDetectorPainter(imageSize, scanResults);
      //getWords(scanResults);

      return CustomPaint(
        painter: painter,
      );
    } else {
      return Container();
    }
  }



}







class ScannerUtils {
  ScannerUtils._();

  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
          (List<CameraDescription> cameras) => cameras.firstWhere(
            (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  static Future<dynamic> detect({
    @required CameraImage image,
    @required Future<dynamic> Function(FirebaseVisionImage image) detectInImage,
    @required int imageRotation,
  }) async {
    return detectInImage(
      FirebaseVisionImage.fromBytes(
        _concatenatePlanes(image.planes),
        _buildMetaData(image, _rotationIntToImageRotation(imageRotation)),
      ),
    );
  }

  static Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static FirebaseVisionImageMetadata _buildMetaData(CameraImage image, ImageRotation rotation,) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
            (Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  static ImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }
}

class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.visionText);

  final Size absoluteImageSize;
  final VisionText visionText;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          paint.color = Colors.green;
          canvas.drawRect(scaleRect(element), paint);
        }

        paint.color = Colors.yellow;
        canvas.drawRect(scaleRect(line), paint);
      }

      paint.color = Colors.red;
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionText != visionText;
  }
}