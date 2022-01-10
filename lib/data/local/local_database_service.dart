import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model.dart';
import '../../globals.dart';

class LocalStorageService {
  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static Future<void> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
  }

  static LocalStorageService get instance => _instance;

  dynamic _getFromDisk(String key) {
    final Object? value = _preferences.get(key);
    return value;
  }

  List<String>? _getList(String key) {
    return _preferences.getStringList(key);
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  bool get isFormDetailsSaved => _getFromDisk(formDetailsKey) != null;

  set isFormDetailsSaved(bool value) =>
      _saveToDisk<bool>(formDetailsKey, value);

  bool get isUserLoggedIn => _getList(userKey) != null;

  User get user {
    final List<String> userData = _getList(userKey)!;
    return User(
      name: userData[0],
      address: userData[1],
      bankAccountNum: userData[2],
      bankIfscCode: userData[3],
    );
  }

  set user(User user) {
    final List<String> list = <String>[];
    if (user.name != null) {
      list.add(user.name!);
    }
    if (user.address != null) {
      list.add(user.address!);
    }
    if (user.bankAccountNum != null) {
      list.add(user.bankAccountNum!);
    }
    if (user.bankIfscCode != null) {
      list.add(user.bankIfscCode!);
    }
    _saveToDisk<List<String>>(userKey, list);
  }
}
