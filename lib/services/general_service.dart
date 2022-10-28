// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_declarations

import 'package:campus_virtual/models/fechaResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GeneralService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  late String tokencillo = '';

//obetner token del storage
  Future<String?> ObtenerToken() async {
    final token = await storage.read(key: 'token');
    tokencillo = token!;
    print('tokencillo desde el provider: $token');
    notifyListeners();
    return token;
  }

  Future<FecahResponse?> getFechaHoraActual() async {
    print('hora y fecha actual');
    try {
      final url = 'http://172.16.23.187:3000/api/hora/hora';
      // print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        final fechaServer = FecahResponse.fromJson(response.body);
        notifyListeners();
        print(fechaServer.fechaActual);
        return fechaServer;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }
}
