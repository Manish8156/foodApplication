
import 'package:food_delivery/pages/auth/sing_in_page.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const AppTextField({Key? key, required this.hintText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onSaved:(newValue) {
         SignInPage.myemail=newValue!;
        } ,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon,color: AppColors.yellowColor),
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
    );
  }
}
