import 'package:flutter/material.dart';
import 'package:ml_mask/core/core.dart';

class StatusImage extends StatelessWidget {
  const StatusImage({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          image: DecorationImage(
              image: AssetImage(index == 0 ? AppImages.check : AppImages.error),
              scale: 2)),
      height: 110,
      width: 110,
    );
  }
}
