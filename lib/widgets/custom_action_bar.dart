import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {

  final String? title;
  final bool hasBackarrow;
  final bool hastitle;

  CustomActionBar({this.title, required this.hasBackarrow, required this.hastitle});

  FirebasServices _firebaseServices = FirebasServices();

  final CollectionReference _usersRef =
  FirebaseFirestore.instance.collection("Users");


  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackarrow;
    bool _hastitle = hastitle;


    return Container(
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Icon(Icons.chevron_left_sharp,color: Colors.white,size: 30,)
              ),
            ),
          if(_hastitle)
            Text(title?? "Action Bar",style: Constants.boldheading,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
            },
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8)
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _usersRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                builder: (context,AsyncSnapshot snapshot)
                {
                  int _totalitems = 0;

                  if(snapshot.connectionState == ConnectionState.active)
                    {
                      List _documents = snapshot.data!.docs;
                      _totalitems = _documents.length;
                    }
                 return Text(
                   _totalitems.toString() ,
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w600,
                     color: Colors.white
                 ),);
                },
              )
            ),
          )
        ],
      ),
    );
  }
}
