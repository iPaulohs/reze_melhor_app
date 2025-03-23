import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/calendar_bottom_sheet.dart';
import 'package:reze_melhor/ui/components/icon_asset.dart';
import 'package:reze_melhor/ui/screens/material/pesquisa_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class LeiturasScreen extends StatelessWidget {
  LeiturasScreen({super.key, required this.openDrawer});

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
        leading: Builder(
          builder:
              (context) => GestureDetector(
                onTap: openDrawer,
                child: Obx(
                  () => ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      appColorController.appColor.value.primary,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/img/rm_icon_transparent.png',
                      width: width * 0.125,
                    ),
                  ),
                ),
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                constraints: BoxConstraints(maxHeight: height * 0.6),
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: adaptativeColor.getAdaptiveColorInvert(context),
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
      ),
      body: Center(child: Text("Leituras")),
    );
  }
}
