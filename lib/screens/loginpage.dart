import 'dart:ui';

import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/registerpage.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/inputform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

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

  Future<String?> _loginAccount() async
  {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail,
          password: _loginPassword,
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

  }

  void _submitForm() async {

    setState(() {
      _loginformLoading = true;
    });
    String? _digninfeedback = await _loginAccount();
    if(_digninfeedback != null)
    {
      _alertDialogBuilder(_digninfeedback);
      setState(() {
        _loginformLoading = false;
      });
    }
  }

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

  bool _loginformLoading = false;

  String _loginEmail = "";
  String _loginPassword = "";

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
                child: Text("Welcome user, \nLogin to your account",
                textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),
              Column(
                children: [
                  custominput(hintText: "Email",
                    onChanged: (value){
                      _loginEmail = value!;
                    }, obscuretext: false,),
                  custominput(hintText: "Password",
                    obscuretext: true,
                    onChanged: (value){
                      _loginPassword = value!;
                    },
                    focusnode: _passwordFocusNode,
                    onSubmitted: (value){
                      _submitForm();
                    },
                  ),
                  custombutton(text: "Login",
                    onPressed: (){
                      _submitForm();
                    },
                    isLoading: _loginformLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: custombutton(text: "Create New Account",
                  onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>registerpage()));
                  },
                  ontlinebtn: true,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
