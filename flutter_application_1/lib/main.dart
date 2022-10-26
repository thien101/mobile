// import 'package:baitap/index.dart';
import 'package:flutter_application_1/ProductModels.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter/material.dart';
// ignore: unused_import

//import 'package:baitap/productlist_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/ProductModels.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ],
    child: MaterialApp(home: ProductModels()),
  ));
}
