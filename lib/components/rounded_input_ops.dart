import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_medium.dart';
import 'package:flutter_auth/constants.dart';

class RoundedInputOps extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputOps({
    Key key,
    this.hintText,
    this.icon = Icons.dvr,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
