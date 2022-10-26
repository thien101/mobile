import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list = [];
  List<ProductModel> listCart = [];
  void getList() async {
    //lay ds san pham tu FakeStoreAPI
    String urlAPI = 'https://fakestoreapi.com/products';
    var client = http.Client();
    var rs = await client.get(Uri.parse(urlAPI));
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString) as List;
    //print(jsonString);
    list = jsonObject.map((e) {
      //print(e);
      return ProductModel(
        id: e['id'],
        title: e['title'],
        price: e['price'],
        description: e['description'],
        category: e['category'],
        image: e['image'],
      );
    }).toList();

    notifyListeners();
  }

  void getListCart(ProductModel e) {
    //lay ds san pham tu FakeStoreAPI
    /*if (listCart.isEmpty) {
      listCart.add(e);
    } else if (listCart.every((element) => element.id == e.id)) {
      for (var element in listCart) {
        if (element.id == e.id) {
          element.sl = (element.sl! + 1);
          break;
        }
      }
    } else {
      listCart.add(e);
    }*/

    if (listCart.isEmpty) {
      listCart.add(e);
    } else {
      int kt = 0;
      for (var element in listCart) {
        if (element.id == e.id) {
          kt = 1;
          element.sl = (element.sl! + 1);
          break;
        }
      }
      if (kt == 0) {
        listCart.add(e);
      }
    }

    notifyListeners();
  }
}
