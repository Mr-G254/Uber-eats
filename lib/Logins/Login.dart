import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_eats/Logins/SignUp.dart';
import 'package:uber_eats/MainPage.dart';

import '../Components.dart';

class Login extends StatelessWidget{
  Login({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    final window = Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 30,left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: SizedBox()),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),
            ),
          ),
          SizedBox(height: 20,),
          Input(label: "EMAIL", controller: email,enabled: enabled,),
          SizedBox(height: 20,),
          Input(label: "PASSWORD", controller: password,type: TextInputType.visiblePassword,enabled: enabled,),
          // Container(
          //   padding: EdgeInsets.only(top: 2,bottom: 5),
          //   width: double.infinity,
          //   alignment: Alignment.centerRight,
          //   child: GestureDetector(
          //     child: Text(
          //       "forgot password?",
          //       style: TextStyle(
          //           color: Colors.black,
          //           // fontWeight: FontWeight.bold,
          //           fontSize: 13
          //       ),
          //     ),
          //     onTap: (){
          //
          //     },
          //   ),
          // ),
          SizedBox(height: 30,),
          Container(
            height: 45,
            width: double.infinity,
            padding: EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xffc11e2c),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
              ),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 5),
            width: double.infinity,
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                "Don't have an account? Create one.",
                style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
              },
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: window,
    );
  }
}