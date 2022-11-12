import 'package:flutter/material.dart';
import 'package:tec/component/my_colors.dart';


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
