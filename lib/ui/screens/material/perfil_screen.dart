import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/back_btn.dart';
import 'package:reze_melhor/ui/components/custom_button.dart';
import 'package:reze_melhor/ui/screens/material/form_criar_conta_screen.dart';
import 'package:reze_melhor/ui/components/input_login.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class PerfilScreen extends StatelessWidget {
  PerfilScreen({super.key});

  final appColorController = Get.find<ColorAppController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final themeModeController = Get.find<ThemeModeController>();

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final User? user = FirebaseAuth.instance.currentUser;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final AdaptativeColor adaptativeColor = Get.find<AdaptativeColor>();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(width * 0.0175),
          child: BackBtn(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.075),
            child: OutlinedButton(
              onPressed: () => Get.to(FormCriarConta()),
              child: Text(
                "Criar Conta",
                style: TextStyle(
                  color: adaptativeColor.getAdaptiveColor(context),
                ),
              ),
            ),
          ),
        ],
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

  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final emailFocus = FocusNode();
  final senhaFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: height * 0.04,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/img/biblia.png", height: height * 0.15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                "Bem vindo ao seu devocionário de bolso!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text.rich(
                TextSpan(
                  text: "Conforme diz Santo Afonso de Ligório, ",
                  style: GoogleFonts.montserrat(
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "quem reza, se salva, quem não reza, se condena",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ". Pensando nisso, este app foi pensado para ser um auxiliar "
                          "diário em suas orações. Nosso objetivo é que você Reze Melhor!",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          final keyboardHeight =
                              MediaQuery.of(context).viewInsets.bottom;
                          final adjustedHeight = height * 0.4 + keyboardHeight;
                          return SingleChildScrollView(
                            child: Container(
                              height: adjustedHeight,
                              decoration: BoxDecoration(
                                color: adaptativeColor.getAdaptiveColorOnSuave(
                                  context,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                border: Border(
                                  left: BorderSide(
                                    color: adaptativeColor
                                        .getAdaptiveColorSuave(context),
                                    width: 0.5,
                                  ),
                                  right: BorderSide(
                                    color: adaptativeColor
                                        .getAdaptiveColorSuave(context),
                                    width: 0.5,
                                  ),
                                  top: BorderSide(
                                    color: adaptativeColor
                                        .getAdaptiveColorSuave(context),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: height * 0.015,
                                          vertical: width * 0.05,
                                        ),
                                        child: Text(
                                          "Faça login com o email",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserratAlternates(
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InputLogin(
                                    obscureText: false,
                                    focusNode: emailFocus,
                                    controller: emailController,
                                    label: "Email",
                                    icon: Icon(
                                      Fontisto.email,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  InputLogin(
                                    obscureText: false,
                                    focusNode: senhaFocus,
                                    controller: senhaController,
                                    label: "Senha",
                                    icon: Icon(
                                      MaterialCommunityIcons
                                          .form_textbox_password,
                                      color: Colors.grey[700],
                                    ),
                                    suffixIcon: Icon(
                                      Ionicons.eye_outline,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05,
                                      vertical: height * 0.015,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            onPress: () {},
                                            textButton: "FECHAR",
                                          ),
                                        ),
                                        SizedBox(width: width * 0.075),
                                        Expanded(
                                          child: CustomButton(
                                            color:
                                                colorAppController
                                                    .appColor
                                                    .value
                                                    .primary,
                                            onPress: () {},
                                            textButton: "LOGIN",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    label: Text(
                      "Login com o Email",
                      style: GoogleFonts.montserrat(
                        color: adaptativeColor.getAdaptiveColor(context),
                        fontSize: width * 0.04,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "assets/svg/login.svg",
                      height: height * 0.03,
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
                            text:
                                "Se continuar, você está de acordo com nossas",
                            style: TextStyle(
                              color: adaptativeColor.getAdaptiveColor(context),
                            ),
                          ),
                          TextSpan(
                            text: " condiçoes e termos de uso.",
                            style: TextStyle(
                              color:
                                  colorAppController.appColor.value.secondary,
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
      ),
    );
  }
}
