// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatSolicitudService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';
  int count = 0;

  //aceptar solicitud de chat de contacto
  Future<void> acepetarSolicitud(int userid, int requesteduserid) async {
    String wsfunction = 'core_message_confirm_contact_request';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&requesteduserid=$requesteduserid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        notifyListeners();
      }
    } catch (e, s) {
      print('error en el servicio de solictudes de contactos: $e');
      print(s);
    }
  }

  //rechazar solicitud de chat de contacto
  Future<void> rechazarSolicitud(int userid, int requesteduserid) async {
    String wsfunction = 'core_message_decline_contact_request';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&requesteduserid=$requesteduserid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        notifyListeners();
      }
    } catch (e, s) {
      print('error en el servicio de solictudes de contactos: $e');
      print(s);
    }
  }
}
