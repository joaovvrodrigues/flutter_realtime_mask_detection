import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_mask/pages/home/home_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget({required this.cameras});

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "ML - Mask Detection",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: SafeArea(child: HomePage(cameras)),
    );
  }
}
