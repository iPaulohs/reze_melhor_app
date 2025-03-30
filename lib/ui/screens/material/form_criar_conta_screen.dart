import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/dto/create_account_model.dart';
import 'package:reze_melhor/ui/components/custom_list_tile.dart';
import 'package:reze_melhor/ui/components/input_dropdown.dart';
import 'package:reze_melhor/ui/components/input_login.dart';

import '../../../application/firebase/auth_adapter/firebase_login_adapter.dart';
import '../../../application/states/color_app_controller.dart';
import '../../../application/states/create_account_controller.dart';
import '../../theme/color_theme.dart';
import '../../components/back_btn.dart';
import '../../components/custom_button.dart';

class FormCriarConta extends StatelessWidget {
  FormCriarConta({super.key});

  final Logger logger = Logger();

  final adaptativeColor = Get.find<AdaptativeColor>();
  final colorAppController = Get.find<ColorAppController>();
  final createAccountController = Get.find<CreateAccountController>();
  final firebaseLoginAdapter = Get.find<FirebaseLoginAdapter>();

  // Controladores
  final nomeController = TextEditingController();
  final sobrenomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final usernameController = TextEditingController();

  // FocusNodes
  final nomeFocus = FocusNode();
  final sobrenomeFocus = FocusNode();
  final emailFocus = FocusNode();
  final senhaFocus = FocusNode();
  final confirmarSenhaFocus = FocusNode();
  final usernameFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final introKey = GlobalKey<IntroductionScreenState>();

  bool validatePage(int index) {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Criar uma conta",
            style: GoogleFonts.montserrat(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.all(width * 0.0175),
            child: BackBtn(
              onTap: () {
                createAccountController.fotoPerfil.value = null;
                Get.back();
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Ionicons.ios_information_circle_outline),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: IntroductionScreen(
            freeze: true,
            rawPages: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.025),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            builder:
                                (context) => SizedBox(
                                  height: height * 0.3,
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: width * 0.025,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: height * 0.015,
                                          ),
                                          child: Text(
                                            "Escolher foto:",
                                            textAlign: TextAlign.center,
                                            style:
                                                GoogleFonts.montserratAlternates(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05,
                                        ),
                                        child: CustomListTile(
                                          title: "Câmera",
                                          trailingAsset:
                                              "assets/svg/camera.svg",
                                          onTap: () {
                                            createAccountController
                                                .setFotoPerfil(
                                                  ImageSource.camera,
                                                );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05,
                                        ),
                                        child: CustomListTile(
                                          title: "Galeria",
                                          trailingAsset:
                                              "assets/svg/galeria.svg",
                                          onTap: () {
                                            createAccountController
                                                .setFotoPerfil(
                                                  ImageSource.gallery,
                                                );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                        child: Obx(
                          () => CircleAvatar(
                            radius: height * 0.045,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                createAccountController.fotoPerfil.value != null
                                    ? FileImage(
                                          createAccountController
                                              .fotoPerfil
                                              .value!,
                                        )
                                        as ImageProvider
                                    : null,
                            child:
                                createAccountController.fotoPerfil.value == null
                                    ? Center(child: Icon(FontAwesome.camera))
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.035),
                      child: Text(
                        "Digite seus dados para criar a conta",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserratAlternates(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InputLogin(
                    label: "Nome",
                    controller: nomeController,
                    focusNode: nomeFocus,
                    icon: Icon(
                      Ionicons.ios_person_circle_outline,
                      color: Colors.grey[700],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  InputLogin(
                    label: "Sobrenome",
                    controller: sobrenomeController,
                    focusNode: sobrenomeFocus,
                    icon: Icon(
                      Ionicons.ios_person_circle_outline,
                      color: Colors.grey[700],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sobrenome é obrigatório';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height:
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? height * 0.15
                            : height * 0.05,
                    child: Image.asset("assets/img/igreja.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.035),
                    child: Text(
                      "Seu sexo",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserratAlternates(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomDropdown(
                    items: ["Masculino", "Feminino", "Prefiro não Informar"],
                    label: "Sexo",
                    icon: Icon(Icons.male, color: Colors.grey[700]),
                    onChanged: (value) {
                      createAccountController.sexoValue = value;
                    },
                    validator: (value) {
                      if (createAccountController.sexoValue == null) {
                        return "Sexo é obrigatório";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height:
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? height * 0.15
                            : height * 0.05,
                    child: Image.asset("assets/img/terco.png"),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.035),
                      child: Text(
                        "Seus dados de login",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserratAlternates(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InputLogin(
                    label: "Email",
                    controller: emailController,
                    focusNode: emailFocus,
                    icon: Icon(Fontisto.email, color: Colors.grey[700]),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email é obrigatório';
                      } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  InputLogin(
                    label: "Senha",
                    controller: senhaController,
                    focusNode: senhaFocus,
                    icon: Icon(
                      MaterialCommunityIcons.form_textbox_password,
                      color: Colors.grey[700],
                    ),
                    suffixIcon: Icon(
                      Ionicons.eye_outline,
                      color: Colors.grey[700],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      } else if (value.length < 8) {
                        return 'Senha deve ter pelo menos 8 caracteres';
                      }
                      return null;
                    },
                  ),
                  InputLogin(
                    label: "Confirme a senha",
                    controller: confirmarSenhaController,
                    focusNode: confirmarSenhaFocus,
                    icon: Icon(
                      MaterialCommunityIcons.form_textbox_password,
                      color: Colors.grey[700],
                    ),
                    suffixIcon: Icon(
                      Ionicons.eye_outline,
                      color: Colors.grey[700],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme a senha';
                      } else if (value != senhaController.text) {
                        return 'Senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height:
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? height * 0.15
                            : height * 0.05,
                    child: Image.asset("assets/img/cruz.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.035),
                    child: Text(
                      "Escolha um nome de usuário",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserratAlternates(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InputLogin(
                    label: "Username",
                    controller: usernameController,
                    focusNode: usernameFocus,
                    icon: Icon(Feather.users, color: Colors.grey[700]),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username é obrigatório';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ],
            onDone: () {},
            done: CustomButton(
              color: colorAppController.appColor.value.primary,
              onPress: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  var model = CreateAccountModel(
                    email: emailController.text,
                    senha: senhaController.text,
                    confirmacaoSenha: confirmarSenhaController.text,
                    nome: nomeController.text,
                    sobrenome: sobrenomeController.text,
                    username: usernameController.text,
                    sexo: createAccountController.sexoValue,
                  );

                  await firebaseLoginAdapter.createAccount(
                    model,
                    createAccountController.fotoPerfil.value?.absolute,
                  );
                }
              },
              textButton: "Finalizar",
            ),
            key: introKey,
            next: CustomButton(
              color: colorAppController.appColor.value.primary,
              onPress: () {
                if (validatePage(
                  introKey.currentState?.getCurrentPage() ?? 0,
                )) {
                  introKey.currentState?.next();
                }
              },
              textButton: "Prosseguir",
            ),
            back: CustomButton(
              textColor: colorAppController.appColor.value.tertiary,
              onPress: () {
                introKey.currentState?.previous();
              },
              textButton: "Voltar",
            ),
            showBackButton: true,
            controlsMargin: EdgeInsets.zero,
            controlsPadding: EdgeInsets.zero,
            dotsDecorator: DotsDecorator(
              color: colorAppController.appColor.value.primary,
              activeColor: colorAppController.appColor.value.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
