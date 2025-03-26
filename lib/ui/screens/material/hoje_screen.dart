import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/firebase/auth_adapter/firebase_login_adapter.dart';
import 'package:reze_melhor/application/firebase/functions_adapter/firebase_functions_adapter.dart';
import 'package:reze_melhor/application/services/obj_box_service.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/selected_day_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/configuration/dependencies/notifications_configuration.dart';
import 'package:reze_melhor/domain/entities/biblia.dart';
import 'package:reze_melhor/objectbox.g.dart';
import 'package:reze_melhor/ui/components/calendar_bottom_sheet.dart';
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
  final functionsAdapter = Get.find<FirebaseFunctionsAdapter>();
  final objBoxService = Get.find<ObjectBoxService>();

  String getIconTheme() {
    if (themeModeController.themeMode.value == ThemeMode.dark) {
      return "assets/svg/brilho_dark.svg";
    }

    if (themeModeController.themeMode.value == ThemeMode.light) {
      return "assets/svg/brilho_light.svg";
    }

    return "assets/svg/device.svg";
  }

  Future<List<Livro>> getVersiculo() async {
    final query = objBoxService.livroBox.query(Livro_.nome.equals("Gênesis"));
    return query.build().find();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight * 1.75,
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
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  constraints: BoxConstraints(maxHeight: height * 0.6),
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: adaptativeColor.getAdaptiveColorInvert(context),
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: CalendarBottomSheet(),
                      ),
                    );
                  },
                );
              },
              icon: IconAsset(
                assetName: "assets/svg/calendario.svg",
                w: width * 0.05,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CalendarWeek(),
          ),
        ),
        body: Column(children: [
            
          ],
        ),
      ),
    );
  }
}
