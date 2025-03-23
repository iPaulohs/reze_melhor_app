import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/back_btn.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class PerfilScreen extends StatelessWidget {
  PerfilScreen({super.key});

  final appColorController = Get.find<ColorAppController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final themeModeController = Get.find<ThemeModeController>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(width * 0.0175),
          child: BackBtn(),
        ),
      ),
      body: user != null ? UserDetailsScreen() : LoginScreen(),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("User details"));
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final adaptativeColor = Get.find<AdaptativeColor>();
  final colorAppController = Get.find<ColorAppController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Column(
            children: [
              SizedBox(
                width: width * 0.8,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: adaptativeColor.getAdaptiveColorSuave(
                      context,
                    ),
                    enableFeedback: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {},
                  label: Text(
                    "Login com o Google",
                    style: GoogleFonts.montserrat(
                      color: adaptativeColor.getAdaptiveColor(context),
                      fontSize: width * 0.04,
                    ),
                  ),
                  icon: Image.asset(
                    "assets/img/google.png",
                    height: height * 0.025,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: adaptativeColor.getAdaptiveColorSuave(
                      context,
                    ),
                    enableFeedback: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {},
                  label: Text(
                    "Login com o Email",
                    style: GoogleFonts.montserrat(
                      color: adaptativeColor.getAdaptiveColor(context),
                      fontSize: width * 0.04,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    "assets/svg/login.svg",
                    height: height * 0.025,
                    colorFilter: ColorFilter.mode(
                      adaptativeColor.getAdaptiveColor(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.025),
                child: SizedBox(
                  width: width * 0.75,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: width * 0.035),
                      children: [
                        TextSpan(
                          text: "Se continuar, você está de acordo com nossas",
                           style: TextStyle(
                            color: adaptativeColor.getAdaptiveColor(context),
                          )
                        ),
                        TextSpan(
                          text: " condiçoes e termos de uso.",
                          style: TextStyle(
                            color: colorAppController.appColor.value.secondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
