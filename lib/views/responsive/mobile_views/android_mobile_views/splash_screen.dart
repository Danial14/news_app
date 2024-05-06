import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), (){
      // switch to home screen
      Navigator.of(context).pushReplacement(
        PageTransition(child: HomeScreen(), type: PageTransitionType.rightToLeft, duration: Duration(seconds: 4))
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 2,
              left: 2
              ),
              child: Image.asset("assets/images/splash_pic.jpg",
              fit: BoxFit.cover,
                height: height * 0.6,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text("Top Headlines", style: GoogleFonts.anton(
              color: Colors.grey.shade700,
              letterSpacing: 6
            ),),
            SizedBox(height: height * 0.04,),
            const SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )
          ],
        )
      ),
    );
  }
}
