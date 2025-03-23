import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reze_melhor/application/states/actual_screen_controller.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/custom_drawer.dart';
import 'package:reze_melhor/ui/screens/material/favoritos_screen.dart';
import 'package:reze_melhor/ui/screens/material/hoje_screen.dart';
import 'package:reze_melhor/ui/screens/material/leituras_screen.dart';
import 'package:reze_melhor/ui/screens/material/oracoes_screen.dart';
import 'package:reze_melhor/ui/screens/material/rotina_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class MaterialHscreen extends StatelessWidget {
  MaterialHscreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = Get.find<ActualScreenController>();
  final themeModeController = Get.find<ThemeModeController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final colorAppController = Get.find<ColorAppController>();

  BottomNavigationBarItem customBottomBarItem(
    BuildContext context,
    String label,
    String pathIcon,
  ) {
    return BottomNavigationBarItem(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      activeIcon: SvgPicture.asset(
        pathIcon,
        colorFilter: ColorFilter.mode(
          colorAppController.appColor.value.primary,
          BlendMode.srcIn,
        ),
      ),
      icon: SvgPicture.asset(
        pathIcon,
        colorFilter: ColorFilter.mode(
          adaptativeColor.getAdaptiveColor(context),
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }

  Obx customBottomNavigationBar(BuildContext context) {
    List<BottomNavigationBarItem> navItems = [
      customBottomBarItem(context, 'Hoje', "assets/svg/hoje.svg"),
      customBottomBarItem(context, 'Rotina', "assets/svg/marca-paginas.svg"),
      customBottomBarItem(context, 'Leituras', "assets/svg/leituras.svg"),
      customBottomBarItem(context, 'Orações', "assets/svg/maos.svg"),
      customBottomBarItem(context, 'Salvos', "assets/svg/coracao.svg"),
    ];

    return Obx(
      () => BottomNavigationBar(
        items: navItems,
        currentIndex: pageController.actualPosition.value,
        onTap: (index) => pageController.toggleActualPosition(index),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        enableFeedback: false,
        selectedItemColor: adaptativeColor.getAdaptiveColor(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> pages = [
      HojeScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()),
      RotinaScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()),
      LeiturasScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()),
      OracoesScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()),
      FavoritosScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()),
    ];

    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(),
        body: IndexedStack(
          index: pageController.actualPosition.value,
          children: pages,
        ),
        bottomNavigationBar: customBottomNavigationBar(context),
      ),
    );
  }
}
