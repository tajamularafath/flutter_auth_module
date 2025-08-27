import 'package:authication_module/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/image_names.dart';
import '../../../core/utils/app_text_styles.dart';

class ErrorDialogBox extends StatelessWidget {
  final String message;
  final VoidCallback onClick;

  const ErrorDialogBox({
    super.key,
    required this.message,
    required this.onClick,
  });

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
              const SvgPicture(
                SvgAssetLoader(ImageNames.error),
                height: 40,
                width: 40,
              ),
              const SizedBox(height: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyles().custom(
                  fontSize: 18.0,
                  color: AppColors.cetaceanBlueColor2,
                  context: context,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.permanentGeraniumLakeColor,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: onClick,
                child: Text(
                  StringConstants.ok,
                  style: const TextStyle(
                    color: Colors.white,
                  ), // Optional: add style
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
