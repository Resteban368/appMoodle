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
  final String _moodlewsrestformat = 'json';
  int count = 0;

  Future<List<PostNotificaciones>?> getNotificaciones(useridto) async {
    String _wsfunction = 'message_popup_get_popup_notifications';
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
        return notificaciones;
      }
    } catch (e, s) {
      print('error en el provider de info site: $e');
      print(s);
    }
    return null;
  }

  //marcar como leido todas las notificaciones
  Future<bool> marcarNotificaciones(useridto) async {
    String _wsfunction = 'core_message_mark_all_notifications_as_read';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&useridto=$useridto';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        notifyListeners();
        return true;
      }
    } catch (e, s) {
      print('error en el provider de info site: $e');
      print(s);
    }
    return false;
  }

//para saber el count de las notificaciones
  Future<int> getCountNotificaciones(useridto) async {
    String _wsfunction = 'message_popup_get_unread_popup_notification_count';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&useridto=$useridto';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        count = int.parse(response.body);
        notifyListeners();
        print('contador notificaciones: $count');
        return count;
      }
    } catch (e, s) {
      print('error en el provider de info site: $e');
      print(s);
    }
    return 0;
  }

//marcar una notificacion ledia por id
  Future<void> leidaId(int notificationid) async {
    String _wsfunction = 'core_message_mark_notification_read';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&notificationid=$notificationid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        notifyListeners();
      }
    } catch (e, s) {
      print('error en el service de info site: $e');
      print(s);
    }
  }
}
