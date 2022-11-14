import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class SingleArticleController extends GetxController{
  RxBool loading = false.obs;
  RxInt id = RxInt(0);

  @override
  void onInit() {
    super.onInit();
  }

  getArticleInfo() async{
    loading.value = true;
    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=1&user_id=1
    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if(response.statusCode == 200){
      // response.data.forEach((element) {
      //   articleList.add(ArticleModel.fromJson(element));
      // });
      loading.value = true;
    }
  }
}