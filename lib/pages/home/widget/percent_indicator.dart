import 'package:flutter/material.dart';
import 'package:ml_mask/core/core.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator(
    this.confidence, {
    Key? key,
  }) : super(key: key);

  final double confidence;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: LinearPercentIndicator(
        width: 230,
        animation: false,
        lineHeight: 20.0,
        percent: confidence,
        center: Text("${(confidence * 100).toStringAsFixed(2)}%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: AppColors.lightGreen,
      ),
    );
  }
}
