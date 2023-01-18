import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/articles/manage_article_controller.dart';



class ManageArticleScreen extends StatelessWidget{

  final ManageArticleController manageArticleController = Get.find<ManageArticleController>();

  ManageArticleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: appBar("مدیریت مقاله ها"),
          bottomNavigationBar:               Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  Get.toNamed(NamedRoutes.singleManageArticleScreen);
                },
                style: ButtonStyle(fixedSize: MaterialStateProperty.all(Size(Get.width/3, 56))),
                child: const Text('بریم برای نوشتن یه مقاله باحال',),
              ),
            ),
          ),
          body: Obx(
                ()=> manageArticleController.loading.value == true ? const Loading() : manageArticleController.articleList.isNotEmpty ? ListView.builder(
                 scrollDirection: Axis.vertical,
                 itemCount: manageArticleController.articleList.length,
                 itemBuilder: (context, index) {
                 return GestureDetector(
                  onTap: () {
                     /// route to single manage
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                          width: Get.width / 3,
                          child: CachedNetworkImage(
                            imageUrl: manageArticleController.articleList[index].image!,
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
                        const SizedBox(width: 16,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(manageArticleController.articleList[index].title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(manageArticleController.articleList[index].author!,style: textTheme.caption),
                                const SizedBox(width: 20,),
                                Text("${manageArticleController.articleList[index].view! } بازدید",style: textTheme.caption,),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : articleEmptyState(textTheme),
          ),
        ) 
    );
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_state.png',height: 100,),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                      text: MyStrings.articleEmpty,
                      style: textTheme.headline4
                    )
                ),
              ),
            ],
          ),
        );
  }

}