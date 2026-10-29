import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String _baseHost = 'receta20263it.somee.com';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Uri get registerUri => Uri.https(_baseHost, '/api/Accounts/register');
  Uri get loginUri => Uri.https(_baseHost, '/api/Accounts/login');

  Future<String?> createdUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      registerUri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    } else {
      return decodeResp['error']?['message'] ?? decodeResp['message'] ?? 'Error al registrar usuario';
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      loginUri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error']?['message'] ?? decodedResp['message'] ?? 'Credenciales inválidas';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

}