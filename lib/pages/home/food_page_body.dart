import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/populars_models.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController=PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height=Dimension.pageViewContainer;


  @override
  void initState()
  {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=pageController.page!;
        print("current page value is "+_currPageValue.toString());
      });
    });
  }

  @override
  void dispose()
  {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("current width is "+MediaQuery.of(context).size.width.toString());
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts)
        {
          return popularProducts.isLoad?Container(
            color: Colors.white,
            height: Dimension.pageView,
              child: PageView.builder(controller: pageController,
                itemCount: popularProducts.popularProductList.length,itemBuilder: (context, position) {
                  return _buildPageItem(position,popularProducts.popularProductList[position]);
                },),

          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),

    //dots
    GetBuilder<PopularProductController>(builder: (popularProducts){
      return  DotsIndicator(
        dotsCount: popularProducts.popularProductList.length<=0?1:popularProducts.popularProductList.length,
        position: _currPageValue,
        decorator: DotsDecorator(
          activeColor: AppColors.mainColor,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
    }),
        //popular text
        SizedBox(height: Dimension.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimension.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26),
              ),
              SizedBox(width: Dimension.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              )

            ],
          ),
        ),
        //list of food and images

          GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isLoad?ListView.builder(
              physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount:recommendedProduct.recommendedProductList.length,itemBuilder: (context, index) {
              return GestureDetector(onTap: () {
                Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
              },
                child: Container(
                  margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20,bottom: Dimension.height10),
                  child:  Row(
                    children: [
                      //image section
                      Container(
                        width:Dimension.listViewImgSize,
                        height: Dimension.listViewImgSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimension.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!),
                            )

                        ),
                      ),
                      //text container
                      Expanded(
                        child: Container(
                          height: Dimension.listViewTextContSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimension.radius20),
                                bottomRight: Radius.circular(Dimension.radius20),
                              ),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimension.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(height: Dimension.height10),
                                SmallText(text: "With Indian Characteristics"),
                                SizedBox(height: Dimension.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(icon: Icons.circle_sharp,
                                        text: "Normal",
                                        iconColor: AppColors.iconColor1),
                                    IconAndTextWidget(icon: Icons.location_on,
                                        text: "1.7km",
                                        iconColor: AppColors.mainColor),
                                    IconAndTextWidget(icon: Icons.access_time_rounded,
                                        text: "32min",
                                        iconColor: AppColors.iconColor2)

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              );
            },):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          }),

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct)
  {
    Matrix4 matrix=Matrix4.identity();
    if(index==_currPageValue.floor())
      {
        var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
        var currTrans=_height*(1-currScale)/2;
        matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

      }
    else if(index==_currPageValue.floor()+1)
      {
        var currScale=_scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
        var currTrans=_height*(1-currScale)/2;
        matrix=Matrix4.diagonal3Values(1, currScale, 1);
        matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      }
    else if(index==_currPageValue.floor()-1)
    {
      var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale=0.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));

            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(left: Dimension.width10,right: Dimension.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!),
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimension.width30,right: Dimension.width30,bottom: Dimension.height30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0),
                  )
                ],
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimension.height15,left: Dimension.height15,right: Dimension.height15),
                child: Column(
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => Icon(Icons.star,color: AppColors.mainColor,size: 15,))

                        ),
                        SizedBox(width: 10),
                        SmallText(text: "4.5"),
                        SizedBox(width: 10),
                        SmallText(text: "1287"),
                        SizedBox(width: 10),
                        SmallText(text: "comments")
                      ],
                    ),
                    SizedBox(height: Dimension.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2)

                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
