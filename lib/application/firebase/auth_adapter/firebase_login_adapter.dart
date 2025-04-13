import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/backend/api_client_rm.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../dto/create_account_model.dart';
import '../../states/create_account_controller.dart';

class FirebaseLoginAdapter {
  final firebaseAuth = FirebaseAuth.instance;
  final crashlitycs = FirebaseCrashlytics.instance;
  final storage = FirebaseStorage.instance;
  final createAccountController = Get.find<CreateAccountController>();
  final logger = Logger();
  final apiClient = Get.find<ApiClientRm>();

  Future<void> loginComGoogle() async {
    throw UnimplementedError();
  }

  Future<void> criarContaComEmailESenha({ required CreateAccountModel model }) async {

    UserCredential? credentials;

    try {
      credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.senha,
      );

      final user = credentials.user;

      if(user != null){
        await user.updateDisplayName(model.nome);

        final entries = <String, String>{
          "sobrenome": model.username,
          "sexo": model.sexo,
          "username": model.username,
        };

        credentials.additionalUserInfo?.profile?.addEntries(entries.entries);
        await credentials.user?.sendEmailVerification();
      }

      if (createAccountController.fotoPerfil.value != null) {
        try {
          final image = await storage
              .ref("imagens-perfil")
              .child(credentials.user!.uid)
              .putFile(createAccountController.fotoPerfil.value!.absolute);

          final url = await image.ref.getDownloadURL();

          if(url.isNotEmpty){
            await user?.updatePhotoURL(url);
          }
        } on FirebaseException catch (e) {
          await crashlitycs.recordError(e, e.stackTrace, reason: e.code);
          switch (e.code) {

          }
        }
      }

      createAccountController.toggleAwaiting();
    } on FirebaseAuthException catch (e) {
      await crashlitycs.recordError(e, e.stackTrace, reason: e.code);
      switch (e.code) {}
    }
  }

  Future<void> updateEmail(String novoEmail) async {
    throw UnimplementedError();
  }

  Future<void> updateSenha(String novaSenha) async {
    throw UnimplementedError();
  }
}
