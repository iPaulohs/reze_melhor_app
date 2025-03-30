import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onPress, required this.textButton, this.color, this.textColor});

  final adaptativeColor = Get.find<AdaptativeColor>();
  final VoidCallback onPress;
  final String textButton;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color ?? adaptativeColor.getAdaptiveColorSuave(context),
        enableFeedback: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide.none,
        ),
      ),
      onPressed: onPress,
      child: Text(
        textButton,
        style: GoogleFonts.montserrat(
          color: textColor ?? Colors.white,
          fontWeight: color != null ? FontWeight.w500 : null,
        ),
      ),
    );
  }
}
