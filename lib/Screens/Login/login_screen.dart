import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/body.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Login Page'),
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
