import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:status_snackbar/status_snackbar.dart';
import 'package:uber_eats/Logins/Login.dart';
import 'package:uber_eats/MainPage.dart';
import '../Backend/App.dart';
import '../Components.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignupState();

}

class _SignupState extends State<SignUp>{
final TextEditingController fname = TextEditingController();
final TextEditingController lname = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController confpassword = TextEditingController();
bool enabled = true;
bool loading = false;

@override
Widget build(BuildContext context) {
  final text = Text(
    "Create account",
    style: TextStyle(
        color: Colors.white,
        fontSize: 16
    ),
  );

  final loadingAnimation = Container(
    padding: EdgeInsets.all(0),
    height: 25,
    width: 25,
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      strokeWidth: 3,
      strokeCap: StrokeCap.round,
    ),
  );

  final window = Container(
    width: double.infinity,
    padding: EdgeInsets.only(right: 30, left: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Expanded(child: SizedBox()),
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
            onPressed: () async {
              if(email.text.isNotEmpty && fname.text.isNotEmpty && lname.text.isNotEmpty && password.text.isNotEmpty && confpassword.text.isNotEmpty){
                if(!(EmailValidator.validate(email.text))){
                  StatusSnackbar.showError(context, "Enter a valid email address");

                }else if(password.text != confpassword.text){
                  StatusSnackbar.showError(context, "Ensure that all passwords match");

                }else{
                  setState(() {
                    loading = true;
                    enabled = false;
                  });

                  try{
                    bool success = await App.createUser("${fname.text} ${lname.text}", email.text, password.text);

                    if(success){
                      if(context.mounted){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                      }
                    }else{
                      setState(() {
                        loading = false;
                        enabled = true;
                      });

                      if(context.mounted){
                        StatusSnackbar.showError(context, App.currentErrorMessage);
                        App.currentErrorMessage = "";
                      }
                    }
                  }catch(e){
                    setState(() {
                      loading = false;
                      enabled = true;
                    });
                  }
                }
              }else{
                if(context.mounted){
                  StatusSnackbar.showError(context, "Ensure that all the fields are filled");
                }
              }
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xffc11e2c),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))
            ),
            child: loading? loadingAnimation : text
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
        // Expanded(child: SizedBox()),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      top: true,
      bottom: true,
      right: false,
      left: false,
      minimum: EdgeInsets.only(top: 130),
      child: SingleChildScrollView(
        child: window,
      ),
    ),
  );
}
}
