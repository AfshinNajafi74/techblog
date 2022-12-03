import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/command.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import 'package:dio/dio.dart' as dio;

class ManageArticleController extends GetxController{
  TextEditingController titleTextEditingController = TextEditingController();
  RxList<ArticleModel> articleList = RxList.empty();
  RxBool loading = false.obs;
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    title: "اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن",
    content: """
    من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی
    """,
    image: ""
  ).obs;
  RxList<TagsModel> tagList = RxList();


  @override
  onInit(){
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;
    // var response = await DioService().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var response = await DioService().getMethod("${ApiUrlConstant.publishedByMe}17");
    if(response.statusCode == 200){
      response.data.forEach((element){
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }

  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }


  Future<dynamic> storeArticle() async{
    FilePickerController filePickerController = Get.find<FilePickerController>();
    loading.value = true;
    Map<String,dynamic> map = {
      ApiArticleKeyConstant.title : articleInfoModel.value.title,
      ApiArticleKeyConstant.content : articleInfoModel.value.content,
      ApiArticleKeyConstant.catId : articleInfoModel.value.catId,
      ApiArticleKeyConstant.userId : GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image : await dio.MultipartFile.fromFile(filePickerController.file.value.path!),
      ApiArticleKeyConstant.command : Commands.store,
      ApiArticleKeyConstant.tagList : "[]",
    };
    var response = await DioService().postMethod(map, ApiUrlConstant.articlePost);
    log(response.data);
    loading.value = false;
  }
}