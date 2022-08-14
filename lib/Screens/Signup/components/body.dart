import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/api.dart';


class Body extends StatefulWidget {
  @override
  _ApplicationState createState() => new _ApplicationState();
}

class _ApplicationState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  String msg ='';
  bool checkedValue;
  String mechanic_name = '';
  String kpk = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Form(key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              "REGISTER",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/icons/signup.png",
              height: size.height * 0.35,
            ),
                RoundedInputField(
                hintText: "Mechanic FullName",
                onChanged: (value) {
                  mechanic_name = value;
                },
              ),

                RoundedInputField(
                hintText: "KPK",
                onChanged: (value) {
                  kpk = value;
                },
              ),
                RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () async{
                    if(_formKey.currentState.validate()) {
                      var resp = await registerUser(mechanic_name, kpk, password);
                      print(resp);
                      if(resp.containsKey('message')){
                        setState((){
                          msg = resp['message'];
                        });
                        if(resp['message']=="You have successfully registered!"){
                            setState((){
                              msg = 'Register Complete, Please Login!';
                            });
                        }
                      }else{
                        setState(() {
                          msg = 'Register Failed';
                        });
                      }
                    }
                  },
            ),

              Text(msg, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 15),),
              SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
