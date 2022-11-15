import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/single_article_controller.dart';

import '../gen/assets.gen.dart';

class SingleScreen extends StatefulWidget {
  SingleScreen({Key? key}) : super(key: key);

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  final SingleArticleController singleArticleController = Get.put(SingleArticleController());

  @override
  void initState() {
    super.initState();
    singleArticleController.getArticleInfo();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: singleArticleController.articleInfoModel.value.image!,
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
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradiantColors.singleAppBarGradiant,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            SizedBox(width: 20,),
                            Icon(Icons.arrow_back,color: Colors.white,size: 24,),
                            Expanded(child: SizedBox()),
                            Icon(Icons.bookmark_border_rounded,color: Colors.white,size: 24,),
                            SizedBox(width: 20,),
                            Icon(Icons.share,color: Colors.white,size: 24,),
                            SizedBox(width: 20,),
                          ],
                        ),
                      )
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(singleArticleController.articleInfoModel.value.title!,maxLines: 2,style: textTheme.titleLarge,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(image: Image.asset(Assets.images.profileAvatar.path,).image,height: 50,),
                      const SizedBox(width: 16,),
                      Text(singleArticleController.articleInfoModel.value.author!,maxLines: 2,style: textTheme.headline4,),
                      const SizedBox(width: 16,),
                      Text(singleArticleController.articleInfoModel.value.createdAt!,maxLines: 2,style: textTheme.caption,)

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    singleArticleController.articleInfoModel.value.content!,
                    // textStyle: textTheme.headline5,
                    enableCaching: true,
                    onLoadingBuilder: ((context, element, loadingProgress) => const Loading()),
                  ),
                ),
                const SizedBox(height: 25,),
                tags(textTheme),
                const SizedBox(height: 25,),
                simmilar(textTheme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tags(textTheme) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: Colors.grey),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      '',
                      style: textTheme.headline2,
                    )),
              ),
            );
          })),
    );
  }

  Widget simmilar(textTheme) {
    return SizedBox(
      height: Get.height / 3.5,
      child: ListView.builder(
          itemCount: 9,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //blog item
            return Padding(
              padding:
              EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: Get.height / 5.3,
                      width: Get.width / 2.4,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:  "",
                            imageBuilder: ((context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                  foregroundDecoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16)),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: GradiantColors.blogPost)),
                                )),
                            placeholder: ((context, url) => const Loading()),
                            errorWidget: ((context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                              color: Colors.grey,
                            )),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "",
                                  style: textTheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "",
                                      style: textTheme.subtitle1,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      width: Get.width / 2.4,
                      child: const Text(
                        "singleArcticleController.releatedList[index].title!",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ))
                ],
              ),
            );
          })),
    );
  }
}
