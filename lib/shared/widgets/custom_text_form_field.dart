import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final IconData icon;
  final bool obscure;
  final Function validat;
  final TextEditingController controller;
  final visiableIcon;
  CustomTextFormField(
      {@required this.label,
      @required this.icon,
      @required this.textInputType,
      @required this.obscure,
      @required this.validat,
      @required this.controller,
      this.visiableIcon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon),
          suffixIcon: visiableIcon,
        ),
        keyboardType: textInputType,
        obscureText: obscure,
        validator: validat,
        controller: controller,
      ),
    );
  }
}
