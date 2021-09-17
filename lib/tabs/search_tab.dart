import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/inputform.dart';
import 'package:ecommerce_app/widgets/product_cart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebasServices _firebasServices = FirebasServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if(_searchString.isEmpty)
          Center(
            child: Container(
              child: Text(
                "Search Results",
                style: Constants.regularDarkText,
              ),
            ),
          )
        else
          FutureBuilder<QuerySnapshot>(
              future: _firebasServices.productsref
                  .orderBy("name")
                  .startAfter([_searchString]).endAt(["$_searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 128, bottom: 2),
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return ProductCart(
                          title: document['name'],
                          imageUrl: document['images'][0],
                          price: "\$${document['price']}",
                          ProductId: document.id,
                        );
                      }).toList(),
                    ),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: custominput(
            obscuretext: false,
            hintText: "Search here...",
            onSubmitted: (value) {
                setState(() {
                  _searchString = value!.toLowerCase();
                });
            },
          ),
        ),
      ],
    ));
  }
}
