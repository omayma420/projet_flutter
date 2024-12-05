import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserService {
  final String _usersKey = "users";

  // Lire les utilisateurs
  Future<List<Map<String, String>>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return [];
    return List<Map<String, String>>.from(jsonDecode(usersJson));
  }

  // Ajouter un utilisateur
  Future<void> addUser(Map<String, String> user) async {
    List<Map<String, String>> users = await getUsers();
    users.add(user);
    await _saveUsers(users);
  }

  // Mettre à jour un utilisateur
  Future<void> updateUser(int index, Map<String, String> updatedUser) async {
    List<Map<String, String>> users = await getUsers();
    if (index < 0 || index >= users.length) return;
    users[index] = updatedUser;
    await _saveUsers(users);
  }

  // Supprimer un utilisateur
  Future<void> deleteUser(int index) async {
    List<Map<String, String>> users = await getUsers();
    if (index < 0 || index >= users.length) return;
    users.removeAt(index);
    await _saveUsers(users);
  }

  // Sauvegarder les utilisateurs
  Future<void> _saveUsers(List<Map<String, String>> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usersJson = jsonEncode(users);
    await prefs.setString(_usersKey, usersJson);
  }
}
