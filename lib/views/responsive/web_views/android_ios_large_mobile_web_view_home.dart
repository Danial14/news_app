import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AndroidIosLargeMobile extends StatefulWidget {
  const AndroidIosLargeMobile({super.key});

  @override
  State<AndroidIosLargeMobile> createState() => _AndroidIosLargeMobileState();
}

class _AndroidIosLargeMobileState extends State<AndroidIosLargeMobile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("medium mobile");
    return Scaffold(
      body: Container(
      width: size.width,
      height: size.height,
      color: Colors.greenAccent,
    ),
    );
  }
}
