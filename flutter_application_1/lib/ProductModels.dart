import 'dart:html';
import 'dart:math';

import 'package:flutter_application_1/DetailCart.dart';
import 'package:flutter_application_1/DetailProduct.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductModels extends StatelessWidget {
  ProductModels({super.key});

  late List<ProductModel> _list = [];
  bool showGrid = true;
  bool isMax = false;
  bool isMin = false;
  String category = "";
  var SearchController = TextEditingController();
  final List<ProductModel> listCart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
                width: 398,
                child: Text(
                  "Products",
                  style: TextStyle(fontSize: 30, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              buildCategory(context),
              const SizedBox(
                height: 20,
              ),
              buildSearch(context),
              buildIconView(context),
              showGrid
                  ? buildGrid(context, isMax, isMin)
                  : buildList(context, isMax, isMin),
            ],
          ),
        ),
      ),
    );
  }

  buildCategory(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "men's clothing";
              },
              child: const Text("men's clothing"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "women's clothing";
              },
              child: const Text("women's clothing"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "electronics";
              },
              child: const Text('electronics'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "jewelery";
              },
              child: const Text('jewelery'),
            ),
          ],
        ),
      ),
    );
  }

  buildSearch(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return Row(
      children: [
        SizedBox(
          width: 180,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            controller: SearchController,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            isMax = true;
            isMin = false;
          },
          child: const Text('MAX'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            isMin = true;
            isMax = false;
          },
          child: const Text('MIN'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            category = "";
            SearchController.text = "";
          },
          child: const Text('ALL'),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => (AddCart(
                            listCart: productProvider.listCart,
                          )))));
            },
            icon: const Icon(Icons.add_shopping_cart))
      ],
    );
  }

  buildGrid(BuildContext context, bool isMax, bool isMin) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    //_list = productProvider.list;
    if (category != "") {
      productProvider.list
          .retainWhere((element) => element.category == category);
    }

    if (SearchController.text != "") {
      productProvider.list.retainWhere((element) => (element.category!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase()) ||
          element.title!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase())));
    }

    if (isMax) {
      productProvider.list
          .sort((a, b) => b.price!.toDouble().compareTo(a.price!.toDouble()));
    }
    if (isMin) {
      productProvider.list
          .sort((a, b) => a.price!.toDouble().compareTo(b.price!.toDouble()));
    }
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      children: [
        ...productProvider.list.map((e) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 3, right: 3, top: 0, bottom: 2),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 193, 68))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 95,
                    width: 110,
                    child: Image.network(
                      e.image ?? '',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => (DetailProduct(
                                    obj: e,
                                  )))));
                    },
                    child: Text(
                      e.title ?? 'Title NULL',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // ignore: prefer_interpolation_to_compose_strings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${e.price}\$',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        e.category.toString(),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        productProvider.getListCart(e);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => (AddCart(
                                      listCart: productProvider.listCart,
                                    )))));
                      },
                      child: Text('ADD', style: TextStyle(fontSize: 14)))
                ],
              ),
            ),
          );
        }).toList()
      ],
    ));
  }

  buildList(BuildContext context, bool isMax, bool isMin) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    //_list = productProvider.list;
    if (category != "") {
      productProvider.list
          .retainWhere((element) => element.category == category);
    }

    if (SearchController.text != "") {
      productProvider.list.retainWhere((element) => (element.category!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase()) ||
          element.title!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase())));
    }

    if (isMax) {
      productProvider.list
          .sort((a, b) => b.price!.toDouble().compareTo(a.price!.toDouble()));
    }
    if (isMin) {
      productProvider.list
          .sort((a, b) => a.price!.toDouble().compareTo(b.price!.toDouble()));
    }
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ...productProvider.list.map((e) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 4.0, right: 4, top: 4, bottom: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 193, 68))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    e.image ?? '',
                    height: 105,
                    width: 110,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => (DetailProduct(
                                    obj: e,
                                  )))));
                    },
                    child: Text(
                      e.title ?? 'Title NULL',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // ignore: prefer_interpolation_to_compose_strings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${e.price}\$',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(e.category.toString()),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        productProvider.getListCart(e);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => (AddCart(
                                      listCart: productProvider.listCart,
                                    )))));
                      },
                      child: Text('ADD', style: TextStyle(fontSize: 14)))
                ],
              ),
            ),
          );
        }).toList()
      ],
    ));
  }

  buildIconView(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            showGrid = false;
            print(showGrid);
          },
          icon: Icon(Icons.list),
        ),
        IconButton(
            onPressed: () {
              showGrid = true;
              print(showGrid);
            },
            icon: Icon(Icons.grid_view))
      ],
    );
  }
}
