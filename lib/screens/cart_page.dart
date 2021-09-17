import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  FirebasServices _firebasServices = FirebasServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebasServices.usersRef.doc(_firebasServices.getUserId()).collection("Cart").get(),
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
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Productpage(productId: document.id,)));
                          },
                          child: FutureBuilder(
                            future: _firebasServices.productsref.doc(document.id).get(),
                            builder: (context , AsyncSnapshot productsnap){
                              if(productsnap.hasError)
                                {
                                  return Container(
                                    child: Center(
                                      child: Text("${productsnap.error}"),
                                    )
                                  );
                                }

                              if(productsnap.connectionState == ConnectionState.done)
                                {
                                  Map _productMap = productsnap.data!.data();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${_productMap['images'][0]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_productMap['name']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  "\$${_productMap['price']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                "Size - ${document['size']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          )
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
              hasBackarrow: true, hastitle: true,title: "Cart",)
        ],
      ),
    );
  }
}
