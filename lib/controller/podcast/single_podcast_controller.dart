import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcast_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController{
  var id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();

  getPodcastFiles() async{
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.podcastFiles+id);

    if(response.statusCode == 200){
      for(var element in response.data["files"]) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
      }
      loading.value = false;
    }

  }

}