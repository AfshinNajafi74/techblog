import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';


class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar("مقالات جدید"),
      )
    );
  }

}
