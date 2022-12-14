// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CursoContenidoService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'core_course_get_contents';
  final String _moodlewsrestformat = 'json';

  // late CursoForId contenidoCurso = CursoForId();

  Future<List<ResponseDataCursoForId>?> getInfoCursoID(int courseID) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&courseid=$courseID';
    try {
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode < 400) {
        List<ResponseDataCursoForId> contenidoCurso = [];
        List<ResponseDataCursoForId> contenidoModules = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (var element in mapaRespBody) {
          contenidoCurso.add(ResponseDataCursoForId.fromJson(element));
          contenidoModules.add(ResponseDataCursoForId.fromJson(element));
        }
        // print(contenidoCurso[0].modules![0].name);
        notifyListeners();
        return contenidoCurso;
      }
    } catch (e, s) {
      print('error en el servicie  de contenido curso: $e + $s');
    }

    return null;
  }
}
