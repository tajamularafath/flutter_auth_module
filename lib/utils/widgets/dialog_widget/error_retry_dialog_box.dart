import 'package:authication_module/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/image_names.dart';
import '../../../core/utils/app_text_styles.dart';
import '../secondary_button_widget.dart';

class ErrorRetryDialogBox extends StatelessWidget {
  final String message;
  final VoidCallback onLogout;
  final VoidCallback onRetry;

  const ErrorRetryDialogBox({
    super.key,
    required this.message,
    required this.onLogout,
    required this.onRetry,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.permanentGeraniumLakeColor,
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        right: 20,
                        bottom: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: onLogout,
                    child: Text(
                      StringConstants.logoutLabel,
                      style: const TextStyle(
                        color: Colors.white,
                      ), // Optional, based on theme
                    ),
                  ),

                  const SizedBox(width: 12.0),
                  SecondaryButtonWidget(
                    text: StringConstants.retry,
                    onClick: onRetry,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
