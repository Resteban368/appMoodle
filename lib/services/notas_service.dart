// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class NotasService extends ChangeNotifier {
  //varaibles para la peticion de la informacion del usuario
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  Future<List<Notas>?> getNotas(int userId) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    const String _wsfunction = 'gradereport_overview_get_course_grades';
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        List<Notas> notas = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['grades']) {
          notas.add(Notas.fromMap(element));
        }
        notifyListeners();
        return notas;
      }
    } catch (e, s) {
      print('error en el service de notas curso: $e+$s');
    }
    notifyListeners();
    return null;
  }

  Future<List<Usergrade>?> getItemNotas(int userId, int courseid) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    const String _wsfunction = 'gradereport_user_get_grade_items';
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userId&courseid=$courseid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        List<Usergrade> notasItems = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['usergrades']) {
          notasItems.add(Usergrade.fromMap(element));
        }
        notifyListeners();
        return notasItems;
      }
    } catch (e, s) {
      print('error en el service de notas curso: $e+$s');
    }
    notifyListeners();
    return null;
  }

  Future<List<Usergrade>?> getAllStudentsNotas(int courseid) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    const String _wsfunction = 'gradereport_user_get_grade_items';
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&courseid=$courseid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        List<Usergrade> notasItems = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['usergrades']) {
          notasItems.add(Usergrade.fromMap(element));
        }
        notifyListeners();
        return notasItems;
      }
    } catch (e, s) {
      print('error en el service de notas  all estudiante curso: $e+$s');
    }
    notifyListeners();
    return null;
  }
}
