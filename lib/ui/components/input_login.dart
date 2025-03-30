import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class InputLogin extends StatelessWidget {
  InputLogin({
    super.key,
    required this.label,
    this.icon,
    this.suffixIcon,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.validator
  });

  final AdaptativeColor adaptativeColor = Get.find<AdaptativeColor>();
  final String label;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final FormFieldValidator<String?>? validator;



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.015,
      ),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        focusNode: focusNode,
        controller: controller,
        cursorColor: adaptativeColor.getAdaptiveColor(context),
        decoration: InputDecoration(
          errorText: null,
          errorStyle: TextStyle(
            fontSize: 0,
            height: 0,
            color: Colors.transparent
          ),
          filled: true,
          fillColor: adaptativeColor.getAdaptiveColorSuave(context),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          labelStyle: GoogleFonts.montserrat(color: Colors.grey[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red,
              width: .5
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          prefixIcon: icon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
