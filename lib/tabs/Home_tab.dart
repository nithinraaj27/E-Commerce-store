
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:ecommerce_app/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsref =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productsref.get(),
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
                    padding: const EdgeInsets.only(top: 108, bottom: 2),
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
          CustomActionBar(
            title: "Home",
            hasBackarrow: false,
            hastitle: true,
          ),
        ],
      ),
    );
  }
}
