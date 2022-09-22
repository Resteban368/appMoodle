import 'dart:convert';

import 'package:campus_virtual/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Foro.dart';

class ForoDiscussionService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'mod_forum_get_discussion_posts';
  final String _moodlewsrestformat = 'json';

  //variable list de category
  // List<Category>? discusion = [];

  Future<List<PostModel>?> getForo(int forumID) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url = 'http://192.168.1.3:8000/api/foroDiscusiones/foro/$forumID';
    print(url);
    final response = await http.get(Uri.parse(url));
    final Foro decodata = Foro.fromJson(json.decode(response.body));

    final discussionid = (decodata.category![0].id);
    if (decodata.category![0].id == null) {
      return null;
    } else {
      final url2 =
          '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&discussionid=$discussionid';
      try {
        final response2 = await http.get(Uri.parse(url2));
        if (response2.statusCode < 400) {
          List<PostModel> posts = [];
          Map<String, dynamic> mapaRespBody = json.decode(response2.body);
          for (var element in mapaRespBody['posts']) {
            posts.add(PostModel.fromMap(element));
          }
          notifyListeners();
          print(posts);
          return posts;
        }
      } catch (e) {
        print('error en el post de contenido curso: $e');
      }
    }
    notifyListeners();
    return null;
  }
}
