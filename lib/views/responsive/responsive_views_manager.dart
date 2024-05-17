import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/responsive/mobile_views/android_mobile_views/home_screen.dart';
import 'package:news_app/views/responsive/mobile_views/splash_screen.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/extralarge_tablet.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/large_tablet.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/small_tablet_medium_mobile.dart';
import 'package:news_app/views/responsive/web_views/android_ios_large_tablet_web_view_home.dart';
import 'package:news_app/views/responsive/web_views/android_ios_medium_mobile_tablet_web_view_home.dart';
import 'package:news_app/views/responsive/web_views/android_ios_small_mobile_web_view_home.dart';
import 'package:news_app/views/responsive/web_views/extra_large_detail_web.dart';
import 'package:news_app/views/responsive/web_views/extra_large_devices_web_view_home.dart';
import 'package:news_app/views/responsive/web_views/extra_large_webviews.dart';
import 'package:news_app/views/responsive/web_views/home.dart';
import 'package:news_app/views/responsive/web_views/large_devices_web_view_home.dart';
import 'package:news_app/views/responsive/web_views/testscreen.dart';
import 'package:news_app/views/responsive/web_views/web_splash.dart';

class ResponsiveViewManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
      print("kisweb : ${kIsWeb}");
      if(kIsWeb){
        print("web display");
        // web views handler
        if(constraints.maxWidth < 600){
          // web handler for extra small devices such as small mobiles
          if(kReleaseMode){
            debugPrint = (String? message, {int? wrapWidth}){

            };
          }
          else if(kDebugMode) {
            debugPrint("extra small screen size handler");
          }
          return WebSplash(AndroidIosSmallMobileWebViewHome());
        }
        else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
          // web handler small devices such as portrait tablets and large mobiles
          if(kReleaseMode){
            debugPrint = (String? message, {int? wrapWidth}){

            };
          }
          else if(kDebugMode) {
            debugPrint("small screen size handler");
          }
          return WebSplash(AndroidIosMediumMobileTabletWebViewHome());
        }
        else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
          // web handler for medium devices such as large tablets
          if(kReleaseMode){
            debugPrint = (String? message, {int? wrapWidth}){

            };
          }
          else if(kDebugMode){
          debugPrint("medium screen size handler");
          }
          return WebSplash(AndroidIosLargeTabletWebViewHome());
        }
        else if(constraints.maxWidth >= 992 && constraints.maxWidth < 1200){
          // web handler large devices such as desktop, laptops
          if(kReleaseMode){
            debugPrint = (String? message, {int? wrapWidth}){

            };
          }
          else if(kDebugMode){
            debugPrint("large screen size handler");
          }
          return WebSplash(LargeDevicesWebViewHome());
        }
        else if(constraints.maxWidth >= 1200){
          // web handler for extra large devices such as very large tablets, laptops, desktops
          if(kReleaseMode){
            debugPrint = (String? message, {int? wrapWidth}){

            };
          }
          else if(kDebugMode) {
            debugPrint("extra large screen size handler");
          }
          return WebSplash(ExtraLargeDevicesWebViewHome());
        }
      }
      else if(Platform.isAndroid){
        // android views handler
        print("platform is android");
        print("maxwidth: ${constraints.maxWidth}");
        print("minwidth: ${constraints.minWidth}");
        if(constraints.maxWidth < 600){
          // android mobile views handler
          print("small mobile");
          return SplashScreen(HomeScreen());
        }
        else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
          // handler for android portrait tablets and large mobiles
          print("large mobile");
          return SplashScreen(SmallTabletAndMediumMobileHome());
        }
        else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
          // web handler for medium devices such as large tablets
          print("large tablet");
          return SplashScreen(LargeTablet());
        }
        else if(constraints.maxWidth >= 992 && constraints.maxWidth < 1200){
          // android handler for extra large devices such as very large tablets, laptops, desktops
          print("very large tablet");
          return SplashScreen(ExtraLargeTablet());
        }
        else if(constraints.maxWidth >= 1200){

        }
      }
      else if(Platform.isIOS){
        // ios views handler
        if((constraints.maxWidth >= 320 && constraints.maxWidth <= 1290) && (constraints.maxHeight >= 480 && constraints.maxHeight <= 2796)){
          // ios mobile views handler
        }
        else if((constraints.maxWidth >= 768 && constraints.maxWidth <= 2048) && (constraints.maxHeight >= 1024 && constraints.maxHeight <= 2732)){
          // ios ipad view handler
        }
      }
      return Container();
    });
  }
}
