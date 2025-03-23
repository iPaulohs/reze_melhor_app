import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';

class CustomDrawerHeader extends StatelessWidget {
  CustomDrawerHeader({super.key});

  final appColorController = Get.find<ColorAppController>();

  String capitalize(String text) {
    return text
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('-');
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    final double width = MediaQuery.of(context).size.width;
    return DrawerHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Reze ",
                      style: GoogleFonts.montserratAlternates(
                        fontSize: width * 0.065,
                      ),
                    ),
                    Text(
                      "Melhor",
                      style: GoogleFonts.montserratAlternates(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.065,
                        color: appColorController.appColor.value.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  capitalize(
                    DateFormat('EEEE', 'pt_BR').format(DateTime.now()),
                  ),
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormat.yMMMMd("pt-BR").format(DateTime.now())),
              ],
            ),
          ),
          Spacer(),
          if (user != null) CircleAvatar(),
        ],
      ),
    );
  }
}
