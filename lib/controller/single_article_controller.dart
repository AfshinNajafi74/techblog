import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/services/dio_service.dart';

class SingleArticleController extends GetxController{
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;

  @override
  void onInit() {
    super.onInit();
    // getArticleInfo();
  }

  getArticleInfo() async{
    loading.value = true;
    // TODO is hard code
    var userId = '';
    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=1&user_id=1
    var response = await DioService().getMethod("${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId");
    if(response.statusCode == 200){
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
      loading.value = true;
    }
  }
}