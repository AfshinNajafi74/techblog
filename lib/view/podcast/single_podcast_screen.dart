import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/decorations.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../component/dimens.dart';
import '../../controller/podcast/single_podcast_controller.dart';
import '../../models/podcast_model.dart';

class SinglePodcastScreen extends StatelessWidget {

  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;
  SinglePodcastScreen() {
    podcastModel = Get.arguments;
    singlePodcastController = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:"https://digiato.com/wp-content/uploads/2022/12/5G-910x600.jpg",
                          imageBuilder: (context, imageProvider) {
                            return Image(image: imageProvider,);
                          },
                          placeholder: (context, url) => const Loading(),
                          errorWidget: (context, url, error) {
                            return Image.asset("assets/images/single_place_holder.jpg");
                          },
                        ),
                        Positioned(
                            child: Container(
                              height: 60,
                              decoration:  BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: GradiantColors.singleAppBarGradiant,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:  [
                                  const SizedBox(width: 20,),
                                  GestureDetector(onTap: () => Get.back(),child: const Icon(Icons.arrow_back,color: Colors.white,size: 24,)),
                                  const Expanded(child: SizedBox()),
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.share,color: Colors.white,size: 24,),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("title!",maxLines: 2,style: textTheme.titleLarge,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(image: Image.asset(Assets.images.profileAvatar.path,).image,height: 50,),
                          const SizedBox(width: 16,),
                          Text("AfshinNajafi!",maxLines: 2,style: textTheme.headline4,),
                          const SizedBox(width: 16,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ImageIcon(Image.asset(Assets.icons.microphon.path,color: SolidColors.seeMore,).image),
                                    SizedBox(width: 8,),
                                    Text("بخش چهارم : فریلنسر دیوانه",style: textTheme.headline4,)
                                  ],
                                ),
                                Text("22:00")
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ),
            Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecoration.mainGradiant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 1.0,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.skip_next,color: Colors.white,),
                          Icon(Icons.play_circle_fill,color: Colors.white,size: 48,),
                          Icon(Icons.skip_previous,color: Colors.white,),
                          SizedBox(),
                          Icon(Icons.repeat,color: Colors.white,),
                        ],
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
