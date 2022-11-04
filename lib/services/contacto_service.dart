// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ContactosService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  //lista de contactos

  Future<List<ResponseContacto>?> getContactos(int userid) async {
    const String _wsfunction = 'core_message_get_user_contacts';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid';
    try {
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode < 400) {
        // print('status code: ${resp.statusCode}');

        List<ResponseContacto> responseContactosData = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (var element in mapaRespBody) {
          responseContactosData.add(ResponseContacto.fromJson(element));
        }
        notifyListeners();
        return responseContactosData;
      }
    } catch (e) {
      print('error en el provider de contacto: $e');
    }
    return null;
  }

//buscar contacto

  Future<List<SearchResponse>?> searchContacto(String searchtext) async {
    const String _wsfunction = 'core_message_search_contacts';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&searchtext=$searchtext';
    try {
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode < 400) {
        // print('status code: ${resp.statusCode}');

        List<SearchResponse> responseContactosData = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (var element in mapaRespBody) {
          responseContactosData.add(SearchResponse.fromJson(element));
        }
        notifyListeners();
        return responseContactosData;
      }
    } catch (e) {
      print('error en el provider de  search contacto: $e');
    }
    return null;
  }

  //crear solicitud de contacto
  Future<String?> addSolicitud(int userid, int requesteduserid) async {
    const String _wsfunction = 'core_message_create_contact_request';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    var request = http.Request(
        'GET',
        Uri.parse(
            '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid&requesteduserid=$requesteduserid'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    notifyListeners();
    return '';
  }

  Future<List<SolicitudesResponse>?> getSolicitudes(int userid) async {
    const String _wsfunction = 'core_message_get_contact_requests';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid';
    try {
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode < 400) {
        // print('status code: ${resp.statusCode}');

        List<SolicitudesResponse> responseContactosData = [];
        List<dynamic> mapaRespBody = json.decode(resp.body);
        for (var element in mapaRespBody) {
          responseContactosData.add(SolicitudesResponse.fromJson(element));
        }
        notifyListeners();
        return responseContactosData;
      }
    } catch (e) {
      print('error en el provider de  search contacto: $e');
    }
    return null;
  }
}
