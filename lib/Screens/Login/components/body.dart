import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/api.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/Screens/User/tech_dash.dart';


class Body extends StatefulWidget {
  @override
  _LoginState createState() =>_LoginState();
}

class _LoginState extends State<Body>{
  final _formKey = GlobalKey<FormState>();
  String msg ='';
  String kpk = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/icons/login.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your kpk",
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
                text: "LOGIN",
                press: () async{
                  if(_formKey.currentState.validate()) {
                    var resp = await loginUser(kpk, password);
                    print(resp);
                    if(resp.containsKey('status')){
                      setState((){
                        msg = resp['message'];
                      });
                      if(resp['status']==1){
                        Navigator.push(context, MaterialPageRoute(builder:(context){
                          return tech_dash(mechanic_name: resp['mechanic_name'], kpk: resp['kpk']);
                        }));
                      }
                    }else{
                      setState(() {
                        msg = 'Login Failed';
                      });
                    }
                  }
                },
              ),
              Text(msg, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
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
