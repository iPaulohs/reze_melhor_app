import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/services/load_biblia_service.dart';
import 'package:reze_melhor/application/services/object_box_service.dart';
import 'package:reze_melhor/application/services/secure_storage_service.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/application/utils/storage_keys.dart';
import 'package:reze_melhor/configuration/dependencies/dependency_injection.dart';
import 'package:reze_melhor/configuration/dependencies/notifications_configuration.dart';
import 'package:reze_melhor/configuration/environment/env.dart';
import 'package:reze_melhor/configuration/environment/init_firebase.dart';
import 'package:reze_melhor/ui/screens/cupertino/cupertino_hscreen.dart';
import 'package:reze_melhor/ui/screens/material/material_hscreen.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.start();
  await InitFirebase.start();
  await Get.find<ObjectBoxService>().initialize();
  initializeDateFormatting("pt-BR");
  NotificationsService().initializeNotifications();

  runApp(RezeMelhor());
}

class RezeMelhor extends StatelessWidget {
  const RezeMelhor({super.key});

  @override
  Widget build(BuildContext context) {
    return Env.platform == "android"
        ? RezeMelhorMaterialApp()
        : RezeMelhorCupertinoApp();
  }
}

class RezeMelhorMaterialApp extends StatelessWidget {
  RezeMelhorMaterialApp({super.key});

  final logger = Logger();
  final themeModeController = Get.find<ThemeModeController>();
  final adaptativeColor = Get.find<AdaptativeColor>();
  final storageService = Get.find<SecureStorageService>();
  final appColorController = Get.find<ColorAppController>();
  final loaBiblia = Get.find<LoadBiblia>();

  Future<String> getFirstTime() async {
    await FirebaseAuth.instance.signInAnonymously();
    var primeiroAcesso =
        await storageService.getSecureValue("PRIMEIRO_ACESSO") ?? "S";
    storageService.setSecureValue("PRIMEIRO_ACESSO", "N");
    await Future.delayed(Duration(milliseconds: 1500));
    return primeiroAcesso;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<String>(
      future: getFirstTime(),
      builder: (context, snapshot) {
        final waiting = snapshot.connectionState == ConnectionState.waiting;
        final primeiroAcesso = snapshot.data;

        return GetBuilder<ColorAppController>(
          builder: (colorAppController) {
            return GetBuilder<ThemeModeController>(
              builder: (themeModeController) {
                return GetMaterialApp(
                  themeMode: themeModeController.themeMode.value,
                  theme: ThemeData(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      secondary: Colors.white,
                      onSecondary: Colors.white,
                      error: Colors.transparent,
                      onError: Colors.transparent,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: const ColorScheme.dark(
                      primary: Colors.black,
                      onPrimary: Colors.black,
                      secondary: Colors.white,
                      onSecondary: Colors.transparent,
                      error: Colors.transparent,
                      onError: Colors.transparent,
                      surface: Colors.black,
                      onSurface: Colors.white,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  debugShowCheckedModeBanner: Env.env == 'dev',
                  home: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child:
                        waiting
                            ? Scaffold(
                              body: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        colorAppController
                                            .appColor
                                            .value
                                            .primary,
                                        BlendMode.srcIn,
                                      ),
                                      child: Image.asset(
                                        'assets/img/rm_icon_transparent.png',
                                        width: width * 0.35,
                                      ),
                                    ),
                                    CircularProgressIndicator(
                                      color: adaptativeColor.getAdaptiveColor(
                                        context,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : primeiroAcesso == "S"
                            ? Center()
                            : MaterialHscreen(
                              key: ValueKey('material_hscreen'),
                            ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class RezeMelhorCupertinoApp extends StatelessWidget {
  RezeMelhorCupertinoApp({super.key});

  final storageService = Get.find<SecureStorageService>();

  Future<String?> getFirstTime() async =>
      await storageService.getSecureValue(StorageKeys.firstTime);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModeController>(
      builder: (themeModeController) {
        return GetCupertinoApp(
          home: CupertinoHScreen(),
          theme: CupertinoThemeData(),
          debugShowCheckedModeBanner: Env.env == 'dev',
        );
      },
    );
  }
}
