import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double buttonWidth;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonWidth,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: purpleColor,
          enableFeedback: true,
          fixedSize: Size(buttonWidth, 50),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: whiteTextStyle.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
