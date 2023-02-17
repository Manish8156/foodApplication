import 'package:food_delivery/pages/splash/splash_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_text_feild.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInPage extends StatefulWidget {
  static String myemail='',mypassword='';
  const SignInPage({Key? key,}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  // var namecontroller=TextEditingController();
  // var phonecontroller=TextEditingController();
  final formState = GlobalKey<FormState>();

  Future signin()
  async{
    if(formState.currentState!.validate())
      {
        return await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) async {
          print("value is sing in $value.");
          var sharedPreferences =await SharedPreferences.getInstance();
          sharedPreferences.setBool(SplashScreenState.KEYLOGIN, true);
          Get.offNamed(RouteHelper.initial);
        },);
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(

          children: [
            SizedBox(
              height: Dimension.screenHeight*0.05,
            ),
            Container(
              height: Dimension.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/logo part 1.png",
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimension.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello",style: TextStyle(
                    fontSize: Dimension.font20*3+Dimension.font20/2,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("Sign into your account",style: TextStyle(
                    // fontSize: Dimension.font20*3+Dimension.font20/2,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[500]
                  ),)
                ],
              ),
            ),




            Container(
              child: Form(key:formState ,child: Column(
                children: [
                  SizedBox(height: Dimension.height20),
                  Container(
                    margin: EdgeInsets.only(left: Dimension.height20,right: Dimension.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,10),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          {
                            Get.snackbar(backgroundColor: AppColors.mainColor,"Error", "please enter your correct login detail");
                          }
                      },
                      controller: emailcontroller ,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email,color: AppColors.yellowColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimension.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,

                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimension.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,

                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimension.radius30),

                          )


                      ),

                    ),
                  ),
                  SizedBox(height: Dimension.height20,),
                  Container(
                    margin: EdgeInsets.only(left: Dimension.height20,right: Dimension.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,10),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                        {
                          Get.snackbar(backgroundColor: AppColors.mainColor,"Error", "please enter your correct login detail");
                        }
                      },
                      controller: passwordcontroller ,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password,color: AppColors.yellowColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimension.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,

                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimension.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,

                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimension.radius30),

                          )


                      ),

                    ),
                  ),
                  SizedBox(
                    height: Dimension.height20,
                  )
                ],
              )),
            ),






            Row(
              children: [
                Expanded(child: Container()),
                RichText(text: TextSpan(

                    text: "sing into your account",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimension.font20
                    )
                )),
                SizedBox(
                  width: Dimension.width20,
                )
              ],
            ),
            SizedBox(
              height: Dimension.screenHeight*0.05,
            ),
            GestureDetector(
              onTap: () =>{},
              child: GestureDetector(
                onTap: () => signin(),
                child: Container(
                  width: Dimension.screenwidth/2,
                  height: Dimension.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign in",
                      size: Dimension.font20+Dimension.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimension.screenHeight*0.05,
            ),
            RichText(text: TextSpan(
                text: "Don 't an account? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimension.font20,
                ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                text: "Create",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlackColor,
                  fontSize: Dimension.font20,
                )),

              ]
            )),



          ],
        ),
      ),

    );
  }
}
