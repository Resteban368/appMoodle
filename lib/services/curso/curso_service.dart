// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/curso.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CursoService extends ChangeNotifier {
  Future<List<ResultCursos>?> getInfoCurso(int userid) async {
    try {
      final url = 'http://172.16.23.187:3000/api/category/course/$userid';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<ResultCursos> banner = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          banner.add(ResultCursos.fromMap(element));
        }
        notifyListeners();
        return banner;
      }
    } catch (e) {
      print('error en el servicio de banner: $e');
    }
    return null;
  }
}
