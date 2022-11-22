import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

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
    var response = await DioService().getMethod("${ApiConstant.publishedByMe}1");
    if(response.statusCode == 200){
      response.data.forEach((element){
        articleList.add(ArticleModel.fromJson(element));
      });
      // articleList.clear();
      loading.value = false;
    }

  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }
}