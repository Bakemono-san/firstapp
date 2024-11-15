import 'package:firstapp/src/Services/UserEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenManager {
  static const String _tokenKey = "auth_token";
  static const String _userKey = "auth_user";
  static const String _soldeKey = "auth_solde";

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveUser(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(_userKey, jsonEncode(user.toJson()));
}

  static Future<void> saveSolde(double solde) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_soldeKey, solde);
  }

  static Future<double?> getSolde() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_soldeKey);
  }


  static Future<User?> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userJson = prefs.getString(_userKey);

  if (userJson != null) {
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    return User.fromJson(userMap);
  }
  return null;
}


  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey); // Clear the user data as well
  }
}
