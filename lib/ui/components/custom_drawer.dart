import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/custom_list_tile.dart';
import 'package:reze_melhor/ui/components/list_tile_block.dart';
import 'package:reze_melhor/ui/screens/material/perfil_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final themeModeController = Get.find<ThemeModeController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final appColorController = Get.find<ColorAppController>();

  String getIconTheme() {
    if (themeModeController.themeMode.value == ThemeMode.dark) {
      return "assets/svg/brilho_dark.svg";
    }
    if (themeModeController.themeMode.value == ThemeMode.light) {
      return "assets/svg/brilho_light.svg";
    }
    return "assets/svg/device.svg";
  }

  String capitalize(String text) {
    return text
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('-');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    return Obx(
      () => Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.1, bottom: height * 0.025),
              child: CircleAvatar(
                backgroundColor: adaptativeColor.getAdaptiveColorSuave(context),
                radius: width * 0.1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.025),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTileBlock(
                      titleText: "Perfil",
                      listTiles: [
                        CustomListTile(
                          trailingAsset: "assets/svg/perfil.svg",
                          title: user != null ? "Meu Perfil" : "Login",
                          onTap: () => Get.to(() => PerfilScreen()),
                        ),
                        CustomListTile(
                          trailingAsset: "assets/svg/check-carrinho.svg",
                          title: "Premium",
                          onTap: () {},
                        ),
                        CustomListTile(
                          trailingAsset: "assets/svg/backup-na-nuvem.svg",
                          title: "Backup",
                          onTap: () {},
                        ),
                      ],
                    ),
                    ListTileBlock(
                      titleText: "App",
                      listTiles: [
                        CustomListTile(
                          trailingAsset: getIconTheme(),
                          title: "Brilho",
                          onTap: () {
                            themeModeController.toggleThemeMode();
                          },
                        ),
                        CustomListTile(
                          trailingAsset: "",
                          trailing: CircleAvatar(
                            radius: height * 0.015,
                            backgroundColor:
                                appColorController.appColor.value.primary,
                          ),
                          title: "Cor",
                          onTap: () => appColorController.toggleAppColor(),
                        ),
                        CustomListTile(
                          title: "Configurações",
                          onTap: () {},
                          trailingAsset: "assets/svg/definicoes.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
