import 'package:authication_module/constants/image_names.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/widgets/auth_label_large_widget.dart';
import '../../../../../utils/widgets/auth_label_title_medium_widget.dart';
import '../../../../../utils/widgets/auth_text_field_widget.dart';
import '../../../../../utils/widgets/auth_widgets/auth_container_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Forget Password"),
      // ),
      body: AuthContainerWidget(
        onBackPressed: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,  // Spacing.medium equivalent
            right: 16.0,
            bottom: 16.0,
          ),
          child: Form(
            child: Column(
              children: [
                AuthLabelLargeWidget(label: "Forgot Password"),
                SizedBox(height: 4),
                AuthLabelTitleMediumWidget(
                  label: "Enter your mobile number to reset password",
                ),
                SizedBox(height: 24),
                AuthTextFieldWidget(
                  label: "Mobile",
                  hintText: "Enter your mobile number",
                  keyboardType: TextInputType.phone,
                  prefixIconPath: ImageNames.iconMobile, // Adjust to actual icon path
                  enabled: true,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    // Sample mobile validation logic
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Logic to validate form can go here
                  }, controller: email,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Logic to trigger reset password action
                    // You can add actual functionality here.
                  },
                  child: Text("Reset Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
