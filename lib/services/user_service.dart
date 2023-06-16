import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/services/session_repository.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'http://192.168.15.17:3000/users';

  final _session = SessionRepository();

  Future<Map<String, String>> _getHeaders() async {
    final loggedUser = await _session.getLoggedUser();
    final String token = loggedUser['token'];

    return {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<List<dynamic>> getList() async {
    final uri = Uri.parse(_baseUrl);
    final headers = await _getHeaders();

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final dynamic users = jsonDecode(response.body);

      if (users == null) {
        return List.empty();
      }

      return users;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw HttpException(response.body, uri: uri);
    }

    return List.empty();
  }

  Future<bool> save(dynamic user) async {
    final userId = user['id'];

    final uri = Uri.parse(userId != null ? '$_baseUrl/$userId' : _baseUrl);
    final updateOrCreate = userId != null ? http.put : http.post;
    final headers = await _getHeaders();

    final response = await updateOrCreate(
      uri,
      headers: headers,
      body: jsonEncode(user),
    );

    return response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.ok;
  }

  Future<bool> delete(int userId) async {
    final uri = Uri.parse('$_baseUrl/$userId');
    final headers = await _getHeaders();

    final response = await http.delete(
      uri,
      headers: headers,
    );

    return response.statusCode == HttpStatus.ok;
  }
}
