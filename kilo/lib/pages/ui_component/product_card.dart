import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kilo/models/product.dart';


import 'package:kilo/pages/ui_component/image_error.dart';

class ProductCard extends StatelessWidget {
  ProductCard({required this.product, required this.callback});
  final Product product;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromRGBO(226, 226, 226, 1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17)),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: product.image,
                          errorWidget: (context, error, _) =>
                              ImageDownloadError()))),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  )),
              const SizedBox(
                height: 3,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    product.shortDescr,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(124, 124, 124, 1)),
                  )),

              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, bottom: 5, right: 10),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text("${product.price} ГРН",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black)),
                              ),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                          onTap: () => callback(),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    106, 175, 63, 1),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ))))
                            ],
                          ))))
              // Container(child: )
            ]));
  }
}
