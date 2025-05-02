import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'auth_service.dart';

class UserService {
  final String baseUrl = "https://ton-backend.com"; // à remplacer

  /// Récupère le user en utilisant le token stocké
  Future<User?> fetchCurrentUser() async {
    final token = await AuthService().getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/users/me"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
