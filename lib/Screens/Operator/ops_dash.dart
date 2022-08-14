import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Operator/components/body.dart';

class ops_dash extends StatelessWidget {
  final String line_number;
  final int quota;
  final int act1, act2, act3, act4;

  ops_dash({Key key, @required this.line_number, this.quota, this.act1,
    this.act2, this.act3, this.act4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Shift Schedule Control'),
//        automaticallyImplyLeading: false,
      ),
      body: Body(line_number,quota, act1, act2, act3, act4),
    );
  }
}
