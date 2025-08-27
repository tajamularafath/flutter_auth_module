import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../core/utils/app_text_styles.dart';

class SecondaryButtonWidget extends StatelessWidget{

  final String text;
  final VoidCallback onClick;

  const SecondaryButtonWidget({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onClick,
        style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.red[100]),
            side: const WidgetStatePropertyAll(BorderSide(
                color: AppColors.permanentGeraniumLakeColor,
                width: 1.0,
                style: BorderStyle.solid)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)))),
        child: Text(text,
            style: TextStyles().subtitleText1(
                context: context,
                color: AppColors.permanentGeraniumLakeColor,
                fontWeight: FontWeight.w600)));
  }
}