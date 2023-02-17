import 'dart:developer';

import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/populars_models.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=> _recommendedProductList;
  bool _isLoading=false;
  bool get isLoad=>_isLoading;

  Future<void> getRecommendedProductList()async{
    Response response=await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200)
    {
      print("Got product  recommede");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoading=true;
      update(); // it is like setState
    }
    else{
      print("not happen recom"
          );

    }
  }
}