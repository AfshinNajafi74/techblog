import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/articles/single_screen.dart';

class SingleArticleController extends GetxController{
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<ArticleModel> relatedList = RxList();
  RxList<TagsModel> tagList = RxList();
  @override
  void onInit() {
    super.onInit();
    // getArticleInfo();
  }

  getArticleInfo(var id) async{
    articleInfoModel = ArticleInfoModel().obs;
    loading.value = true;
    // TODO is hard code
    var userId = '';
    // https://techblog.sasansafari.com/Techblog/api/article/get.php?command=info&id=1&user_id=1
    var response = await DioService().getMethod("${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId");
    if(response.statusCode == 200){
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

      relatedList.clear();
      response.data["related"].forEach((element){
        relatedList.add(ArticleModel.fromJson(element));
      });

      tagList.clear();
      response.data["tags"].forEach((element) {
        tagList.add(TagsModel.fromJson(element));
      });

      loading.value = true;
    }
    Get.to(SingleScreen(),);
  }

}