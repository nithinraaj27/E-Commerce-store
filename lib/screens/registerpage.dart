import 'dart:ffi';


import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/inputform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class registerpage extends StatefulWidget {
  @override
  _registerpageState createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {

  Future<void> _alertDialogBuilder(String error) async
  {
    return showDialog(context: context, barrierDismissible: false,builder: (context){
      return AlertDialog(
        title: Text("Error"),
        content: Container(
          child: Text(error),
        ),
        actions: [
          FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("Close Dialog",style: TextStyle(color: Colors.blue),))
        ],
      );
    });
  }

  Future<String?> _createAccount() async
  {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail,
          password: _registerPassword
      );
      return null;
    }on FirebaseAuthException catch(e)
    {
      if(e.code == 'weak-password')
      {
        return "The password is too week";
      }
      else if(e.code == 'email-already-in-use')
      {
         return "The account already exist for that email";
      }
      return e.message;
    }catch(e)
    {
      return e.toString();
    }
    return null;
  }

  void _submitForm() async {

    setState(() {
      _registerformLoading = true;
    });
    String? _createAccountFeedback = await _createAccount();
    if(_createAccountFeedback != null)
      {
        _alertDialogBuilder(_createAccountFeedback);
        setState(() {
          _registerformLoading = false;
        });
      }else
        {
          Navigator.pop(context);
        }
  }

  bool _registerformLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";


  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordFocusNode!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Create a New Account",
                    textAlign: TextAlign.center,
                    style: Constants.boldheading,
                  ),
                ),
                Column(
                  children: [
                    custominput(hintText: "Email",
                    onChanged: (value){
                      _registerEmail = value!;
                    }, obscuretext: false,),
                    custominput(
                      hintText: "Password",
                    obscuretext: true,
                    onChanged: (value){
                      _registerPassword = value!;
                    },
                      focusnode: _passwordFocusNode,
                      onSubmitted: (value){
                      _submitForm();
                      },
                    ),
                    custombutton(text: "Create New Account",
                    onPressed: (){
                      _submitForm();
                    },
                    isLoading: _registerformLoading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: custombutton(text: "Back To Login",
                    onPressed:(){
                      Navigator.pop(context);
                    },
                    ontlinebtn: true,
                  ),
                ),
              ],
            ),
          )
      ),
    );;
  }
}
