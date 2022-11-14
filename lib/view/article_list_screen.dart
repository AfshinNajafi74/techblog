import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller.dart';


class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({Key? key}) : super(key: key);
  ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar("مقالات جدید"),
        body: Obx(
          ()=> SizedBox(
            child: ListView.builder(
              itemCount: articleController.articleList.length,
              itemBuilder: (context, index) {
                return Text(articleController.articleList[index].title!);
              },
            ),
          ),
        ),
      )
    );
  }

}
