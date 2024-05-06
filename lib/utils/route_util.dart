import 'package:flutter/material.dart';

class RouteUtil{
  static Route createRoute(Widget screen){
    return PageRouteBuilder(pageBuilder: (ctx, animation, secondaryAnimation){
      return screen;
    },
    transitionsBuilder: (ctx, animation, secondaryAnimation, ch){
      Tween<Offset> slideTween = Tween<Offset>(
        begin: Offset(1, 1),
        end: Offset.zero
      );
      return SlideTransition(
        position: animation.drive(slideTween.chain(CurveTween(curve: Curves.decelerate))),
        child: ch,
      );
      },
      transitionDuration: Duration(seconds: 2),
      reverseTransitionDuration: Duration(seconds: 2)
    );
  }
  static Route createBackRoute(Widget screen){
    return PageRouteBuilder(pageBuilder: (ctx, animation, secondaryAnimation){
      return screen;
    },
    transitionsBuilder: (ctx, animation, secondaryAnimation, ch){
      Tween<Offset> slideTween = Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset.zero
      );
      return SlideTransition(position: animation.drive(slideTween.chain(CurveTween(curve: Curves.decelerate))),
      child: ch,
      );
    },
      transitionDuration: Duration(seconds: 2)
    );
  }
}