import 'package:firstdemo/widgets/responsiveWidget.dart';
import 'package:flutter/material.dart';

class CustomTextFieldPass extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  bool obscureText = true;
  final IconData icon;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;

  CustomTextFieldPass({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.obscureText = true,
    TextEditingController emailEditingController,
    TextAlignVertical textAlign,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: true,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange[200], size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
