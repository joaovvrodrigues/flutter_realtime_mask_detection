import 'package:flutter/material.dart';
import 'package:ml_mask/core/core.dart';

class StatusText extends StatelessWidget {
  const StatusText(
    this.label, {
    Key? key,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      height: 80,
      width: 230,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label.substring(2), style: AppTextStyles.titleBold),
            Text('Confiança:', style: AppTextStyles.title),
          ],
        ),
      ),
    );
  }
}
