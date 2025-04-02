import 'package:get/get.dart';
import 'package:reze_melhor/application/services/secure_storage_service.dart';
import 'package:reze_melhor/application/utils/storage_keys.dart';
import 'package:reze_melhor/domain/enums/color_app_enum.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class ColorAppController extends GetxController {
  final SecureStorageService storageService = SecureStorageService();
  var color = ColorAppEnum.red.obs;
  var appColor = Rx<ColorTheme>(RedColorScheme());

  @override
  Future<void> onReady() async {
    super.onReady();
    await loadColorBeforeRendering();
    update();
  }

  Future<void> loadColorBeforeRendering() async {
    final colorIndexStorage = await storageService.getSecureValue(StorageKeys.appColor);
    final int colorIndex = int.tryParse(colorIndexStorage ?? "") ?? ColorAppEnum.red.index;

    color.value = ColorAppEnum.values[colorIndex];
    appColor.value = _getColorTheme(color.value);
  }

  void toggleAppColor() {
    int nextIndex = (color.value.index + 1) % ColorAppEnum.values.length;
    color.value = ColorAppEnum.values[nextIndex];
    appColor.value = _getColorTheme(color.value);

    storageService.setSecureValue(StorageKeys.appColor, nextIndex.toString());
    update();
  }

  ColorTheme _getColorTheme(ColorAppEnum color) {
    switch (color) {
      case ColorAppEnum.red:
        return RedColorScheme();
      case ColorAppEnum.green:
        return GreenColorScheme();
      case ColorAppEnum.pink:
        return PinkColorScheme();
      case ColorAppEnum.blue:
        return BlueColorScheme();
      case ColorAppEnum.yellow:
        return YellowColorScheme();
      case ColorAppEnum.purple:
        return PurpleColorScheme();
    }
  }
}
