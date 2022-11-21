import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/main.dart';
import 'package:tec/services/dio_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';
import '../gen/assets.gen.dart';

class RegisterController extends GetxController{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController = TextEditingController();
  var email = "";
  var userId = "";

  register() async {
    Map<String,dynamic> map = {
      "email" : emailTextEditingController.text,
      "command" : "register"
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = response.data["user_id"];
    debugPrint(response.toString());
  }

  verify() async {
    Map<String,dynamic> map = {
      "email" : email,
      "user_id" : userId,
      "code" : activeCodeTextEditingController.text,
      "command" : "verify"
    };
    debugPrint(map.toString());
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    debugPrint(response.data.toString());

    var status = response.data["response"];
    switch(status){
      case "verified":
        var box = GetStorage();
        box.write(StorageKey.token, response.data["token"]);
        box.write(StorageKey.userId, response.data["user_id"]);
        // debugPrint("READ :::: ${box.read(StorageKey.token)}");
        // debugPrint("READ :::: ${box.read(StorageKey.userId)}");
        Get.offAll(MainScreen());
        break;
      case "incorrect_code":
        Get.snackbar("خطا", "کد فعالسازی غلط است");
        break;
      case "expired":
        Get.snackbar("خطا", "کد فعالسازی منقضی شده است");
        break;
    }
  }

  toggleLogin(){
    if(GetStorage().read(StorageKey.token) == null){
      Get.to(RegisterIntro());
    }else{
      routeToWriteBottomSheet();
    }
  }

  routeToWriteBottomSheet(){
    Get.bottomSheet(
      Container(
        height: Get.height / 3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.images.tcbot,height: 40,),
                  const SizedBox(width: 8,),
                  const Text("دونسته هات رو با بقیه به اشتراک بذار ...")
                ],
              ),
              const SizedBox(height: 8,),
              const Text("""
فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار.."""),
              const SizedBox(height: 28,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("write article");
                      Get.toNamed(NamedRoutes.manageArticleScreen);
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Image.asset("assets/icons/write_article_icon.png",height: 32,),
                          const SizedBox(width: 8,),
                          const Text("مدیریت مقاله ها")
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("write podcast");
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Image.asset("assets/icons/write_podcast_icon.png",height: 32,),
                          const SizedBox(width: 8,),
                          const Text("مدیریت پادکست ها")
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}