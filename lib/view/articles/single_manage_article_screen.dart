import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/articles/list_article_controller.dart';
import 'package:tec/controller/articles/manage_article_controller.dart';
import 'package:tec/view/articles/article_list_screen.dart';
import '../../gen/assets.gen.dart';

class SingleManageArticleScreen extends StatelessWidget {
  final ManageArticleController manageArticleController = Get.find<ManageArticleController>();

  SingleManageArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double bodyMargin = Get.size.width/10;

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
                      imageUrl: manageArticleController.articleInfoModel.value.image!,
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
                          children:  [
                            const SizedBox(width: 20,),
                            GestureDetector(onTap: () => Get.back(),child: const Icon(Icons.arrow_back,color: Colors.white,size: 24,)),
                          ],
                        ),
                      )
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 30,
                          width: Get.width / 3,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: SolidColors.primaryColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("انتخاب تصویر",style: textTheme.headline2,),
                              const SizedBox(width: 8,),
                              const Icon(Icons.add,color: Colors.white,)
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
                Row(
                  children: [
                    SeeMoreBlog(bodyMargin: bodyMargin, textTheme: textTheme,title: MyStrings.viewHottestBlog,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(manageArticleController.articleInfoModel.value.title!,maxLines: 2,style: textTheme.titleLarge,),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(image: Image.asset(Assets.images.profileAvatar.path,).image,height: 50,),
                      const SizedBox(width: 16,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    manageArticleController.articleInfoModel.value.content!,
                    // textStyle: textTheme.headline5,
                    enableCaching: true,
                    onLoadingBuilder: ((context, element, loadingProgress) => const Loading()),
                  ),
                ),
                const SizedBox(height: 25,),
                // tags(textTheme),
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
          itemCount: manageArticleController.tagList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () async {
                String id = manageArticleController.tagList[index].id!;
                await Get.find<ListArticleController>().getArticleListWithTagsId(id);
                Get.to(ArticleListScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.grey),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        manageArticleController.tagList[index].title!,
                        style: textTheme.headline2,
                      )),
                ),
              ),
            );
          })),
    );
  }


}
