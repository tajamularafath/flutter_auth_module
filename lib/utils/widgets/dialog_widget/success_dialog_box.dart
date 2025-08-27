import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/image_names.dart';
import '../../../core/utils/app_text_styles.dart';

class SuccessDialogBox extends StatelessWidget {
  final String message;
  final VoidCallback onClick;

  const SuccessDialogBox({
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              SvgPicture.asset(
                ImageNames.success,  // Just pass the asset path string here
                height: 40,
                width: 40,
                // color: Colors.green,
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
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: onClick,
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }
}
