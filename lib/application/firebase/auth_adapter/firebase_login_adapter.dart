import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../dto/create_account_model.dart';
import '../../states/create_account_controller.dart';

class FirebaseLoginAdapter {
  final firebaseAuth = FirebaseAuth.instance;
  final crashlitycs = FirebaseCrashlytics.instance;
  final storage = FirebaseStorage.instance;
  final createAccountController = Get.find<CreateAccountController>();
  final logger = Logger();

  Future<Result<UserCredential>> loginComGoogle() async {
    throw UnimplementedError();
  }

  Future<void> criarContaComEmailESenha({
    required CreateAccountModel model,
  }) async {

    UserCredential? credentials;

    try {
      credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.senha,
      );

      final user = credentials.user;

      if(user != null){
        user.updateDisplayName(model.nome);

        final entries = <String, String>{
          "sobrenome": model.username,
          "sexo": model.sexo,
          "username": model.username,
        };

        credentials.additionalUserInfo?.profile?.addEntries(entries.entries);
        await credentials.user?.sendEmailVerification();

        logger.i("Usuario criado com sucesso.");
      }

      if (createAccountController.fotoPerfil.value != null) {
        try {
          final image = await storage
              .ref("imagensPerfil")
              .child(credentials.user!.uid)
              .putFile(createAccountController.fotoPerfil.value!.absolute);

          final url = await image.ref.getDownloadURL();

          if(url.isNotEmpty){
            user?.updatePhotoURL(url);
          }

          logger.i(
            "Foto de perfil registrada com sucesso.",
          );
        } on FirebaseException catch (e) {
          await crashlitycs.recordError(e, e.stackTrace);
          switch (e) {}
        }
      }

      createAccountController.toggleAwaiting();
    } on FirebaseAuthException catch (e) {
      await crashlitycs.recordError(e, e.stackTrace);
      switch (e) {}
    }
  }

  Future<Result<void>> updateEmail(String novoEmail) async {
    throw UnimplementedError();
  }

  Future<Result<void>> updateSenha(String novaSenha) async {
    throw UnimplementedError();
  }
}
