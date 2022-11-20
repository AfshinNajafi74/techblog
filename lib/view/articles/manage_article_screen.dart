import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_strings.dart';
import 'package:tec/controller/register_controller.dart';


class ManageArticleScreen extends StatelessWidget{

  final RegisterController registerController = Get.find<RegisterController>();

  ManageArticleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: appBar("مدیریت مقاله ها"),
          body: articleEmptyState(textTheme),
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
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ElevatedButton(
                    onPressed: (){

                    },
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return textTheme.headline1;
                      }
                      return textTheme.subtitle1;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return SolidColors.seeMore;
                      }
                      return SolidColors.primaryColor;
                    })
                  ),
                    child: const Text('بریم برای نوشتن یه مقاله باحال',),
                ),
              )
            ],
          ),
        );
  }

}