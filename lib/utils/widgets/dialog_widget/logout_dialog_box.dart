import 'package:authication_module/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class LogoutDialogBox extends StatelessWidget {
  final VoidCallback onClickCancel;
  final VoidCallback onClickLogout;

  const LogoutDialogBox({
    super.key,
    required this.onClickCancel,
    required this.onClickLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      alignment: Alignment.center,
      title: Text(StringConstants.confirmLogout),
      content: Text(
        StringConstants.areYouWantToLogout,
      ),
      actions: [
        ElevatedButton(
          onPressed: onClickCancel,
          child: Text(StringConstants.cancel),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: onClickLogout,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: Text(StringConstants.logoutLabel),
        ),
      ],
    );
  }
}