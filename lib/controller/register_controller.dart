import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/services/dio_service.dart';

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
  }
}