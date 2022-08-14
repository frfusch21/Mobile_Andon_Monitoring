import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Register Page'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ),
      body: Body(),
    );
  }
}
