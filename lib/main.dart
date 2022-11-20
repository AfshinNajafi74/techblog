import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tec/binding.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/single_screen.dart';
import 'package:tec/view/splash_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'my_http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.systemNavigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is teh root of my application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      locale: const Locale('fa'),
      theme: lightTheme(textTheme),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: routeMainScreen, page: () => MainScreen(),binding: RegisterBinding()),
        GetPage(name: routeSingleScreen, page: () => SingleScreen(),binding: ArticleBinding())
      ],
      initialRoute: routeMainScreen,
    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      fontFamily: 'dana',
      brightness: Brightness.light,
      textTheme:  const TextTheme(
        headline1: TextStyle(
          fontFamily: 'dana',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: SolidColors.posterTitle
        ),
        subtitle1: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: SolidColors.posterSubTitle
        ),
        bodyText1: TextStyle(
          fontFamily: 'dana',
          fontSize: 13,
          fontWeight: FontWeight.w300
        ),
        headline2: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.white
        ),
        headline3: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: SolidColors.seeMore
        ),
        headline4: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w700
        ),
        headline5: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            color: SolidColors.hintText,
            fontWeight: FontWeight.w700),
      )
    );
  }
}

String routeMainScreen = "/";
String routeSingleScreen = "/SingleScreen";

