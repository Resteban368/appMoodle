// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/ForoResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ForoDiscussionService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'mod_forum_get_discussion_posts';
  final String _moodlewsrestformat = 'json';

  Future<List<PostModel>?> getForo(int discussionid) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&discussionid=$discussionid';
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
}
