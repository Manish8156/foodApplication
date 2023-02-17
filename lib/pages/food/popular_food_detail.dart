import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

import '../../routes/route_helper.dart';
class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

   PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    //print("page id is $pageId");
    //print("product name is "+product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
       children: [
         Positioned(
           left: 0,
           right: 0,
           child: Container(
             width: double.maxFinite,
             height: Dimension.popularFoodImgSize,
             decoration: BoxDecoration(
               image: DecorationImage(
                 fit: BoxFit.cover,
                 image: NetworkImage(
                   AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                 ),
               )
             ),
           ),
         ),
         //background image
         Positioned(
           top: Dimension.height45,
             left: Dimension.width20,
             right: Dimension.width20,

             child: Row(
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
                 },child: AppIcon(icon: Icons.arrow_back_ios)),
                 GetBuilder<PopularProductController>(builder: (controller){
                   return GestureDetector(
                       onTap: () {
                         //print("tapped here");
                         if(controller.totalItems>=1)
                         Get.toNamed(RouteHelper.getCartPage());
                       },
                     child: Stack(
                       children: [
                         AppIcon(icon: Icons.shopping_cart_outlined),
                         controller.totalItems>=1?
                         Positioned(right: 0,top: 0,
                               child: AppIcon(
                                 icon: Icons.circle,size: 20,iconColor: Colors.transparent,backGroundColor: AppColors.mainColor,),
                             ):
                         Container(),

                         Get.find<PopularProductController>().totalItems>=1?
                         Positioned(right: 4.5,top: 4
                             ,child: BigText(
                               text: Get.find<PopularProductController>().totalItems.toString() ,
                               size: 10,color: Colors.white,
                             )):
                         Container()

                       ],

                     ),
                   );
                 },)

               ],
             )),
         //Icon image
         Positioned(
           left: 0,
           right: 0,
             bottom: 0,
             top: Dimension.popularFoodImgSize-20,
           child: Container(
             padding: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20,top: Dimension.height20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topRight: Radius.circular(Dimension.radius20),
                   topLeft: Radius.circular(Dimension.radius20)),
               color: Colors.white ,

             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 AppColumn(text: product.name),
                 SizedBox(height: Dimension.height20,),
                 BigText(text: "Introduce"),
                 SizedBox(height: Dimension.height20,),
                 Expanded(
                   child: SingleChildScrollView(
                       child: ExpandableTextWidget(
                           text: product.description!)),
                 )
               ],
             ),

           ),
         ),

       ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
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
                child: Row(
                  children: [
                    GestureDetector(onTap: () {
                      popularProduct.setQuantity(false);
                      print("Decrement");
                    },child: Icon(Icons.remove,color: AppColors.signColor)),
                    SizedBox(width: Dimension.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimension.width10/2,),
                    GestureDetector(onTap: () {
                      popularProduct.setQuantity(true);
                      print("increment");

                    }
                        ,child: Icon(Icons.add,color: AppColors.signColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                popularProduct.addItem(product);
              },
                child: Container(
                  padding: EdgeInsets.only(top: Dimension.height20,bottom: Dimension.height20,left: Dimension.width20,right: Dimension.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}

 