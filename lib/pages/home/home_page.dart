import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_mask/pages/camera/camera.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadModel();
    super.initState();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/tflite/model_mask.tflite",
        labels: "assets/tflite/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Camera(widget.cameras);
  }
}
