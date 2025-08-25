import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/fonts_weight.dart';

class AuthLabelLargeWidget extends StatelessWidget {
  final String label;

  const AuthLabelLargeWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.raisinBlack,
          fontWeight: AppFontsWeight.fontWeightBold,
        ),
      ),
    );
  }
}
