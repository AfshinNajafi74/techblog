import 'package:flutter/material.dart';
import 'package:tec/my_colors.dart';

class MainScreen extends StatelessWidget {
  TextEditingController instagram = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(0,16,0,0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.menu),
                  // Image(image: Assets.images.logo),
                  Image.asset('assets/images/logo.png',height: size.height/13.6,),
                  Icon(Icons.search)
                ],
              ),
              const SizedBox(height: 8,),
              Stack(
                children: [
                  Container(
                    width: size.width/1.25,
                    height: size.height/4.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        // image: Image(image: Assets.images.logo,).image,
                        image: Image.asset('assets/images/poster_test.png').image,
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
                            Text('ملیکا عزیزی - یک روز پیش',style: textTheme.subtitle1,),
                            Text('Like 253',style: textTheme.subtitle1,)
                          ],
                        ),
                        Text('دوازده قدم برنامه نویسی یک دوره ی . . . س',style: textTheme.headline1,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
