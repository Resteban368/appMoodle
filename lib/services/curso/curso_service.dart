// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/curso.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CursoService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'core_enrol_get_users_courses';
  final String _moodlewsrestformat = 'json';

  Future<List<ResponseCursos>?> getInfoCurso(int userid) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid';
    try {
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode < 400) {
        // print('status code: ${resp.statusCode}');

        List<ResponseCursos> responseCursosData = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (var element in mapaRespBody) {
          responseCursosData.add(ResponseCursos.fromJson(element));
        }
        notifyListeners();
        return responseCursosData;
      }
    } catch (e) {
      print('error en el service de cursos: $e');
    }
    return null;
  }
}
