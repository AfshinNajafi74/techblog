import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tec/controller/articles/list_article_controller.dart';
import 'package:tec/controller/articles/single_article_controller.dart';

import '../../main.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({Key? key}) : super(key: key);
 final ListArticleController listArticleController = Get.put(ListArticleController());
 final SingleArticleController singleArticleController = Get.put(SingleArticleController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: appBar("مقالات جدید"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(
              ()=> ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listArticleController.articleList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      singleArticleController.getArticleInfo(listArticleController.articleList[index].id);
                      Get.toNamed(NamedRoutes.singleScreen);
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
                              imageUrl: listArticleController.articleList[index].image!,
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
                                child: Text(listArticleController.articleList[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(height: 16,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listArticleController.articleList[index].author!,style: textTheme.caption),
                                  const SizedBox(width: 20,),
                                  Text("${listArticleController.articleList[index].view! } بازدید",style: textTheme.caption,),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      )
    );
  }

}
