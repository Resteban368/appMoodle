// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TareaService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  final TextEditingController controllerMessage = TextEditingController();

  Future<TareaCalificacionResponse> getTarea(int userid, int assignid) async {
    print('get info tarea');
    const String wsfunction = 'mod_assign_get_submission_status';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&assignid=$assignid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        //mapeando la respuesta
        final Map<String, dynamic> mapaRespBody = json.decode(response.body);
        final TareaCalificacionResponse tareaCalificacionResponse =
            TareaCalificacionResponse.fromJson(mapaRespBody);
        notifyListeners();
        // print(tareaCalificacionResponse.lastattempt!.submission!.status);
        print(response.body);
        return tareaCalificacionResponse;
      }
    } catch (e) {
      print('error en la response tarea: $e');
    }
    notifyListeners();
    return TareaCalificacionResponse();
  }
}
