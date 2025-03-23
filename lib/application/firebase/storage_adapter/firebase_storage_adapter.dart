import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:ulid/ulid.dart';

class FirebaseStorageAdapter {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<Result<String>> uploadMidia(
    File midia,
    String userEmail,
    String pathRef,
  ) async {
    final storageRef = firebaseStorage.ref().child(pathRef);
    final userRef = storageRef.child(userEmail.split("@")[0]);
    final fileRef = userRef.child(Ulid().toString());

    try {
      await fileRef.putFile(midia);
      final downloadUrl = await fileRef.getDownloadURL();
      return Success(downloadUrl);
    } on FirebaseException catch (e) {
      return Failure(e.code, "Erro ao fazer upload da mídia.");
    }
  }
}