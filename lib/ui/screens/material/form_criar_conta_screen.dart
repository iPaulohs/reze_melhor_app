import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/ui/components/input_dropdown.dart';
import 'package:reze_melhor/ui/components/input_login.dart';

import '../../../application/states/color_app_controller.dart';
import '../../theme/color_theme.dart';
import '../../components/back_btn.dart';
import '../../components/custom_button.dart';

class FormCriarConta extends StatelessWidget {
  FormCriarConta({super.key});

  final adaptativeColor = Get.find<AdaptativeColor>();
  final colorAppController = Get.find<ColorAppController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final nomeController = TextEditingController();
    final sobrenomeController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Criar uma conta",
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(width * 0.0175),
          child: BackBtn(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.05),
              child: Center(
                child: CircleAvatar(
                  radius: height * 0.055,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                "Digite seus dados para criar a conta",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InputLogin(
              label: "Nome",
              controller: nomeController,
              icon: Icon(Icons.person_2),
            ),
            InputLogin(
              label: "Sobrenome",
              controller: sobrenomeController,
              icon: Icon(Icons.person_2),
            ),
            InputLogin(
              label: "Email",
              controller: nomeController,
              icon: Icon(Icons.alternate_email),
            ),
            InputLogin(
              label: "Senha",
              controller: sobrenomeController,
              icon: Icon(Icons.password),
            ),
            GenderDropdown(onChanged: (value) {}),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      color: colorAppController.appColor.value.primary,
                      onPress: () {},
                      textButton: "CRIAR CONTA",
                    ),
                  ),
                  SizedBox(width: width * 0.075),
                  Expanded(
                    child: CustomButton(onPress: () {}, textButton: "FECHAR"),
                  ),
                ],
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
                        ),
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
      ),
    );
  }
}
