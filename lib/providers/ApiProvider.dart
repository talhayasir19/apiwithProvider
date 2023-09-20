import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import '../models/food_items_model.dart';

class ApiProvider extends ChangeNotifier {
  static const apiEndPoint = "https://dummyjson.com/products";
  FoodItems foodItems = FoodItems();
  List<Products> listProducts = [];
  bool isLoading = true;
  String error = '';

  getAllData() async {
    try {
      Response response = await get(Uri.parse(apiEndPoint));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var productsListMap = data['products'];
        List<Products> dataList = [];
        for (var productmap in productsListMap) {
          dataList.add(Products.fromJson(productmap));
        }
        foodItems = FoodItems(
          total: data['total'],
          skip: data['skip'],
          limit: data['limit'],
          products: dataList,
        );

        print("Sucess");
        print(listProducts.length);
      } else {
        print("eroro");

        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
