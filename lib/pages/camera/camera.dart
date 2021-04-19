import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ml_mask/pages/home/model/recognition.dart';
import 'package:ml_mask/pages/home/widget/detect_info.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class Camera extends StatefulWidget {
  final List<CameraDescription>? cameras;

  Camera(this.cameras);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController? controller;
  bool isDetecting = false;

  Recognition recognition =
      Recognition(confidence: 0.0, index: 0, label: '  Loading');

  setRecognitions(List recognitions) {
    if (recognitions.isNotEmpty)
      setState(() {
        recognition =
            Recognition.fromJson(Map<String, dynamic>.from(recognitions.first));
      });
  }

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras!.length < 1) {
      print('No camera is found');
    } else {
      controller = CameraController(
        widget.cameras![0],
        ResolutionPreset.high,
      );
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller!.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
            Tflite.runModelOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              numResults: 1,
            ).then((recognitions) {
              setRecognitions(recognitions!);
              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return Stack(
      children: [
        OverflowBox(
          maxHeight: screenRatio > previewRatio
              ? screenH
              : screenW / previewW * previewH,
          maxWidth: screenRatio > previewRatio
              ? screenH / previewH * previewW
              : screenW,
          child: CameraPreview(controller!),
        ),
        Positioned(bottom: 1, right: 1, left: 1, child: DetectInfo(recognition))
      ],
    );
  }
}
