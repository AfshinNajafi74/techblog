import 'package:flutter/material.dart';
import 'package:tec/models/fake_data.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/my_strings.dart';
import 'gen/assets.gen.dart';

class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width/10;
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(0,16,0,0),
          child: Column(
            children: [
              // appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.menu),
                  // Image(image: Assets.images.logo),
                  Image.asset('assets/images/logo.png',height: size.height/13.6,),
                  const Icon(Icons.search)
                ],
              ),
              const SizedBox(height: 8,),
              // poster
              Stack(
                children: [
                  Container(
                    width: size.width/1.25,
                    height: size.height/4.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        // image: Image(image: Assets.images.logo,).image,
                        image: AssetImage(homePagePosterMap['imageAsset']),
                        fit: BoxFit.cover
                      )
                    ),
                    foregroundDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(
                          colors: GradiantColors.homePosterCoverGradiant,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(homePagePosterMap['writer'] + ' - ' + homePagePosterMap['date'],style: textTheme.subtitle1,),
                            Row(
                              children: [
                                Text(homePagePosterMap['view'],style: textTheme.subtitle1,),
                                SizedBox(width: 8,),
                                Icon(Icons.remove_red_eye_sharp,color: Colors.white,size: 16,),
                              ],
                            )
                          ],
                        ),
                        Text('دوازده قدم برنامه نویسی یک دوره ی . . . س',style: textTheme.headline1,),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              // tagList
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tagList.length,
                  itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0,8,index == 0 ? bodyMargin : 15,8),
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            gradient: LinearGradient(
                                colors: GradiantColors.tags,
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16,8,8,8),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/hashtagicon.png',height: 16,),
                                SizedBox(width: 8,),
                                Text(tagList[index].title,style: textTheme.headline2,)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
              const SizedBox(height: 32,),
              // seemore
              Padding(
                padding:  EdgeInsets.only(right: bodyMargin,bottom: 8),
                child:  Row(
                  children: [
                    Image.asset('assets/icons/bluepen.png',color: SolidColors.seeMore,height: 28,),
                    const SizedBox(width: 8,),
                    Text(MyStrings.viewHotestBlog,style: textTheme.headline3,),
                  ],
                ),
              ),
              // blog list
              SizedBox(
                height: size.height/3.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: blogList.getRange(0, 5).length,
                    itemBuilder: (context, index) {
                    // blog item
                      return Padding(
                        padding:  EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: size.height/5.3,
                                width: size.width/2.4,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                                          image: DecorationImage(
                                              image: NetworkImage(blogList[index].imageUrl),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                      foregroundDecoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          gradient: LinearGradient(
                                              colors: GradiantColors.blogPost,
                                              begin: Alignment.centerRight,
                                              end: Alignment.topCenter
                                          )
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 8,
                                      left: 0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(blogList[index].writer,style: textTheme.subtitle1,),
                                          Row(
                                            children: [
                                              Text(blogList[index].views,style: textTheme.subtitle1,),
                                              const SizedBox(width: 8,),
                                              Icon(Icons.remove_red_eye_sharp,color: Colors.white,)
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
                                width: size.width/2.4,
                                child: Text(
                                    blogList[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                            ),
                          ],
                        ),
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
