import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccountController extends GetxController {
  var waiting = false.obs;
  Rx<File?> fotoPerfil = Rx<File?>(null);
  String sexoValue = "Prefiro não informar";
  var senhaObscure = true.obs;
  var confirmSenhaObscure = true.obs;

  void toggleSenhaObscure() => senhaObscure.value = !senhaObscure.value;
  void toggleConfirmSenhaObscure() => confirmSenhaObscure.value = !confirmSenhaObscure.value;
  void toggleAwaiting() => waiting.value = !waiting.value;
  void toggleSexo(String sexo) => sexoValue = sexo;


  Future<void> setFotoPerfil(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        Get.snackbar(
          "Permissão negada",
          "É necessário permitir o acesso à câmera.",
        );
        return;
      }
    }
    if (source == ImageSource.gallery) {
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        Get.snackbar(
          "Permissão negada",
          "É necessário permitir o acesso à galeria.",
        );
        return;
      }
    }

    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      fotoPerfil.value = File(pickedFile.path);
    }
  }
}
