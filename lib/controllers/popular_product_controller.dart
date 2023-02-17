import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/populars_models.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=> _popularProductList;
  late CartController _cart;
  bool _isLoading=false;
  bool get isLoad=>_isLoading;
  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItem=0;
  int get inCartItems=>_inCartItem+_quantity;

  Future<void> getPopularProductList()async{
    Response response=await popularProductRepo.getPopularProductList();
    if(response.statusCode==200)
      {
        _popularProductList=[];
       _popularProductList.addAll(Product.fromJson(response.body).products);
       // print(_popularProductList);
       _isLoading=true;
        update(); // it is like setState
      }
    else{
      print("not happen");

    }
  }

  void setQuantity(bool isIncrement)
  {
    if(isIncrement)
      {
        _quantity=checkQuantity(_quantity+1);
        print("number of items"+quantity.toString());

      }
    else
      {
        _quantity=checkQuantity(_quantity-1);

      }
    update();
  }

 int checkQuantity(int quantity)
  {
    if(_inCartItem+quantity<0)
      {
        Get.snackbar("item count", " you can't reduce more !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,

        );
        if(_inCartItem>0)
          {
            _quantity=-_inCartItem;
            return _quantity;
          }
        return 0;
      }
    else{
      if(_inCartItem+quantity>20)
        {
          Get.snackbar("item count", " you can't add more !",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white,

          );
          return 20;
        }
      else{
        return quantity;
      }
    }
  }

  void initProduct(ProductModel product,CartController cart)
  {
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    print("exits or not "+exist.toString());
    if(exist)
      {
        _inCartItem=_cart.getQuantity(product);
      }
    print("the quantity in the cart is "+_inCartItem.toString());
    //get from Storage;
  }
  void addItem(ProductModel product)
  {
    // if(_quantity>0){
    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItem=_cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print(" the id is"+value.id.toString()+"the quantity is "+ value.id.toString());
    });
    update();

  }
  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;

  }

}
