// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/DebateResponse.dart';

class DebateService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'mod_forum_get_forum_discussions';
  final String _moodlewsrestformat = 'json';

  final TextEditingController controllerSubject = TextEditingController();
  final TextEditingController controllerMessage = TextEditingController();
  late bool habilitarForm = false;

  Future<List<DiscussionResponse>?> getDebates(int forumid) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&forumid=$forumid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        List<DiscussionResponse> debates = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['discussions']) {
          debates.add(DiscussionResponse.fromMap(element));
        }
        notifyListeners();
        return debates;
      }
    } catch (e) {
      print('error en el post de contenido curso: $e');
    }
    notifyListeners();
    return null;
  }

  Future<String?> addDebate(int forumid, String subject, String message) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/webservice/rest/server.php?moodlewsrestformat=json&wsfunction=mod_forum_add_discussion&wstoken=97cf93157876231126fbd7d2e11aad3f'));
    request.bodyFields = {
      'forumid': '$forumid',
      'subject': subject,
      'message': message
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
    return '';
  }

  habilitarFormulario() {
    print(habilitarForm);
    habilitarForm = !habilitarForm;
    notifyListeners();
  }
}
