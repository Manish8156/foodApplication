import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList)
  {
    // sharedPreferences.remove(AppConstants.Cart_List);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time=DateTime.now().toString();
    cart=[];
    // convert object to String because shared preference only accept string
    cartList.forEach((element) {
      element.time=time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.Cart_List, cart);
    print(sharedPreferences.getStringList(AppConstants.Cart_List));
    getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.Cart_List))
      {
        carts=sharedPreferences.getStringList(AppConstants.Cart_List)!;
        print("inside getCartList"+carts.toString());
      }
    List<CartModel> cartList=[];
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList()
  {
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST))
    {
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
  List<CartModel> cartListHistory=[];
  cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
  return cartListHistory;
  }

  void addToCartHistoryList()
  {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST))
      {
        cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      }
    for(int i=0;i<cart.length;i++)
      {
       // print("history list"+cart[i]);
        cartHistory.add(cart[i]);
      }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the lenggth is "+getCartHistoryList().length.toString());
    for(int j=0;j<getCartHistoryList().length;j++)
      {
        print("the time for order"+getCartHistoryList()[j].time.toString()
        );
      }
  }
  void removeCart()
  {
    cart=[];
    sharedPreferences.remove(AppConstants.Cart_List);

  }
  

}