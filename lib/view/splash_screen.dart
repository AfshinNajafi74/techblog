import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tec/component/my_colors.dart';
import 'package:get/get.dart';
import 'package:tec/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Get.offAndToNamed(routeMainScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Image(image: Assets.images.logo,height: 64,).image,
            Image(height: 64,image: AssetImage('assets/images/logo.png')),
            SizedBox(height: 30,),
            SpinKitFadingCube(
              color: SolidColors.primaryColor,
              size: 32.0,
            )
          ],
        ),
      ),
    );
  }
}
