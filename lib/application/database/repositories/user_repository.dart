import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:reze_melhor/application/view_models/firestore_view_models.dart';
import 'package:reze_melhor/domain/entities/user.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Result<String>> persistUser(CreateDocVm viewModel) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(viewModel.docId)
          .set(viewModel.docContent);
      return Success(viewModel.docId);
    } on FirebaseException catch (e) {
      if (e.code.isNotEmpty) {
        return Failure("", "Erro ao inserir o registro. Tente novamente.");
      }
      return Failure("Ops...", "Erro ao inserir um registro. Tente novamente.");
    }
  }

  Future<Result<void>> deleteUser() {
    throw UnimplementedError();
  }

  Future<Result<void>> updateUser(String key, dynamic value) {
    throw UnimplementedError();
  }

  Future<Result<User?>> getUser(String id) {
    throw UnimplementedError();
  }
}
