import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final _storage = new FlutterSecureStorage();

  static Future<String?> readString(String key) async {
    return await _storage.read(key: key);
  }

  static void writeString(String key, String? value) async {
    await _storage.write(key: key, value: value);
  }

  static void writeMap(Map<String, String?> values) async {
    for (var entry in values.entries) {
      await _storage.write(key: entry.key, value: entry.value);
    }
  }

  static void clear(String key) {
    _storage.delete(key: key);
  }

  static void clearList(List<String> keys) {
    for (var key in keys) {
      _storage.delete(key: key);
    }
  }
}