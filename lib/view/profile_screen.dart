import 'package:flutter/material.dart';
import 'package:tec/models/fake_data.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/my_component.dart';
import 'package:tec/my_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/profileAvatar.png',height: 100,),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/bluepen.png',color: SolidColors.seeMore,height: 30,),
              const SizedBox(width: 8,),
              Text(MyStrings.imageProfileEdit,style: textTheme.headline3,)
            ],
          ),
          const SizedBox(height: 60,),
          Text('فاطمه امیری',style: textTheme.headline4,),
          Text('afshinnajafi74@gmail.com',style: textTheme.headline4,),
          const SizedBox(height: 40,),
          TecDivider(size: size),
          InkWell(
            splashColor: SolidColors.primaryColor,
            onTap: (){},
            child: SizedBox(
                height: 45,
                child: Center(
                    child: Text(MyStrings.myFavBlog,style: textTheme.headline4,)
                )
            ),
          ),
          TecDivider(size: size),
          InkWell(
            splashColor: SolidColors.primaryColor,
            onTap: (){},
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(MyStrings.myFavPodcast,style: textTheme.headline4,),
              ),
            ),
          ),
          TecDivider(size: size),
          InkWell(
            onTap: (){},
            splashColor: SolidColors.primaryColor,
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(MyStrings.logOut,style: textTheme.headline4,),
              ),
            ),
          ),
          const SizedBox(height: 60,),
        ],
      ),
    );
  }
}


