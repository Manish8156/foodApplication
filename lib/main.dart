import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/pages/auth/sing_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_pages.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main()
async {

  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          debugShowCheckedModeBanner: false,
          title: "flutter Demo",
          // home: SignInPage(),    // problem is in singinPage AUtomatic back in main page?
        );
      });
    },);
  }
}
