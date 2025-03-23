import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicController extends GetxController {
  Rx<File>? profilePic;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profilePic = File(pickedFile.path).obs;
    }
  }
}
