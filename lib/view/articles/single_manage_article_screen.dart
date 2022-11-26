import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/articles/list_article_controller.dart';
import 'package:tec/controller/articles/manage_article_controller.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/services/pick_file.dart';
import 'package:tec/view/articles/article_content_editor.dart';
import 'package:tec/view/articles/article_list_screen.dart';


class SingleManageArticleScreen extends StatelessWidget {
  final ManageArticleController manageArticleController = Get.find<ManageArticleController>();
  final FilePickerController filePickerController = Get.put(FilePickerController());


  SingleManageArticleScreen({super.key});

  getTitle(){
    Get.defaultDialog(
      titleStyle: TextStyle(
        color: SolidColors.scaffoldBg
      ),
      title: "عنوان مقاله",
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: SolidColors.colorTitle
        ),
        decoration: InputDecoration(
          hintText: "اینجا بنویس"
        ),
      ),
      backgroundColor: SolidColors.primaryColor,
      radius: 8,
      confirm: ElevatedButton(
        onPressed: (){
          manageArticleController.updateTitle();
          Get.back();
        },
          child: Text("ثـبـت")
      )
    );
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
                    SizedBox(
                      width: double.infinity,
                      height: Get.height / 3,
                      child: filePickerController.file.value.name == "nothing" ?
                      CachedNetworkImage(
                        imageUrl: manageArticleController.articleInfoModel.value.image!,
                        imageBuilder: (context, imageProvider) {
                          return Image(image: imageProvider,);
                        },
                        placeholder: (context, url) => const Loading(),
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/images/single_place_holder.jpg",fit: BoxFit.cover);
                        },
                      ) : Image.file(File(filePickerController.file.value.path!),fit: BoxFit.cover,),
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
                        child: GestureDetector(
                          onTap: () {
                            pickFiles();
                          },
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
                        ),
                      )
                    )
                  ],
                ),
                const SizedBox(height: 24,),
                GestureDetector(
                  onTap: () {
                    getTitle();
                  },
                  child: SeeMoreBlog(bodyMargin: Dimens.halfBodyMargin, textTheme: textTheme,title: "ویرایش عنوان مقاله",)),
                Padding(
                  padding:  EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(manageArticleController.articleInfoModel.value.title!,maxLines: 2,style: textTheme.titleLarge,),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ArticleContentEditor()),
                  child: SeeMoreBlog(bodyMargin: Dimens.halfBodyMargin, textTheme: textTheme,title: "ویرایش متن اصلی مقاله",)),
                Padding(
                  padding: EdgeInsets.all(Dimens.halfBodyMargin),
                  child: HtmlWidget(
                    manageArticleController.articleInfoModel.value.content!,
                    // textStyle: textTheme.headline5,
                    enableCaching: true,
                    onLoadingBuilder: ((context, element, loadingProgress) => const Loading()),
                  ),
                ),
                const SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    chooseCateBottomSheet(textTheme);
                  },
                  child: SeeMoreBlog(bodyMargin: Dimens.halfBodyMargin, textTheme: textTheme,title: "انتخاب دسته بندی",)),
                Padding(
                  padding:  EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(manageArticleController.articleInfoModel.value.catName == null ? "هیچ دسته بندی انتخاب نشده" : manageArticleController.articleInfoModel.value.catName!,
                    maxLines: 2,
                    style: textTheme.titleLarge
                  ),
                )
                // tags(textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cats(textTheme) {
    HomeScreenController homeScreenController = Get.find<HomeScreenController>();
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5),
          scrollDirection: Axis.vertical,
          itemCount: homeScreenController.tagList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () async {
                manageArticleController.articleInfoModel.update((val) {
                  val!.catId = homeScreenController.tagList[index].id!;
                  val.catName = homeScreenController.tagList[index].title!;
                });
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: SolidColors.primaryColor),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Center(
                        child: Text(
                          homeScreenController.tagList[index].title!,
                          style: textTheme.headline2,
                        ),
                      )),
                ),
              ),
            );
          })),
    );
  }

  chooseCateBottomSheet(TextTheme textTheme){
    Get.bottomSheet(
      Container(
        height: Get.height / 1.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("انتخاب دسته بندی"),
              const SizedBox(height: 8,),
              cats(textTheme)
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      persistent: true
    );
  }


}
