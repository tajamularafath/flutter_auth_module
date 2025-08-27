

import 'package:authication_module/constants/app_colors.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/app_text_styles.dart';

class LoadingDialogBox extends StatelessWidget {
  final String? message;

  const LoadingDialogBox({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      backgroundColor: AppColors.whiteColor,
      actions: <Widget>[
        Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              LoadingAnimationWidget.inkDrop(
                color: AppColors.primary,
                size: 25,
                //color: AppColor.cetaceanBlueColor2,
                //secondRingColor: AppColor.permanentGeraniumLakeColor,
                //thirdRingColor: AppColor.permanentGeraniumLakeColor,
              ),
              const SizedBox(height: 25),
              Text(
                message ?? StringConstants.loading,
                style: TextStyles().subtitleText2(
                  color: AppColors.cetaceanBlueColor2,
                  context: context,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
