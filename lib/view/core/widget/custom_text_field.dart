import 'package:flutter/material.dart';

import '../themes/fonts.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscure;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.keyboardType,
    this.obscure = false,
    this.validator,
    this.hintText,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: blackTextStyle,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: greyTextStyle,
            errorText: errorText,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        )
      ],
    );
  }
}
