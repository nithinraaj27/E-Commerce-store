import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'
;
class Home extends StatelessWidget {

  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _intialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Scaffold(
              body: Center(
                child: Text("error: ${snapshot.error}"),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done)
          {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,Streamsnapshot){
                if(Streamsnapshot.hasError){
                  return Scaffold(
                      body: Center(
                        child: Text("error: ${Streamsnapshot.error}",style: Constants.regularHeading,),
                      )
                  );
                }
                if(Streamsnapshot.connectionState == ConnectionState.active)
                  {
                    User? _user = Streamsnapshot.data as User?;

                    if(_user == null)
                      {
                        return loginpage();
                      }
                    else{
                      return HomePage();
                    }
                  }
                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentication",style: Constants.regularHeading,),
                  ),
                );
              },
            );
          }
          return Scaffold(
            body: Center(
              child: Text("Intialising App....."),
            ),
          );
        });
  }
}
