import 'package:flutter/material.dart';
import 'package:ml_mask/pages/home/model/recognition.dart';
import 'package:ml_mask/pages/home/widget/status_image.dart';
import 'package:ml_mask/pages/home/widget/status_widget.dart';

class DetectInfo extends StatelessWidget {
  DetectInfo(this.recognition);
  final Recognition recognition;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [StatusImage(index: recognition.index!), Status(recognition)],
      ),
    );
  }
}
