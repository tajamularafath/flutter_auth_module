import 'package:authication_module/constants/exception_message.dart';
import 'package:authication_module/constants/spacing.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/features/auth/presentation/provider/login_provider/login_provider.dart';
import 'package:authication_module/features/auth/presentation/provider/login_provider/login_state.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:authication_module/utils/dialog_box/show_dialog_box.dart';
import 'package:authication_module/utils/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/image_names.dart';
import '../../../../../utils/app_form_validation.dart';
import '../../../../../utils/widgets/auth_label_title_medium_widget.dart';
import '../../../../../utils/widgets/auth_widgets/auth_container_widget.dart';
import '../../../../../utils/widgets/auth_label_large_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Selector<LoginProvider, LoginState>(
      selector: (context, provider) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          /// Loading State
          if (provider.state == LoginState.loading) {
            ShowDialogBox.showLoadingDialog(context: context);
            provider.setState(state: LoginState.noAction);
          }

          /// Success State
          if (provider.state == LoginState.success) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesPathConstants.initialRoute,
                    (Route<dynamic> route) => false);
          }

          /// Error State
          if (provider.state == LoginState.error) {
            Navigator.of(context).pop();
            ShowDialogBox.showErrorDialog(
                context: context,
                message: provider.message ?? ExceptionMessage.unknownError,
                onClick: () {
                  Navigator.of(context).pop();
                }
            );
            provider.setState(state: LoginState.noAction);
          }
        });
        return provider.state;
      },
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: AuthContainerWidget(
            fillChild: Padding(
              padding: EdgeInsetsGeometry.only(
                left: Spacing.medium,
                right: Spacing.medium,
              ),
              child: Column(
                children: [
                  AuthLabelLargeWidget(label: StringConstants.login),
                  SizedBox(height: Spacing.extraSmall),
                  AuthLabelTitleMediumWidget(
                    label: StringConstants.loginDescription,
                  ),
                  SizedBox(height: 24),
                  AuthTextFieldWidget(
                    label: StringConstants.mobile,
                    hintText: StringConstants.enterMobile,
                    controller: provider.phoneController,
                    keyboardType: TextInputType.number,
                    prefixIconPath: ImageNames.iconMobile,
                    enabled: true,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        AppFormValidation.mobileValidation(value),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Spacing.medium),
                  SizedBox(height: Spacing.medium),
                  AuthTextFieldWidget(
                    label: StringConstants.password,
                    hintText: StringConstants.enterPassword,
                    controller: provider.passwordController,
                    prefixIconPath: ImageNames.iconPassword,
                    isPassword: true,
                    enabled: true,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: AppFormValidation.passwordFieldEmpty,
                    onChanged: (value) {},
                    keyboardType: TextInputType.text,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        debugPrint("Forget Password !");
                      },
                      child: Text("Forget Password"),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: (provider.isFormValid)
                        ? () {provider.login();}
                        : null,
                    child: Text(StringConstants.login),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
