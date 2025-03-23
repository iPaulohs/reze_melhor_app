import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reze_melhor/application/firebase/storage_adapter/firebase_storage_adapter.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:reze_melhor/application/view_models/auth_view_models.dart';

class FirebaseLoginAdapter {
    
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorageAdapter = Get.find<FirebaseStorageAdapter>();

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

  Future<Result<UserCredential>> signInWithEmailAndPasswordProvider(
    LoginWithEmailVm loginData,
  ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: loginData.email,
        password: loginData.password,
      );
      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Failure("user-not-found", "Usuário não encontrado.");
      } else if (e.code == 'wrong-password') {
        return const Failure("wrong-password", "Senha incorreta.");
      }
      return Failure(e.code, "Erro ao realizar o login.");
    }
  }

  Future<Result<UserCredential>> createAccount(
    CreateAccountVm createAccountData,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: createAccountData.email,
        password: createAccountData.password,
      );
      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-exists") {
        return const Failure("email-already-exists", "O email já está em uso.");
      }
      return Failure(e.code, "Erro ao criar conta.");
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

  Future<Result<String>> updateProfilePicture(
    UpdateProfilePictureVm updatePicData,
  ) async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
        return await firebaseStorageAdapter.uploadMidia(
        updatePicData.profilePicture,
        updatePicData.userEmail,
        updatePicData.pathRef,
      );
    }
    return Failure("user-not-logged-in", "Usuário não autenticado.");
  }
}
