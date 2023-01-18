import 'package:get/get.dart';
import 'package:tec/route_manager/binding.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/view/splash_screen.dart';
import '../view/articles/manage_article_screen.dart';
import '../view/articles/single_manage_article_screen.dart';
import '../view/articles/single_screen.dart';
import '../view/main_screen/main_screen.dart';
import '../view/podcast/single_podcast_screen.dart';

class Pages{
  Pages._();
  static List<GetPage<dynamic>>  pages = [
    GetPage(name: NamedRoutes.initialRoute, page: () => SplashScreen()),
    GetPage(name: NamedRoutes.mainScreen, page: () => MainScreen(),binding: RegisterBinding()),
    GetPage(name: NamedRoutes.singleScreen, page: () => SingleScreen(),binding: ArticleBinding()),
    GetPage(name: NamedRoutes.manageArticleScreen, page: () => ManageArticleScreen(),binding: ArticleManagerBinding()),
    GetPage(name: NamedRoutes.singleManageArticleScreen, page: () => SingleManageArticleScreen(),binding: ArticleManagerBinding()),
    GetPage(name: NamedRoutes.singlePodcastScreen, page: () => SinglePodcastScreen(),)
  ];
}