import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/services/session_repository.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://192.168.15.17:3000/auth';

  final _session = SessionRepository();

  Future<dynamic> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == HttpStatus.created) {
      final loggedUser = jsonDecode(response.body);

      await _session.setLoggedUser(loggedUser);

      return loggedUser;
    }

    return null;
  }
}
