import 'package:get/get.dart';
import 'package:tec/controller/articles/list_article_controller.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/controller/articles/single_article_controller.dart';

class ArticleBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(ListArticleController());
    Get.lazyPut(() => SingleArticleController());
  }
}

class RegisterBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(RegisterController());
  }

}