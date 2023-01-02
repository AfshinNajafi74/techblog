import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcast_file_model.dart';
import 'package:tec/services/dio_service.dart';
import 'package:just_audio/just_audio.dart';

class SinglePodcastController extends GetxController{
  var id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  late var playList;
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;


  @override
  void onInit() async{
    super.onInit();
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: []
    );
    await getPodcastFiles();
    await player.setAudioSource(playList,initialIndex: 0,initialPosition: Duration.zero);
  }

  getPodcastFiles() async{
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.podcastFiles+id);

    if(response.statusCode == 200){
      for(var element in response.data["files"]) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
        playList.add(AudioSource.uri(Uri.parse(PodcastFileModel.fromJson(element).file!)));
      }
      loading.value = false;
    }

  }

  Rx<Duration> progressValue = Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = Duration(seconds: 0).obs;
  Timer? timer;

  startProgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if(timer != null){
      if(timer!.isActive){
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      duration--;
      log("duration $duration =====> index : ${player.currentIndex}");
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if(duration >= 0){
        timer.cancel();
        progressValue.value = Duration(seconds: 0);
        bufferedValue.value = Duration(seconds: 0);
      }
    });
  }

  setLoopMode() {
    if(isLoopAll.value){
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    }else{
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }

  timerCheck() {
    if(player.playing){
      startProgress();
    }
  }

}