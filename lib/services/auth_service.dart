import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'http://receta2eb20263.somee.com/api';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
  Future<String?> createdUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    
    final url = Uri.http(_baseUrl, 'Accounts/register');
    final resp = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    
    if(decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error'];
    }
  }
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    
    final url = Uri.http(_baseUrl, 'Accounts/login');
    final resp = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    
    if(decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['error'];
    }
  }  
  Future logout() async{
    await storage.delete(key: 'token');
    return;
  }
  Future<String> readToken() async {
    return await storage.read(key: 'token')??'';
  }
}