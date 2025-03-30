import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reze_melhor/application/utils/result_pattern.dart';

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

  Future<Result<UserRepository?>> getUser(String id) async {
    throw UnimplementedError();
  }
}
