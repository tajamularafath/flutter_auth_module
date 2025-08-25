import 'package:authication_module/constants/spacing.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/utils/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/image_names.dart';
import '../../../../../utils/app_form_validation.dart';
import '../../../../../utils/widgets/auth_label_title_medium_widget.dart';
import '../../../../../utils/widgets/auth_widgets/auth_container_widget.dart';
import '../../../../../utils/widgets/auth_label_large_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

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
              AuthLabelTitleMediumWidget(label: StringConstants.loginDescription),
              SizedBox(height: 24),
              AuthTextFieldWidget(
                label: StringConstants.mobile,
                hintText: StringConstants.enterMobile,
                controller: phoneController,
                keyboardType: TextInputType.number,
                prefixIconPath: ImageNames.iconMobile,
                enabled: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator:
                    (value) => AppFormValidation.mobileValidation(value),
                onChanged: (value) {},
              ),
              SizedBox(height: Spacing.medium),
              SizedBox(height: Spacing.medium),
              AuthTextFieldWidget(
                label: StringConstants.password,
                hintText: StringConstants.enterPassword,
                controller: passwordController,
                prefixIconPath: ImageNames.iconPassword,
                isPassword: true,
                enabled: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: AppFormValidation.passwordFieldEmpty,
                onChanged: (value) {},
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
