import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/responsive/mobile_views/android_mobile_views/android_mobile_view.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/android_portrait_tablet_large_mobile_view.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/extralarge_tablet.dart';
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
  late final AndroidMobileView _androidMobileView;
  late final ExtraLargeWebView _desktopWebView;
  late final AndroidPortraitTabletAndLargeMobileView _androidPortraitTabletAndLargeMobileView;
  ResponsiveViewManager(AndroidMobileView androidMobileView, ExtraLargeWebView desktopWebView, AndroidPortraitTabletAndLargeMobileView androidPortraitTabletAndLargeMobileView){
    _androidMobileView = androidMobileView;
    _desktopWebView = desktopWebView;
    _androidPortraitTabletAndLargeMobileView = androidPortraitTabletAndLargeMobileView;
  }
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
          return _androidMobileView;
        }
        else if(constraints.minWidth >= 600 && constraints.minWidth < 768){
          // handler for android portrait tablets and large mobiles
          print("large mobile");
          return _androidPortraitTabletAndLargeMobileView;
        }
        else if(constraints.minWidth >= 768 && constraints.minWidth < 992){
          // web handler for medium devices such as large tablets
          print("large tablet");
          return Container(
            width: constraints.minWidth,
            height: constraints.minHeight,
            color: Colors.yellow,
          );
        }
        else if(constraints.minWidth >= 992){
          // android handler for extra large devices such as very large tablets, laptops, desktops
          print("very large tablet");
          return ExtraLargeTablet();
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
