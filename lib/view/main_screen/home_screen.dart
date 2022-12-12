import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/articles/single_article_controller.dart';
import 'package:tec/view/articles/article_list_screen.dart';

import '../../main.dart';
import '../podcast/single_podcast_screen.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({
    Key? key,
    required this.textTheme,
    required this.bodyMargin,
  }) : super(key: key);

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final SingleArticleController singleArticleController = Get.put(SingleArticleController());


  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
         () => Padding(
          padding: const EdgeInsets.fromLTRB(0,16,0,0),
          child: homeScreenController.loading.value == false ? Column(
            children: [
              poster(),
              const SizedBox(height: 16,),
              tags(),
              const SizedBox(height: 32,),
              GestureDetector(onTap: () => Get.to(ArticleListScreen()),child: SeeMoreBlog(bodyMargin: bodyMargin, textTheme: textTheme,title: MyStrings.viewHottestBlog,)),
              topVisited(),
              const SizedBox(height: 32,),
              SeeMorePodcast(bodyMargin: bodyMargin, textTheme: textTheme),
              // see more
              topPodcasts(),
              const SizedBox(height: 65,),
            ],
          ) : const Center(child: Loading(),),
        ),
      ),
    );
  }

  Widget topVisited(){
    return SizedBox(
      height: Get.height/3.5,
      child: Obx(
        ()=> ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeScreenController.topVisitedList.length,
          itemBuilder: (context, index) {
            // blog item
            return GestureDetector(
              onTap: () {
                singleArticleController.getArticleInfo(homeScreenController.topVisitedList[index].id);
              },
              child: Padding(
                padding:  EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Get.height/5.3,
                        width: Get.width/2.4,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: homeScreenController.topVisitedList[index].image!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                       image: imageProvider,fit: BoxFit.cover
                                    )
                                  ),
                                  foregroundDecoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16)),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: GradiantColors.blogPost)),
                                );
                              },
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,),
                            ),
                            Positioned(
                              bottom : 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(homeScreenController.topVisitedList[index].author!,style: textTheme.subtitle1,),
                                  Row(
                                    children: [
                                      Text(homeScreenController.topVisitedList[index].view!,style: textTheme.subtitle1,),
                                      const SizedBox(width: 8,),
                                      const Icon(Icons.remove_red_eye_sharp,color: Colors.white,size: 16,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: Get.width/2.4,
                        child: Text(
                          homeScreenController.topVisitedList[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topPodcasts(){
    return SizedBox(
      height: Get.height/3.5,
      child: Obx(
        ()=> ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeScreenController.topPodcast.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoutes.singlePodcastScreen,arguments: homeScreenController.topPodcast[index]);
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Get.height/5.3,
                        width: Get.width/2.4,
                        child: CachedNetworkImage(
                          imageUrl: homeScreenController.topPodcast[index].poster!,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover
                                )
                              ),
                            );
                          },
                          placeholder: (context, url) => const Loading(),
                          errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined,size: 50,color: Colors.grey,),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: Get.width / 2.4,
                        child: Text(
                          homeScreenController.topPodcast[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget poster(){
    return Stack(
      children: [
        Container(
          width: Get.width/1.25,
          height: Get.height/4.2,
          foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                  colors: GradiantColors.homePosterCoverGradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: ((context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover)),
            )),
            placeholder: ((context, url) => const Loading()),
            errorWidget: ((context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: Colors.grey,
            )),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(homeScreenController.poster.value.title!,style: textTheme.headline1,),
            ],
          ),
        ),
      ],
    );
  }

  Widget tags(){
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeScreenController.tagList.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.fromLTRB(0,8,index == 0 ? bodyMargin : 15,8),
              child: MainTags(textTheme: textTheme, index: index),
            );
          }
      ),
    );
  }

}

class SeeMorePodcast extends StatelessWidget {
  const SeeMorePodcast({
    Key? key,
    required this.bodyMargin,
    required this.textTheme,
  }) : super(key: key);

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: bodyMargin,bottom: 8),
      child:  Row(
        children: [
          Image.asset('assets/icons/microphon.png',color: SolidColors.seeMore,height: 28,),
          const SizedBox(width: 8,),
          Text(MyStrings.viewHottestPodCasts,style: textTheme.headline3,),
        ],
      ),
    );
  }
}




