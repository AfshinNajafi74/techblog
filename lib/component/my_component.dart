import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tec/component/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class TecDivider extends StatelessWidget {
  const TecDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: SolidColors.dividerColor,
      indent: size.width/6,
      endIndent: size.width/6,
    );
  }
}


myLaunchUrl(String url) async{
  var uri = Uri.parse(url);
  if(await canLaunchUrl(uri)){
    await launchUrl(uri);
  }else{
    log("could not launch ${uri.toString()}");
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCube(
      color: SolidColors.primaryColor,
      size: 32.0,
    );
  }
}


