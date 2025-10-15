import 'package:authication_module/constants/exception_message.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/features/auth/presentation/provider/register_provider/register_provider.dart';
import 'package:authication_module/features/auth/presentation/provider/register_provider/register_state.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:authication_module/utils/dialog_box/show_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/image_names.dart';
import '../../../../../constants/spacing.dart';
import '../../../../../utils/app_form_validation.dart';
import '../../../../../utils/widgets/auth_label_large_widget.dart';
import '../../../../../utils/widgets/auth_label_title_medium_widget.dart';
import '../../../../../utils/widgets/auth_text_field_widget.dart';
import '../../../../../utils/widgets/auth_widgets/auth_container_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Selector<RegisterProvider, RegisterState>(
      selector: (context, provider) => provider.state,
      builder: (context, state, child) {
        final provider = context.read<RegisterProvider>();

        /// Handle side-effects after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          /// Loading State
          if (state == RegisterState.loading) {
            ShowDialogBox.showLoadingDialog(context: context);
          }
          /// Error State
          else if (state == RegisterState.error) {
            Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
            ShowDialogBox.showErrorDialog(
              context: context,
              message: provider.message ?? ExceptionMessage.unknownError,
              onClick: () {
                Navigator.of(context).pop(); // Dismiss error dialog
                provider.resetForm();
              },
            );
          }
          /// Success State
          else if (state == RegisterState.success) {
            Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
            Navigator.of(context).pushNamed(RoutesPathConstants.loginRoute);
            provider.resetForm(); // Clear form and state
          }
        });

        // 🟢 Return your actual UI
        return AuthContainerWidget(
          onBackPressed: () => Navigator.pop(context),
          child: SingleChildScrollView(
            child: Form(
              key: registerProvider.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AuthLabelLargeWidget(
                      label: StringConstants.createNewAccount,
                    ),
                    SizedBox(height: 4),
                    AuthLabelTitleMediumWidget(
                      label: StringConstants.labelTitle,
                    ),
                    SizedBox(height: Spacing.s24),
                    AuthTextFieldWidget(
                      label: StringConstants.firstname,
                      hintText: StringConstants.enterFirstName,
                      controller: registerProvider.firstNameController,
                      prefixIconPath: ImageNames.iconProfile,
                      enabled: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppFormValidation.fullNameFieldEmpty,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    AuthTextFieldWidget(
                      label: StringConstants.lastName,
                      hintText: StringConstants.enterLastName,
                      controller: registerProvider.lastNameController,
                      prefixIconPath: ImageNames.iconProfile,
                      enabled: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppFormValidation.fullNameFieldEmpty,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    AuthTextFieldWidget(
                      label: StringConstants.mobile,
                      hintText: StringConstants.enterMobile,
                      controller: registerProvider.phoneController,
                      prefixIconPath: ImageNames.iconMobile,
                      enabled: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppFormValidation.mobileValidation,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                    ),
                    SizedBox(height: 16),
                    AuthTextFieldWidget(
                      label: StringConstants.emailAddress,
                      hintText: StringConstants.enterEmailAddress,
                      controller: registerProvider.emailController,
                      prefixIconPath: ImageNames.iconEmail,
                      enabled: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: AppFormValidation.validateEmail,
                    ),
                    SizedBox(height: 16),
                    AuthTextFieldWidget(
                      label: StringConstants.password,
                      hintText: StringConstants.enterPassword,
                      controller: registerProvider.passwordController,
                      prefixIconPath: ImageNames.iconPassword,
                      enabled: true,
                      isPassword: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                      keyboardType: TextInputType.text,
                      validator: AppFormValidation.passwordValidation,
                    ),
                    SizedBox(height: 16),
                    AuthTextFieldWidget(
                      label: StringConstants.confirmPassword,
                      hintText: StringConstants.enterReEnterPassword,
                      controller: registerProvider.confirmPasswordController,
                      prefixIconPath: ImageNames.iconPassword,
                      enabled: true,
                      isPassword: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        registerProvider.validateForm();
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return AppFormValidation.confirmPasswordValidation(
                          value,
                          registerProvider.passwordController,
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: (registerProvider.isFormValid)
                          ? () {
                              registerProvider.createAccount();
                            }
                          : null,
                      child: Text(StringConstants.continueText),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringConstants.alreadyHaveAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(StringConstants.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
