import 'package:flutter/material.dart';

class TestScreenTwo extends StatefulWidget {
  const TestScreenTwo({super.key});

  @override
  State<TestScreenTwo> createState() => _TestScreenTwoState();
}

class _TestScreenTwoState extends State<TestScreenTwo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Center(
          child: Text("Test screen two"),
        ),
      ),
    );
  }
}
