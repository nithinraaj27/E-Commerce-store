import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/ProductSize.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/imageswipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Productpage extends StatefulWidget {
  final String? productId;

  const Productpage({this.productId});
  @override
  _ProductpageState createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {

  FirebasServices _firebaseServices = FirebasServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsref.doc(widget.productId).get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data!.data();

                List imageList = documentData['images'];
                List productsizes = documentData['size'];

                _selectedProductSize = productsizes[0];
                return ListView(
                  children: [
                    ImageSwipe(ImageList: imageList),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 24, right: 24),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldheading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Text(
                        "\$${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Text(
                        "${documentData['desc']}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Text(
                        "Select Size",
                        style: Constants.regularDarkText,
                      ),
                    ),
                    ProductSize(
                        prodictsize: productsizes,
                      onselected: (size){
                          _selectedProductSize  = size;
                      },
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: GestureDetector(
                            onTap: () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Color(0xffDCDCDC),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/ribbon.png",
                                height: 25,
                                width: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: GestureDetector(
                              onTap: () async{
                                await _addToCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackarrow: true,
            hastitle: false,
          )
        ],
      ),
    ));
  }
}
