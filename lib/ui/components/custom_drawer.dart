import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/custom_drawer_header.dart';
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

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser;
    return Obx(
      () => Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDrawerHeader(),
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
