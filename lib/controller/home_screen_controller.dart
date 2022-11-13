import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/poster_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController{
  late Rx<PosterModel> poster;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcast = RxList();

  @override
  onInit(){
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async{
    var response = await DioService().getMethod(ApiConstant.getHomeItems);
    if(response.statusCode == 200){
      response.data["top_visited"].forEach((ele){
        topVisitedList.add(ArticleModel.fromJson(ele));
      });

      response.data["top_podcasts"].forEach((ele) {
        topPodcast.add(PodcastModel.fromJson(ele));
      });
    }

  }
}