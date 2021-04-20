import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ml_mask/pages/home/model/recognition.dart';
import 'package:ml_mask/pages/home/widget/detect_info.dart';
import 'package:tflite/tflite.dart';

class Camera extends StatefulWidget {
  final List<CameraDescription>? cameras;

  Camera(this.cameras);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController? controller;
  bool isDetecting = false;
  int cameraSelected = 0;

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
          widget.cameras![cameraSelected], ResolutionPreset.high,
          enableAudio: false);
      initRecord();
    }
  }

  void initRecord() {
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

  Future<void> stopRecord() async {
    await controller!.stopImageStream();
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

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.switch_camera_outlined),
          onPressed: () async {
            if (widget.cameras != null || widget.cameras!.isNotEmpty) {
              await stopRecord();
              if (cameraSelected == widget.cameras!.length - 1) {
                cameraSelected = 0;
              } else {
                cameraSelected++;
              }
              setState(() {
                controller = CameraController(
                    widget.cameras![cameraSelected], ResolutionPreset.high,
                    enableAudio: false);
              });
              initRecord();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          OverflowBox(
            child: CameraPreview(controller!),
          ),
          Positioned(
              bottom: 1, right: 1, left: 1, child: DetectInfo(recognition))
        ],
      ),
    );
  }
}
