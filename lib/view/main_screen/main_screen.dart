import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/view/main_screen/profile_screen.dart';
import 'package:tec/view/register/register_intro.dart';


final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  final RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width/10;
    return  SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  _key.currentState!.openDrawer();
                },
                child: const Icon(Icons.menu,color: Colors.black,)),
              // Image(image: Assets.images.logo),
              Image.asset('assets/images/logo.png',height: size.height/13.6,),
              const Icon(Icons.search,color: Colors.black,)
            ],
          ),
          backgroundColor: SolidColors.scaffoldBg,
        ),
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                    child: Center(
                      child: Image.asset(
                        Assets.images.logo.path,
                        scale: 3,
                      ),
                    )),
                ListTile(
                  title: Text(
                    "پروفایل کاربری",
                    style: textTheme.headline4,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "درباره تک‌بلاگ",
                    style: textTheme.headline4,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "اشتراک گذاری تک بلاگ",
                    style: textTheme.headline4,
                  ),
                  onTap: () async {
                    await Share.share(MyStrings.shareText);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "تک‌بلاگ در گیت هاب",
                    style: textTheme.headline4,
                  ),
                  onTap: () {
                    myLaunchUrl(MyStrings.techBlogGithubUrl);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Obx(
                  ()=> IndexedStack(
                    index: selectedPageIndex.value,
                    children: [
                      HomeScreen(size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                      ProfileScreen(size: size, textTheme: textTheme, bodyMargin: bodyMargin)
                    ],
                  ),
                )
            ),
            BottomNavigation(
                size: size,
                bodyMargin: bodyMargin,
                changeScreen: (int value){
                  selectedPageIndex.value = value;
                },
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController(),permanent: false);
  BottomNavigation({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: size.height/10,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: GradiantColors.bottomNavBackground,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Padding(
          padding:  EdgeInsets.only(right: bodyMargin,left: bodyMargin),
          child: Container(
            height: size.height/8,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                gradient: LinearGradient(
                  colors: GradiantColors.bottomNav,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: ( () => changeScreen(0)),
                    icon: Image.asset('assets/icons/home.png')
                ),
                IconButton(
                    onPressed: (){
                      _registerController.toggleLogin();
                    },
                    icon: Image.asset('assets/icons/write.png')
                ),
                IconButton(
                    onPressed: ( () => changeScreen(1)),
                    icon: Image.asset('assets/icons/user.png')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


