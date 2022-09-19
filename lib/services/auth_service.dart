import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'notificaciones.dart';

class AuthService extends ChangeNotifier {
// Create storage
  final storage = const FlutterSecureStorage();
// ignore: todo
//TODO metodo de iniciar con un usuario, si retornamos algo, es un error su no todo bien

  Future<String?> login(String username, String password) async {
    var response = await http.post(
        Uri.parse(
            "https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/login/token.php?"),
        body: ({
          'username': username,
          'password': password,
          'service': 'moodle_mobile_app'
          // 'service': 'moodle_mobile_app'
        }));
    final jsonData = json.decode(response.body);
    // ignore: avoid_print
    if (response.statusCode == 200) {
      if (jsonData.containsKey('token')) {
        //todo guardamos el token en el storage
        await storage.write(key: 'token', value: jsonData['token']);
        return null;
      } else {
        //todo no se pudo logear error credenciales
        NotificationsService.showSnackbar(jsonData['error']);
        return jsonData['error'];
      }
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    //borrar el token del storage
    await storage.delete(key: 'token');
    return;
  }

  //metodo para saber si esta logueado o no osea si tenemos un token o no
  //si tenemos un token, es que esta logueado, si no, no esta logueado
  Future<String> isLoggedIn() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String?> getToken(String token) async {
    return await storage.read(key: 'token');
  }

  // Future<String> readToken() async {
  //   return await storage.read(key: 'token') ?? '';
  // }
  Future<String> readToken() async {
    Map<String, dynamic> tokens;
    // final access = await storage.read(key: 'access') ?? '';
    final token = await storage.read(key: 'token') ?? '';
    if (token == '') {
      return '';
    }
    tokens = {'token': token};

    return json.encode(tokens);
  }
}
