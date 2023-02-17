import 'package:flutter/material.dart';

import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  // Razorpay _razorpay = Razorpay();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  // }

  // @override
  // void dispose() {
  //   _razorpay.clear();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    print("current height is" + MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          //showing the header
          // ElevatedButton(
          //     onPressed: () {
          //       _razorpay.open({
          //         'key': 'rzp_test_cbBWhlQYTkmeM3',
          //         'amount': 100,
          //         'name': 'Acme Corp.',
          //         'description': 'Fine T-Shirt',
          //         'prefill': {
          //           'contact': '8888888888',
          //           'email': 'test@razorpay.com'
          //         }
          //       });
          //     },
          //     child: Text('PAY NOW')),
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimension.height45, bottom: Dimension.height15),
              padding: EdgeInsets.only(
                  left: Dimension.width20, right: Dimension.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "India", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: 'Surat', color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimension.height45,
                      height: Dimension.height45,
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimension.iconsize24),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius15),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ),
          //showing the body
          Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}
