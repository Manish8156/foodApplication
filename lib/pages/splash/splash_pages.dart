import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/pages/auth/sing_in_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  static final String KEYLOGIN="login";

  Future<void> _loadresources()
  async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState()
  {
    super.initState();
    _loadresources();
    controller= AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation= CurvedAnimation(parent: controller, curve: Curves.linear);
    WhereToGo();
  }




  void WhereToGo()
  async{
    var sharedPreferences=await SharedPreferences.getInstance();
    var islogIn=sharedPreferences.getBool(KEYLOGIN);

    Timer(
      const Duration(seconds: 3),() {
        print("shred value is $islogIn");
        if(islogIn!=null)
          {
            if(islogIn==true)
              {
                Get.off(HomePage());
              }
            else{
                  Get.off(SignInPage());
            }
          }
        else{
          Get.off(SignInPage());
        }
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,child: Center(child: Image.asset("assets/image/logo part 1.png",width: 250))),
          Center(child: Image.asset("assets/image/logo part 2.png",width: Dimension.splashing)),
        ],
      ),
    );
  }
}