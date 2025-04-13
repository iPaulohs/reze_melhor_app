import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/backend/api_client_rm.dart';
import 'package:reze_melhor/application/firebase/auth_adapter/firebase_login_adapter.dart';
import 'package:reze_melhor/application/services/load_biblia_service.dart';
import 'package:reze_melhor/application/services/object_box_service.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/selected_day_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/configuration/dependencies/notifications_configuration.dart';
import 'package:reze_melhor/ui/components/calendar_week.dart';
import 'package:reze_melhor/ui/components/icon_asset.dart';
import 'package:reze_melhor/ui/screens/material/pesquisa_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class HojeScreen extends StatelessWidget {
  HojeScreen({super.key, required this.openDrawer});

  final appColorController = Get.find<ColorAppController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final GestureTapCallback openDrawer;
  final themeModeController = Get.find<ThemeModeController>();
  final selectedDayController = Get.find<SelectedDayController>();
  final notificationService = Get.find<NotificationsService>();
  final loginService = Get.find<FirebaseLoginAdapter>();
  final objBoxService = Get.find<ObjectBoxService>();
  final apiClient = Get.find<ApiClientRm>();
  final bibliaService = Get.find<LoadBiblia>();

  String getIconTheme() {
    if (themeModeController.themeMode.value == ThemeMode.dark) {
      return "assets/svg/brilho_dark.svg";
    }

    if (themeModeController.themeMode.value == ThemeMode.light) {
      return "assets/svg/brilho_light.svg";
    }

    return "assets/svg/device.svg";
  }

  Future<String> getToken() async {
    return await FirebaseAppCheck.instance.getToken(true) ?? "";
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
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CalendarWeek(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(80, (_) => Text("TESTE")),
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
