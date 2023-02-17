import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_text_feild.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash/splash_pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();

  signUp() async{
    if(_formKey.currentState!.validate())
      {
        FirebaseAuth userSign=FirebaseAuth.instance;
        userSign.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text)
            .then((value) async {

              value.user!.updateProfile(displayName: namecontroller.text);
          var sharedPreferences =await SharedPreferences.getInstance();
          sharedPreferences.setBool(SplashScreenState.KEYLOGIN, true);
          print("created new account");
          Get.offNamed(RouteHelper.initial);

        },).onError((error, stackTrace)  {
          print("Error ${error.toString()}");
        });
      }
  }

  var singUpImages = [
    "t.png",
    "f.png",
    "g.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Form(key: _formKey,child: Column(
              children: [
                SizedBox(
                  height: Dimension.screenHeight * 0.05,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: Dimension.screenHeight * 0.25,
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
                        margin: EdgeInsets.only(
                            left: Dimension.height20, right: Dimension.height20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimension.radius30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 10),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              Get.snackbar(backgroundColor: AppColors.mainColor,"Error", "please enter your detail");
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "email",
                              prefixIcon:
                                  Icon(Icons.mail, color: AppColors.yellowColor),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimension.radius30),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Colors.white,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimension.radius30),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Colors.white,
                                  )),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius30),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Dimension.height20, right: Dimension.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextFormField(
                    controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                        {
                          Get.snackbar(backgroundColor: AppColors.mainColor,"Error", "please enter your detail");
                        }
                      },
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon:
                            Icon(Icons.password, color: AppColors.yellowColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimension.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimension.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.radius30),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Dimension.height20, right: Dimension.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextFormField(
                    controller: namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                      {
                        Get.snackbar(backgroundColor: AppColors.mainColor,"Error", "please enter your detail");
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "name",
                        prefixIcon:
                        Icon(Icons.mail, color: AppColors.yellowColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(Dimension.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(Dimension.radius30),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            )),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(Dimension.radius30),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                // Container(
                //   margin: EdgeInsets.only(left: Dimension.height20,right: Dimension.height20),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(Dimension.radius30),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             blurRadius: 10,
                //             spreadRadius: 7,
                //             offset: Offset(1,10),
                //             color: Colors.grey.withOpacity(0.2)
                //         )
                //       ]
                //   ),
                //   child: TextFormField(
                //     onSaved:(newValue) {
                //       _name=newValue!;
                //     } ,
                //     decoration: InputDecoration(
                //         hintText: "Name",
                //         prefixIcon: Icon(Icons.person,color: AppColors.yellowColor),
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(Dimension.radius30),
                //             borderSide: BorderSide(
                //               width: 1.0,
                //               color: Colors.white,
                //
                //             )
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(Dimension.radius30),
                //             borderSide: BorderSide(
                //               width: 1.0,
                //               color: Colors.white,
                //
                //             )
                //         ),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(Dimension.radius30),
                //
                //         )
                //
                //
                //     ),
                //
                //   ),
                // ),
                SizedBox(
                  height: Dimension.height20,
                ),
                // Container(
                //   margin: EdgeInsets.only(left: Dimension.height20,right: Dimension.height20),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(Dimension.radius30),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             blurRadius: 10,
                //             spreadRadius: 7,
                //             offset: Offset(1,10),
                //             color: Colors.grey.withOpacity(0.2)
                //         )
                //       ]
                //   ),
                //   child: TextFormField(
                //     onSaved:(newValue) {
                //       _phone=newValue!;
                //     } ,
                //     decoration: InputDecoration(
                //         hintText: "Phone",
                //         prefixIcon: Icon(Icons.phone,color: AppColors.yellowColor),
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(Dimension.radius30),
                //             borderSide: BorderSide(
                //               width: 1.0,
                //               color: Colors.white,
                //
                //             )
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(Dimension.radius30),
                //             borderSide: BorderSide(
                //               width: 1.0,
                //               color: Colors.white,
                //
                //             )
                //         ),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(Dimension.radius30),
                //
                //         )
                //
                //
                //     ),
                //
                //   ),
                // ),
                SizedBox(
                  height: Dimension.height20 + Dimension.height20,
                ),

                Container(
                  width: Dimension.screenwidth / 2,
                  height: Dimension.screenHeight / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: GestureDetector(
                    onTap: () => signUp(),
                    child: Center(
                      child: BigText(
                        text: "Sign up",
                        size: Dimension.font20 + Dimension.font20 / 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Dimension.height10,
                ),
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Dimension.font20))),
                SizedBox(
                  height: Dimension.screenHeight * 0.05,
                ),
                RichText(
                    text: TextSpan(
                        text: "Sign up using one of the following methods",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font16,
                        ))),
                Wrap(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimension.radius30,
                              backgroundImage:
                                  AssetImage("assets/image/" + singUpImages[index]),
                            ),
                          )),
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
