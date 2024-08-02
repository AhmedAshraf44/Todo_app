import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.prefixIcon,
    required this.labelText,
    required this.validator,
    this.onTap,
    this.labelStyle,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Widget prefixIcon;
  final String labelText;

  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        // labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: prefixIcon,
        //  prefixIconColor: Colors.blue,
        border: buildBorder(),
        focusedBorder: buildBorder(Colors.blue),
      ),
    );
  }
}

buildBorder([Color color = Colors.black]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: color),
  );
}
