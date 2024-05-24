import 'dart:developer';
import 'package:hive/hive.dart';

const kUserDataBoxName = "UserData";

enum UserField {
  token,
  id,
  email,

  username,
}

extension UserFieldExtension on UserField {
  String get asString {
    switch (this) {
      case UserField.token:
        return "token";
      case UserField.id:
        return "id";
      case UserField.email:
        return "email";

      case UserField.username:
        return "username";
      default:
        return "";
    }
  }
}

class LocalStorageService {
  static var userDataBox = Hive.box(kUserDataBoxName);

  static Future<bool> deleteUserData() async {
    bool isDone = false;
    try {
      await userDataBox.clear();
      isDone = true;
    } catch (e) {
      log(e.toString());
    }
    return isDone;
  }

  static Future updateToken(String token) async {
    await userDataBox.put("token", token);
  }

  static Future clearUserData() async {
    await userDataBox.clear();
  }

  static dynamic getUserValue(UserField userField) {
    return userDataBox.get(userField.asString);
  }

  static void updateUserData(Map<dynamic, dynamic> userData) {
    userData.forEach(
      (key, value) async {
        await userDataBox.put(key, value);
      },
    );
  }
}
