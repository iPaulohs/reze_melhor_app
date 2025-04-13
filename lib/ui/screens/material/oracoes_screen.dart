import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/ui/screens/material/pesquisa_screen.dart';

import '../../../application/firebase/auth_adapter/firebase_login_adapter.dart';
import '../../../application/states/color_app_controller.dart';
import '../../../application/states/selected_day_controller.dart';
import '../../../application/states/theme_mode_controller.dart';
import '../../../configuration/dependencies/notifications_configuration.dart';
import '../../components/calendar_bottom_sheet.dart';
import '../../components/calendar_week.dart';
import '../../components/icon_asset.dart';
import '../../theme/color_theme.dart';

class OracoesScreen extends StatelessWidget {
   OracoesScreen({super.key, required this.openDrawer});

  final appColorController = Get.find<ColorAppController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final GestureTapCallback openDrawer;
  final themeModeController = Get.find<ThemeModeController>();
  final selectedDayController = Get.find<SelectedDayController>();
  final notificationService = Get.find<NotificationsService>();
  final loginService = Get.find<FirebaseLoginAdapter>();


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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(
          () => Scaffold(
            appBar: AppBar(
              title: Image.asset(
                "assets/img/rm_icon_transparent.png",
                color: appColorController.appColor.value.primary,
                height: kToolbarHeight,
              ),
              leading: IconButton(
                onPressed: openDrawer,
                icon: Image.asset(
                  height: height * 0.025,
                  "assets/img/menu.png",
                  color: adaptativeColor.getAdaptiveColor(context),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(PesquisaScreen());
                  },
                  icon: IconAsset(
                    assetName: "assets/svg/procurar.svg",
                    w: width * 0.05,
                  ),
                ),
              ],
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: appColorController.appColor.value.primary,
          child: FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: SvgPicture.asset(
              "assets/svg/mais.svg",
              colorFilter: ColorFilter.mode(
                adaptativeColor.getAdaptiveColor(context),
                BlendMode.srcIn,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        body: Column(children: []),
      ),
    );
  }
}
