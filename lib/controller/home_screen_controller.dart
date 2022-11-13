import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/poster_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController{
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcast = RxList();
  RxBool loading = false.obs;

  @override
  onInit(){
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async{
    loading.value = true;
    var response = await DioService().getMethod(ApiConstant.getHomeItems);
    if(response.statusCode  == 200){
      response.data["top_visited"].forEach((element){
        topVisitedList.add(ArticleModel.fromJson(element));
      });

      response.data["top_podcasts"].forEach((element) {
        topPodcast.add(PodcastModel.fromJson(element));
      });

      poster.value = PosterModel.fromJson(response.data['poster']);
      loading.value = false;
    }

  }
}