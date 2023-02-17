import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

import '../../controllers/cart_controller.dart';
class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  GestureDetector(onTap: () {

                    if(page=="cartPage")
                    {
                      Get.toNamed(RouteHelper.cartPage);
                    }
                    else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },child: AppIcon(icon: Icons.clear,backGroundColor: Colors.black26)),
                // AppIcon(icon: Icons.shopping_cart_outlined,backGroundColor: Colors.black26,)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: () {
                      //print("tapped here");
                      if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,backGroundColor: Colors.black26,),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(right: 0,top: 0,
                              child: AppIcon(
                                icon: Icons.circle,size: 20,iconColor: Colors.transparent,backGroundColor: AppColors.mainColor,),
                            ):
                        Container(),

                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(right: 4.2,top: 4
                            ,child: BigText(
                              text: Get.find<PopularProductController>().totalItems.toString() ,
                              size: 12,color: Colors.black,
                            )):
                        Container()

                      ],

                    ),
                  );
                },)

              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                  child: BigText(size: Dimension.font26,text:product.name!),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimension.radius20),topRight: Radius.circular(Dimension.radius20))
                ),
              ),

            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                ,width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin:EdgeInsets.only(left: Dimension.width20,right: Dimension.width20)
                  ,child: ExpandableTextWidget(text: product.description!),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimension.width20*2,
                  right: Dimension.width20*2,
                  top: Dimension.height10,
                  bottom: Dimension.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () {
                    controller.setQuantity(false);
                  },
                    child: AppIcon(icon: Icons.remove,
                        iconSize: Dimension.iconsize24,
                        backGroundColor: AppColors.mainColor,iconColor: Colors.white),
                  ),
                  BigText(text: "\$ ${product.price!} X  ${controller.inCartItems} ",color: AppColors.mainBlackColor,size: Dimension.font26),

                  GestureDetector(onTap: () {
                    controller.setQuantity(true);
                  },
                    child: AppIcon(icon: Icons.add,
                        iconSize: Dimension.iconsize24,
                        backGroundColor: AppColors.mainColor,iconColor: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimension.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimension.height30,bottom: Dimension.height30,left: Dimension.width20,right: Dimension.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroungColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20*2),
                    topRight: Radius.circular(Dimension.radius20*2)),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimension.height20,bottom: Dimension.height20,left: Dimension.width20,right: Dimension.width20),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(onTap: () {
                    controller.addItem(product);
                  },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimension.height20,bottom: Dimension.height20,left: Dimension.width20,right: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(text: "\$${product.price!} | Add to cart",color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
