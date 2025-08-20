import 'package:flutter/material.dart';

import '../../../../../utils/widgets/auth_widgets/auth_container_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthContainerWidget()
    );
  }
}
