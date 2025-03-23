import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/services/secure_storage_service.dart';
import 'package:reze_melhor/application/utils/storage_keys.dart';
import 'package:reze_melhor/domain/enums/theme_mode_enum.dart';

class ThemeModeController extends GetxController {
  final SecureStorageService storageService = SecureStorageService();
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final themeStorage = await storageService.getSecureValue(
      StorageKeys.themeMode,
    );
    final int themeIndex =
        int.tryParse(themeStorage ?? "") ?? ThemeModeEnum.system.index;
    themeMode.value = ThemeMode.values[themeIndex];
    Get.changeThemeMode(themeMode.value);
  }

  void toggleThemeMode() {
    int nextIndex = (themeMode.value.index + 1) % ThemeMode.values.length;
    themeMode.value = ThemeMode.values[nextIndex];
    storageService.setSecureValue(StorageKeys.themeMode, nextIndex.toString());
    Get.changeThemeMode(themeMode.value);
  }
}
