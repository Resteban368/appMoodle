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
        List<ResponseCursos> responseCursosData = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (Map<String, dynamic>? element in mapaRespBody) {
          // responseCursosData.add(final curso =  ResponseCursos.fromJson(element));
          final curso = ResponseCursos.fromJson(element!);
          //mandamos a llamar el metodo para obtener la categoria
          // final categoria = await getCategoryById(curso.id!);
          // print('categoria: ${categoria}');
          // print('categoria: ${categoria!.name}');
          // curso.category2 = categoria!.name as Category2?;

          responseCursosData.add(curso);

          // print(categoria);
        }
        // print(responseCursosData[0].category2?.name);
        notifyListeners();
        return responseCursosData;
      }
    } catch (e, s) {
      print('error en el service de cursos: $e +$s');
    }
    return null;
  }

  Future<Category2?> getCategoryById(int id) async {
    final url = 'http://172.16.23.187:3000/api/course/Category/$id';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<Category2> category = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          category.add(Category2.fromMap(element));
        }
        notifyListeners();
        print('category: ${category[0].name}');
        return category[0];
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }
}
