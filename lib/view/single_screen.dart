import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';

class SingleScreen extends StatelessWidget {
  const SingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
