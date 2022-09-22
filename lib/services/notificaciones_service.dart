// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/PostNotificaciones.dart';

class NotificacionesService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'message_popup_get_popup_notifications';
  final String _moodlewsrestformat = 'json';

  Future<List<PostNotificaciones>?> getNotificaciones(useridto) async {
    print('service nortificaciones');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&useridto=$useridto';
    try {
      final response = await http.get(Uri.parse(url));
      // print('url site info provider: $url');
      if (response.statusCode < 400) {
        List<PostNotificaciones> notificaciones = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['notifications']) {
          notificaciones.add(PostNotificaciones.fromMap(element));
        }
        notifyListeners();
        print(notificaciones);
        return notificaciones;
      }
    } catch (e, s) {
      print('error en el provider de info site: $e');
      print(s);
    }
    return null;
  }
}
