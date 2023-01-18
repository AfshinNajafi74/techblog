import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/route_manager/pages.dart';
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
      initialRoute: NamedRoutes.initialRoute,
      locale: const Locale('fa'),
      theme: lightTheme(textTheme),
      debugShowCheckedModeBanner: false,
      getPages:Pages.pages,
    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return textTheme.headline1;
              }
              return textTheme.subtitle1;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return SolidColors.seeMore;
              }
              return SolidColors.primaryColor;
            })
        )
      ),
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

