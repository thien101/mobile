import 'package:flutter_application_1/ProductModels.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddCart extends StatefulWidget {
  final List<ProductModel> listCart;
  const AddCart({
    super.key,
    required this.listCart,
  });

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    double tt = 0;
    widget.listCart.forEach(
      (element) {
        tt += (element.sl!.toDouble() * element.price!.toDouble());
      },
    );
    //print(listCart);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                  height: 30,
                  width: 414,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => (ProductModels()))));
                        },
                        icon: Icon(Icons.arrow_back),
                      )
                    ],
                  )),
              SizedBox(
                width: 400,
                height: 800,
                child: Column(
                  children: [
                    const Center(
                      child: Text('ADD Cart',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 30)),
                    ),
                    SizedBox(
                      height: 20,
                      width: 414,
                    ),
                    ProductView(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 12, right: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text('${tt.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 30)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.listCart.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          (ProductModels()))));
                            },
                            child: const Text(
                              "Check Out",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BuildProduct(BuildContext context, num sl) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Text(
        '$sl',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }

  ProductView(BuildContext context) {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ...widget.listCart.map((e) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(e.image ?? "")),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            '${e.sl}',
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                e.sl = (e.sl! + 1);
                              });
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                e.sl = (e.sl! - 1);
                                if (e.sl! <= 0) {
                                  widget.listCart.remove(e);
                                }
                              });
                            },
                            icon: Icon(Icons.remove))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList()
      ],
    ));
  }
}
