import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/calendar_bottom_sheet.dart';
import 'package:reze_melhor/ui/components/icon_asset.dart';
import 'package:reze_melhor/ui/screens/material/pesquisa_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

import '../../components/calendar_week.dart';

class RotinaScreen extends StatelessWidget {
  RotinaScreen({super.key, required this.openDrawer});

  final appColorController = Get.find<ColorAppController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final GestureTapCallback openDrawer;
  final themeModeController = Get.find<ThemeModeController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Center(child: Text("Rotinas")),
    );
  }
}
