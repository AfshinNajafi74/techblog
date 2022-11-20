import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/tcbot.svg',height: 100,),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        text: MyStrings.welcome,
                        style: textTheme.headline4
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ElevatedButton(
                      onPressed: (){
                        _showEmailBottomSheet(context, size, textTheme);
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
                      child: const Text('بزن بریم',),
                  ),
                )
              ],
            ),
          ),
        ) 
    );
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyStrings.insertYourEmail,
                      style: textTheme.headline4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: TextField(
                        controller: registerController.emailTextEditingController,
                        onChanged: (value) {

                        },
                        style: textTheme.headline5,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "techblog@gmail.com",
                          hintStyle: textTheme.headline5,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() async{
                        registerController.register();
                        Get.back();
                        _activateCodeBottomSheet(context, size, textTheme);
                      }),
                      child: const Text("ادامه"),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }

  Future<dynamic> _activateCodeBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: ((context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Container(
              height: size.height / 2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.activateCode,
                        style: textTheme.headline4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextField(
                          controller: registerController.activeCodeTextEditingController,
                          onChanged: (value) {

                          },
                          style: textTheme.headline5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "******",
                              hintStyle: textTheme.headline5),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (() {
                            registerController.verify();
                          }),
                          child: const Text("ادامه"))
                    ]),
              ),
            ),
          );
        }));
  }
}