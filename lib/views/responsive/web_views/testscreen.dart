import 'package:flutter/material.dart';
import 'package:news_app/views/responsive/web_views/testscreentwo.dart';

class TestScreenOne extends StatefulWidget {
  const TestScreenOne({super.key});

  @override
  State<TestScreenOne> createState() => _TestScreenOneState();
}

class _TestScreenOneState extends State<TestScreenOne> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 600) {
            return Container(
              width: size.width,
              height: size.height,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return TestScreenTwo();
                        }));
                  },
                  child: Text("Test Screen 2 small"),
                ),
              ),
            );
          }
          else{
            return Center(
              child: Text(
                "Too large"
              ),
            );
          }
        }
      ),
    );
  }
}
