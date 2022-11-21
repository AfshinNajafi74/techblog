import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class ManageArticleController extends GetxController{
  RxList<ArticleModel> articleList = RxList.empty();
  RxBool loading = false.obs;

  @override
  onInit(){
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;
    // var response = await DioService().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var response = await DioService().getMethod("${ApiConstant.publishedByMe}1");
    if(response.statusCode == 200){
      response.data.forEach((element){
        articleList.add(ArticleModel.fromJson(element));
      });
      // articleList.clear();
      loading.value = false;
    }

  }
}