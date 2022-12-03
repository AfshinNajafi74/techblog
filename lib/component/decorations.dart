import 'package:flutter/material.dart';
import 'package:tec/constant/my_colors.dart';

class MyDecoration {

  MyDecoration._();

  static  BoxDecoration mainGradiant = const BoxDecoration (
  borderRadius: BorderRadius.all(Radius.circular(18)),
  gradient: LinearGradient(
  colors: GradiantColors.bottomNav,
    )
  );
}