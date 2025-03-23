import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/states/actual_screen_controller.dart';
import 'package:reze_melhor/ui/screens/cupertino/favoritos_screen.dart';
import 'package:reze_melhor/ui/screens/cupertino/hoje_screen.dart';
import 'package:reze_melhor/ui/screens/cupertino/leituras_screen.dart';
import 'package:reze_melhor/ui/screens/cupertino/perfil_screen.dart';
import 'package:reze_melhor/ui/screens/cupertino/rotina_screen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';



class CupertinoHScreen extends StatelessWidget {
  CupertinoHScreen({super.key});

  final ActualScreenController pageController =
      Get.find<ActualScreenController>();
          final AdaptativeColor adaptativeColor = Get.find<AdaptativeColor>();


  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/hoje.svg",
          colorFilter: ColorFilter.mode(
            adaptativeColor.getAdaptiveColor(context),
            BlendMode.srcIn,
          ),
        ),
        label: 'Hoje',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/marca-paginas.svg",
          colorFilter: ColorFilter.mode(
            adaptativeColor.getAdaptiveColor(context),
            BlendMode.srcIn,
          ),
        ),
        label: 'Rotina',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/leituras.svg",
          colorFilter: ColorFilter.mode(
            adaptativeColor.getAdaptiveColor(context),
            BlendMode.srcIn,
          ),
        ),
        label: 'Leituras',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/coracao.svg",
          colorFilter: ColorFilter.mode(
            adaptativeColor.getAdaptiveColor(context),
            BlendMode.srcIn,
          ),
        ),
        label: 'Favoritos',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svg/perfil.svg",
          colorFilter: ColorFilter.mode(
            adaptativeColor.getAdaptiveColor(context),
            BlendMode.srcIn,
          ),
        ),
        label: 'Perfil',
      ),
    ];

    final List<Widget> pages = [
      HojeScreen(),
      RotinaScreen(),
      LeiturasScreen(),
      FavoritosScreen(),
      PerfilScreen(),
    ];

    return Obx(
      () => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: navItems,
          currentIndex: pageController.actualPosition.value,
          onTap: (index) => pageController.toggleActualPosition(index),
          activeColor: adaptativeColor.getAdaptiveColor(context),
          backgroundColor: CupertinoColors.systemBackground.withOpacity(0.3),
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(builder: (context) => pages[index]);
        },
      ),
    );
  }
}
