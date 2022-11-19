import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/services/dio_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/view/main_screen/main_screen.dart';

class RegisterController extends GetxController{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController = TextEditingController();
  var email = "";
  var user_id = "";

  register() async {
    Map<String,dynamic> map = {
      "email" : emailTextEditingController.text,
      "command" : "register"
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    user_id = response.data["user_id"];
    print(response);
  }

  verify() async {
    Map<String,dynamic> map = {
      "email" : email,
      "user_id" : user_id,
      "code" : activeCodeTextEditingController.text,
      "command" : "verify"
    };
    print(map);
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    print(response.data);

    if(response.data["response"] == "verify"){
      var box = GetStorage();
      box.write(token, response.data["token"]);
      box.write(userId, response.data["user_id"]);
      print("READ :::: ${box.read(token)}");
      print("READ :::: ${box.read(userId)}");
      Get.to(MainScreen());
    }else{
      log('error == error ');
    }

  }
}