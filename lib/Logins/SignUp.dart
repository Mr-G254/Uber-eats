import 'package:flutter/material.dart';
import 'package:uber_eats/Logins/Login.dart';
import '../Components.dart';

class SignUp extends StatelessWidget {
SignUp({super.key});

final TextEditingController fname = TextEditingController();
final TextEditingController lname = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController confpassword = TextEditingController();
bool enabled = true;

@override
Widget build(BuildContext context) {
  final window = Container(
    width: double.infinity,
    padding: EdgeInsets.only(right: 30, left: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: SizedBox()),
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24
            ),
          ),
        ),
        SizedBox(height: 20,),
        Input(label: "FIRST NAME", controller: fname,enabled: enabled,),
        SizedBox(height: 20,),
        Input(label: "SECOND NAME", controller: lname,enabled: enabled,),
        SizedBox(height: 20,),
        Input(label: "EMAIL", controller: email,enabled: enabled,),
        SizedBox(height: 20,),
        Input(label: "PASSWORD",
          controller: password,
          type: TextInputType.visiblePassword,enabled: enabled,),
        SizedBox(height: 20,),
        Input(label: "CONFIRM PASSWORD",
          controller: confpassword,
          type: TextInputType.visiblePassword,enabled: enabled,),
        SizedBox(height: 20,),
        Container(
          height: 45,
          width: double.infinity,
          padding: EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xffc11e2c),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))
            ),
            child: Text(
              "Create account",
              style: TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 5),
          width: double.infinity,
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text(
              "Already have an account? Login",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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
