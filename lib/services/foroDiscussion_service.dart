// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:campus_virtual/models/ForoResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ForoDiscussionService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  final TextEditingController controllerMessage = TextEditingController();

  Future<List<PostModel>?> getForo(int discussionid) async {
    print('get foro');
    const String wsfunction = 'mod_forum_get_discussion_posts';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&discussionid=$discussionid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        List<PostModel> posts = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['posts']) {
          posts.add(PostModel.fromMap(element));
        }
        notifyListeners();
        return posts;
      }
    } catch (e) {
      print('error en el post de contenido curso: $e');
    }
    notifyListeners();
    return null;
  }

  Future<String?> addPost(int postid, String subject, String message) async {
    const String wsfunction = 'mod_forum_add_discussion_post';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token'));
    request.bodyFields = {
      'postid': '$postid',
      'subject': subject,
      'message': message
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
    return '';
  }
}
