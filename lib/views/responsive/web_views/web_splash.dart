import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/utils/route_util.dart';
import 'package:news_app/views/responsive/web_views/home.dart';

class WebSplash extends StatefulWidget {
  late Widget _whichScreenToNavigate;
  WebSplash(Widget whichScreenToNavigate){
    this._whichScreenToNavigate = whichScreenToNavigate;
  }

  @override
  State<WebSplash> createState() => _WebSplashState();
}

class _WebSplashState extends State<WebSplash> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Tween<double> _scaleTween;
  late Animation<double> _rotationAnimation;
  late Tween<double> _linearTween;
  late AnimationController _linearAnimationController;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5))..repeat(reverse: true);
    _linearAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _scaleTween = Tween(
      begin: 0.0,
      end: 8 * 3.22
    );
    _linearTween = Tween(
      begin: 0.0,
      end: 1.0
    );
    _animationController.drive(_scaleTween);
    _rotationAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _linearAnimationController.repeat(reverse: true);
    _linearAnimationController.drive(_linearTween).addStatusListener((status) {
      if(status.name == "reverse"){
        _linearAnimationController.stop();
       // Navigator.of(context).pushReplacement(RouteUtil.createRoute(ExtraLargeWebHomeView()));
        Navigator.of(context).pushReplacement(RouteUtil.createRoute(widget._whichScreenToNavigate));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
              builder: (ctx, ch){
                return Column(
                  children: [
                    Transform.scale(
                        scale: _animationController.value,
                        child: RotationTransition(
                          turns: _rotationAnimation,
                          child: Image.asset("assets/images/news.png",
                            width: size.width * 0.6,
                            height: size.height * 0.6,
                          ),
                        ),
                      ),
                    Container(child: LinearProgressIndicator(
                      value: _linearAnimationController.value,
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(15),
                      minHeight: 30,
                    ),
                      width: size.width * 0.6,
                    )
                  ],
                );
              },
              animation: _animationController,
            ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _linearAnimationController.removeListener(() {
    });
    _linearAnimationController.dispose();
    super.dispose();
  }
}
