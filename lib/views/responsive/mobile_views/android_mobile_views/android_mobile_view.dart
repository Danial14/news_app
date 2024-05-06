import 'package:flutter/material.dart';
import 'package:news_app/views/responsive/mobile_views/android_mobile_views/splash_screen.dart';

class AndroidMobileView extends StatelessWidget {
  const AndroidMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen()
    );
  }
}
