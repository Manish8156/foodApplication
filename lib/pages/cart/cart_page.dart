import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/payment/upi_pay.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:upi_india/upi_india.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimension.height20 * 3,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconsize24,
                  ),
                  SizedBox(
                    width: Dimension.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backGroundColor: AppColors.mainColor,
                      iconSize: Dimension.iconsize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconsize24,
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length>0?Positioned(
                top: Dimension.height20 * 5,
                left: Dimension.width20,
                right: Dimension.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimension.height15
                  ),
                  //color: Colors.blue,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController) {
                        var _cartList=cartController.getItems;
                        return ListView.builder(
                          itemCount: _cartList.length, itemBuilder: (context, _index) {
                          return Container(
                            height: Dimension.height20*5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex=Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[_index].product!);
                                    if(popularIndex>=0)
                                    {
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartPage"));
                                    }else{
                                      var recommendedIndex=Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[_index].product!);
                                      // print("new val"+recommendedIndex.toString());
                                      if(recommendedIndex<0){
                                        Get.snackbar("History product", " Product review is not available for history products",
                                          backgroundColor: AppColors.mainColor,
                                          colorText: Colors.white,);
                                      }else{
                                        Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartPage"));
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: Dimension.height10
                                    ),
                                    width: Dimension.height20*5,
                                    height: Dimension.height20*5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[_index].img!,
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(Dimension.radius20),
                                        color: Colors.white
                                    ),

                                  ),
                                ),
                                SizedBox(
                                  width: Dimension.width10,
                                ),
                                Expanded(child: Container(
                                  height: Dimension.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[_index].name!,color: Colors.black54,),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[_index].price.toString(),color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimension.height10,bottom: Dimension.height10,left: Dimension.width10,right: Dimension.width10),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimension.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(onTap: () {
                                                  cartController.addItem(_cartList[_index].product!, -1);
                                                },child: Icon(Icons.remove,color: AppColors.signColor)),
                                                SizedBox(width: Dimension.width10/2,),
                                                BigText(text: _cartList[_index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                SizedBox(width: Dimension.width10/2,),
                                                GestureDetector(onTap: () {
                                                  cartController.addItem(_cartList[_index].product!, 1);
                                                  print("tappped");

                                                }
                                                    ,child: Icon(Icons.add,color: AppColors.signColor,)),
                                              ],
                                            ),
                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),

                          );


                        },);
                      },)
                  ),
                )):NoDataPage(text: "Your Cart is empty!");
          },)
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimension.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimension.height30,bottom: Dimension.height30,left: Dimension.width20,right: Dimension.width20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroungColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.radius20*2),
                topRight: Radius.circular(Dimension.radius20*2)),

          ),
          child: cartController.getItems.length>0?Row(
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

                    SizedBox(width: Dimension.width10/2,),
                    BigText(text: "\$ "+cartController.totalAmount.toString()),
                    SizedBox(width: Dimension.width10/2,),

                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //popularProduct.addItem(product);
                  print("tapped");
                  cartController.addToHistory();




                },
                child: GestureDetector(
                  onTap: () {
                    cartController.addToHistory();
                   Get.off( UpiPay());

                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimension.height20,bottom: Dimension.height20,left: Dimension.width20,right: Dimension.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(text: "Check Out",color: Colors.white,),
                  ),
                ),
              )
            ],
          ):Container(),
        );
      },),


    );
  }
}
