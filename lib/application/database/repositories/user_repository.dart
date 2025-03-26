import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';
import 'package:reze_melhor/domain/entities/user.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Result<String>> persistUser() async {
    throw UnimplementedError();
  }

  Future<Result<void>> deleteUser() async {
    throw UnimplementedError();
  }

  Future<Result<void>> updateUser(String key, dynamic value) async {
    throw UnimplementedError();
  }

  Future<Result<User?>> getUser(String id) async {
    throw UnimplementedError();
  }
}
