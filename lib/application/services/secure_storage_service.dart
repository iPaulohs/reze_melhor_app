import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  SecureStorageService._internal();

  Future<void> setSecureValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getSecureValue(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteSecureValue(String key) async {
    await storage.delete(key: key);
  }
}