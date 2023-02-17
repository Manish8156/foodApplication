import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/big_text.dart';
class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =Get.find<CartController>().GetCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOrder=Map();
    for(int i=0;i<getCartHistoryList.length;i++)
    {
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time))
      {
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);

      }else
      {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }

    }

    List<int> cartItemsPerOrderToList()
    {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList()
    {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }


    List<int> itemsPerorder=cartItemsPerOrderToList();

    var listCounter=0;

   Widget timeWidget(int index)
    {
      var outputDate=DateTime.now().toString();
      if(index<getCartHistoryList.length)
        {
          DateTime parseData=DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
          var inputDate=DateTime.parse(parseData.toString());
          var outputFormat=DateFormat("MM/dd/yy hh:mm a");
           outputDate=outputFormat.format(inputDate);
        }
      return BigText(text: outputDate);
    }


    return Scaffold(
       body: Column(
         children: [
           Container(
             height: Dimension.height10*10,
             color: AppColors.mainColor,
             width: double.maxFinite,
             padding: EdgeInsets.only(top: Dimension.height45),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 BigText(text: "Cart History",color: Colors.white,),
                 AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,backGroundColor: AppColors.yellowColor),

               ],
             ),
           ),
           GetBuilder<CartController>(builder: (_cartController) {
             return _cartController.GetCartHistoryList().length>0?Expanded(
               child: Container(

                   margin: EdgeInsets.only(
                     top: Dimension.height20,
                     left: Dimension.width20,
                     right: Dimension.width20,
                   ),
                   child: MediaQuery.removePadding(
                       removeTop: true,
                       context: context,
                       child: ListView(
                         children: [
                           for(int i=0;i<itemsPerorder.length;i++)
                             Container(
                               height: Dimension.height30*4,
                               margin: EdgeInsets.only(bottom: Dimension.height20),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   timeWidget(listCounter),

                                   SizedBox(height: Dimension.height10),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Wrap(
                                         direction: Axis.horizontal,
                                         children: List.generate(itemsPerorder[i], (index) {
                                           if(listCounter<getCartHistoryList.length)
                                           {
                                             listCounter++;
                                           }
                                           return index<=2?Container(
                                             height: Dimension.height20*3.5,
                                             width: Dimension.height20*3.5,
                                             margin: EdgeInsets.only(right: Dimension.width10/2),
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                                 image: DecorationImage(
                                                     fit: BoxFit.cover,
                                                     image: NetworkImage(
                                                         AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                                     )
                                                 )
                                             ),

                                           ):Container();
                                         }),
                                       ),
                                       Container(

                                         height: 80,
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             SmallText(text: "Total",color: AppColors.textColor),
                                             BigText(text: itemsPerorder[i].toString()+" Items",),
                                             GestureDetector(
                                               onTap: () {
                                                 var orderTime=cartOrderTimeToList();
                                                 Map<int, CartModel> morOrder={};
                                                 for(int j=0;j<getCartHistoryList.length;j++)
                                                 {
                                                   if(getCartHistoryList[j].time==orderTime[i])
                                                   {
                                                     morOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                         CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                     );
                                                   }
                                                 }
                                                 Get.find<CartController>().setItems=morOrder;
                                                 Get.find<CartController>().addToCartList();
                                                 Get.toNamed(RouteHelper.getCartPage());
                                               },
                                               child: Container(
                                                 padding: EdgeInsets.symmetric(horizontal: Dimension.width10,vertical: Dimension.height10/2) ,
                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimension.radius15/3),border: Border.all(width: 1,color: AppColors.mainColor)),
                                                 child: SmallText(text: "one more",color: AppColors.mainColor),
                                               ),
                                             )
                                           ],
                                         ),
                                       )

                                     ],
                                   )
                                 ],
                               ),

                             )
                         ],
                       ))
               ),
             )
                 :SizedBox(
                  height:MediaQuery.of(context).size.height/1.5,
                 child: Container(
                     child: Center(
                         child: NoDataPage(text: "You didn't buy anything so far",imgPath: "assets/image/empty_box.png",))));
           },)
         ],

       ),
    );
  }
}
