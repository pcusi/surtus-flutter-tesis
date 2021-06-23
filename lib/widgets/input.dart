import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Color color;
  final bool isPassword;
  final Function onChanged;
  final Color colorBorder;
  final Color labelColor;
  final Color hintColor;

  const InputText({
    Key key,
    this.hintText,
    this.color,
    this.isPassword = false,
    this.onChanged,
    this.colorBorder,
    this.labelColor,
    this.hintColor,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.isPassword ? true : false,
      decoration: InputDecoration(
        hintText: this.hintText,
        hintStyle: TextStyle(
          color: this.hintColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD1D3DB), width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.colorBorder,
            style: BorderStyle.solid,
          ),
        ),
        labelText: this.labelText,
        labelStyle: TextStyle(
          color: this.labelColor,
          fontSize: 12.0,
        ),
      ),
      onChanged: this.onChanged,
    );
  }
}
