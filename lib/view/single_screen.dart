import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';

import '../gen/assets.gen.dart';

class SingleScreen extends StatelessWidget {
  const SingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "",
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
                      children: [
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
              child: Text("data",maxLines: 2,style: textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(image: Image.asset(Assets.images.profileAvatar.path,).image,height: 50,),
                  SizedBox(width: 16,),
                  Text("فاطمه امیری",maxLines: 2,style: textTheme.headline4,),
                  SizedBox(width: 16,),
                  Text("تاریخ",maxLines: 2,style: textTheme.caption,)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tags(textheme) {
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
                      style: textheme.headline2,
                    )),
              ),
            );
          })),
    );
  }

  Widget simmilar(textheme) {
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
                                  style: textheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "",
                                      style: textheme.subtitle1,
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
                      child: Text(
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
