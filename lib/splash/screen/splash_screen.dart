import 'dart:async';

import 'package:authication_module/constants/image_names.dart';
import 'package:authication_module/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SplashProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(provider.initialRoute, (Route<dynamic> route) => false);
      });

    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(ImageNames.splashBack),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 10,),
                SvgPicture.asset(ImageNames.logo),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Text("Loading..", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
