// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/tarea/disparcher.dart';

class TareaService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  Future<TareaCalificacionResponse?> getTarea(int userid, int assignid) async {
    const String wsfunction = 'mod_assign_get_submission_status';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&assignid=$assignid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        //mapeamos el respondes.body a un objeto de tipo TareaCalificacionResponse
        final tareaCalificacionResponse =
            TareaCalificacionResponse.fromJson(json.decode(response.body));
        notifyListeners();

        return tareaCalificacionResponse;
      }
    } catch (e, s) {
      print('error en la response tarea service: $e + $s');
    }
    notifyListeners();
    return null;
  }

  Future<TareaFechas?> getFechasTare(int userid, int assignid) async {
    const String wsfunction = 'mod_assign_get_participant';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&assignid=$assignid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        final tareaFechas = TareaFechas.fromJson(response.body);
        notifyListeners();
        return tareaFechas;
      }
    } catch (e, s) {
      print('error en la response tarea fecha service: $e + $s');
    }
    notifyListeners();
    return null;
  }

//get dispacher

  Future<List<Disparcher>?> getDispacherid(int idTarea) async {
    final url = 'http://172.16.23.187:3000/api/disparcher/tarea/$idTarea';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<Disparcher> banner = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          banner.add(Disparcher.fromMap(element));
        }
        notifyListeners();
        return banner;
      }
    } catch (e) {
      print('error en el servicio dispacher: $e');
    }
    notifyListeners();
    return null;
  }
}
