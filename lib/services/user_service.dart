import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/services/session_repository.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'http://192.168.15.17:3000/users';

  final _session = SessionRepository();

  Future<List<dynamic>> getList() async {
    final Uri uri = Uri.parse(_baseUrl);

    final loggedUser = await _session.getLoggedUser();
    final String token = loggedUser['token'];

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
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

    print('[UserService.getList] Error: ${response.body}');

    return List.empty();
  }
}
