import 'package:get/get.dart';
class Dimension{
  static double screenHeight=Get.context!.height;
  static double screenwidth=Get.context!.width;

  static double pageView=screenHeight/2.3625;
//756/320=
  static double pageViewContainer=screenHeight/3.43;
 // 756/220=3.43
  static double pageViewTextContainer=screenHeight/6.3;
  //756/120=6.3

  //dynamic height padding and margin
  static double height10=screenHeight/75.6;
  //756/10=75.6
  static double height20=screenHeight/37.8;
  //756/20=37.8
  static double height15=screenHeight/50.4;
  static double height30=screenHeight/25.2;
  //756/15=25.2
  static double height45=screenHeight/16.8;
  //756/15=16.8

  //dynamic width padding and margin
  static double width10=screenHeight/75.6;
  //756/10=75.6
  static double width20=screenHeight/37.8;
  //756/20=37.8
  static double width15=screenHeight/50.4;
  //756/15=50.4
  static double width30=screenHeight/25.2;
  //756/15=25.2

  static double font20=screenHeight/37.8;
//756/20=37.8
  static double font26=screenHeight/29.07;
      //756/26=29.07
  static double font16=screenHeight/47.25;
  //756/16=47.25

  //radius in dynamic
  static double radius20=screenHeight/37.8;
//756/20=37.8
  static double radius30=screenHeight/25.2;
//756/20=25.2
  static double radius15=screenHeight/50.4;
//756/15=50.4
  static double iconsize24=screenHeight/31.5;
  //756/24=31.5
  static double iconsize16= screenHeight/47.25;

//756/16=47.25

   //list veiw of size
static double listViewImgSize= screenwidth/3.4285;
//411.42/120=3.4285
static double listViewTextContSize=screenwidth/4.1;
//411.42/100=4.1;

static double popularFoodImgSize=screenHeight/2.16;
//756/350=2.16


//bottom heihgt
static double bottomHeightBar=screenHeight/6.3;
//756/120=6.3

//splashscreen animation
static double splashing=screenHeight/3.024;
//756/250=3.04


}