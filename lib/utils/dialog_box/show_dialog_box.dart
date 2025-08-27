import 'package:flutter/material.dart';

import '../widgets/dialog_widget/error_dialog_box.dart';
import '../widgets/dialog_widget/error_retry_dialog_box.dart';
import '../widgets/dialog_widget/loding_dialog_box.dart';
import '../widgets/dialog_widget/logout_dialog_box.dart';
import '../widgets/dialog_widget/success_dialog_box.dart';

class ShowDialogBox {
  /// show loading dialog box
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? message,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder:
          (BuildContext context) => PopScope(
            canPop: false,
            child: LoadingDialogBox(message: message),
          ),
    );
  }

  /// show error dialog box
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onClick,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder:
          (BuildContext context) => PopScope(
            canPop: false,
            child: ErrorDialogBox(message: message, onClick: onClick),
          ),
    );
  }

  /// show error dialog box
  static Future<void> showErrorRetryDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onLogout,
    required VoidCallback onRetry,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder:
          (BuildContext context) => PopScope(
            canPop: false,
            child: ErrorRetryDialogBox(
              message: message,
              onLogout: onLogout,
              onRetry: onRetry,
            ),
          ),
    );
  }

  /// show success dialog box
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onClick,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          PopScope(
            canPop: false,
            child: SuccessDialogBox(message: message, onClick: onClick),
          ),
    );
  }

  /// show logout dialog box
  static Future<void> showLogoutDialog({
    required BuildContext context,
    required VoidCallback onClickCancel,
    required VoidCallback onClickLogout,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          PopScope(
            canPop: false,
            child: LogoutDialogBox(onClickCancel: onClickCancel,onClickLogout: onClickLogout),
          ),
    );
  }
}
