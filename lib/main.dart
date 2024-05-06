import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:news_app/view_model/categories_view_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/responsive/mobile_views/android_mobile_views/android_mobile_view.dart';
import 'package:news_app/views/responsive/responsive_views_manager.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/android_portrait_tablet_large_mobile_view.dart';
import 'package:news_app/views/responsive/web_views/extra_large_webviews.dart';
import 'package:provider/provider.dart';
//import 'dart:ui_web';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(kIsWeb) {
    //setUrlStrategy(null);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: ResponsiveViewManager(AndroidMobileView(), ExtraLargeWebView(), AndroidPortraitTabletAndLargeMobileView()),
      ),
      providers: [
        ChangeNotifierProvider(create: (ctx){
          print("news view model created");
          return NewsViewModel();
        }),
        ChangeNotifierProvider(create: (ctx){
          print("categories view model created");
          return CategoriesViewModel();
        })
      ],
    );
  }
}
