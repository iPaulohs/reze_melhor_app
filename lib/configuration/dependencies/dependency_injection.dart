import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:reze_melhor/application/firebase/auth_adapter/firebase_login_adapter.dart';
import 'package:reze_melhor/application/firebase/functions_adapter/firebase_functions_adapter.dart';
import 'package:reze_melhor/application/firebase/storage_adapter/firebase_storage_adapter.dart';
import 'package:reze_melhor/application/services/load_biblia.dart';
import 'package:reze_melhor/application/services/obj_box_service.dart';
import 'package:reze_melhor/application/services/secure_storage_service.dart';
import 'package:reze_melhor/application/states/actual_screen_controller.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/selected_day_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/configuration/dependencies/notifications_configuration.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class DependencyInjection {
  static start() {
    Get.lazyPut<ActualScreenController>(() => ActualScreenController());
    Get.lazyPut<ThemeModeController>(() => ThemeModeController());
    Get.lazyPut<SecureStorageService>(() => SecureStorageService());
    Get.lazyPut<ColorAppController>(() => ColorAppController());
    Get.lazyPut<SelectedDayController>(() => SelectedDayController());
    Get.lazyPut<AdaptativeColor>(() => AdaptativeColor());
    Get.lazyPut<NotificationsService>(() => NotificationsService());
    Get.lazyPut<FirebaseLoginAdapter>(() => FirebaseLoginAdapter());
    Get.lazyPut<FirebaseStorageAdapter>(() => FirebaseStorageAdapter());
    Get.lazyPut<FirebaseFunctionsAdapter>(() => FirebaseFunctionsAdapter());
    Get.lazyPut<ObjectBoxService>(() => ObjectBoxService());
    Get.lazyPut<LoadBiblia>(() => LoadBiblia());
  }
}
