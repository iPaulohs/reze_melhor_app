import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:reze_melhor/domain/entities/user.dart';
import 'package:reze_melhor/domain/enums/provedor_autenticacao.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../dto/create_account_model.dart';

class FirebaseLoginAdapter {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final crashlitycs = FirebaseCrashlytics.instance;

  final logger = Logger();

  Future<Result<UserCredential>> signInWithGoogleProvider() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return const Failure("user-not-found", "Usuário não encontrado.");
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Failure(e.code, "Erro ao realizar o login.");
    }
  }

  Future<void> createAccount(CreateAccountModel model, File? fotoPerfil) async {
    UserCredential? credentials;
    try {
      credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.senha,
      );

      logger.i({
        "type": "credentials",
        "uid": credentials.user?.uid,
        "email": credentials.user?.email,
        "displayName": credentials.user?.displayName,
        "photoURL": credentials.user?.photoURL,
        "phoneNumber": credentials.user?.phoneNumber,
        "providerId": credentials.user?.providerData.map((e) => e.providerId).toList(),
      });

      if (credentials.user != null) {
        var user = UserEntity(
          email: model.email,
          name: model.nome,
          provedorAutenticacao: ProvedorAutenticacao.emailSenha.name,
          provedorUid: credentials.user!.uid,
          sexo: model.sexo,
          surname: model.sobrenome,

        );

        logger.i(user.toMap());

        await firebaseFirestore
            .collection("users")
            .doc(credentials.user!.uid)
            .set(user.toMap());

        if (fotoPerfil != null) {
          await firebaseStorage.ref("fotos-perfil/${credentials.user!.uid}").putFile(fotoPerfil);
        }
      } else {
        Get.snackbar(
          "Ops...",
          "Ocorreu um erro ao tentar criar a conta. Tente novamente mais tarde.",
        );
      }
    } on Exception catch (e) {
      if (credentials?.user != null) {
        try {
          await credentials!.user!.delete();
        } catch (deleteError, deleteStackTrace) {
          await crashlitycs.recordError(deleteError, deleteStackTrace);
        }
      }
    }
  }

  Future<Result<void>> updateEmail(String email) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(email);
        await user.reload();
        return const Success(null);
      }
      return const Failure("user-not-logged-in", "Usuário não autenticado.");
    } on FirebaseAuthException catch (e) {
      return Failure(e.code, "Erro ao atualizar o email.");
    }
  }

  Future<Result<void>> updatePassword(String password) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(password);
        await user.reload();
        return const Success(null);
      }
      return const Failure("user-not-logged-in", "Usuário não autenticado.");
    } on FirebaseAuthException catch (e) {
      return Failure(e.code, "Erro ao atualizar a senha.");
    }
  }
}
