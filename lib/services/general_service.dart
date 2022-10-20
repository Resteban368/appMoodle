// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
