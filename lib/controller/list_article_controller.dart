import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class ListArticleController extends GetxController{
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() async{
    loading.value = true;
    // TODO get userid from get storage getArticleList + userId
    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if(response.statusCode == 200){
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = true;
    }
  }
}