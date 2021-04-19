import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'core/app_widget.dart';

late List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(AppWidget(cameras: cameras));
}
