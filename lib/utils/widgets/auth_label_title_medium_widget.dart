import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/fonts_weight.dart';


class AuthLabelTitleMediumWidget extends StatelessWidget {
  final String label;

  const AuthLabelTitleMediumWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.spanishGray,
          fontWeight: AppFontsWeight.fontWeightRegular,
        ),
      ),
    );
  }
}
