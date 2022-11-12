import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/poster_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController{
  late Rx<PosterModel> poster;
  RxList tagList = RxList();
  RxList topVisitedList = RxList();
  RxList topPodcast = RxList();

  getHomeItem() async{
    var response = await DioService().getMethod(ApiConstant.getHomeItems);
    response.date['poster'];
    response.date['top_visited'];
    response.date['top_podcasts'];
    response.date['tags'];
    print(response.date['poster']["title"]);
  }
}