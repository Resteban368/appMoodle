import 'dart:convert';

import 'package:campus_virtual/models/Foro.dart';
import 'package:campus_virtual/models/ForumDiscussion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/FirstForo.dart';

class ForoDiscussionService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'mod_forum_get_discussion_posts';
  final String _moodlewsrestformat = 'json';
  late Discussion foroDiscusion = Discussion();

  //variable list de category
  List<Category>? discusion = [];

  // Future<String?> gettForoDisccussion(discussionid) async {
  //   const storage = FlutterSecureStorage();
  //   final token = await storage.read(key: 'token');
  //   final int discuid = discussionid;
  //   final url =
  //       '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&discussionid=$discuid';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode < 400) {
  //       print(response.statusCode);
  //       print(response.body);
  //       final Discussion decodeData = Discussion.fromJson(response.body);
  //       foroDiscusion = decodeData;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print('error en el provider de Forum Disscussion: $e');
  //   }
  //   return '';
  // }

  Future<List<DiscussionForo>?> getForo(int forumID) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url = 'http://192.168.1.3:8000/api/foroDiscusiones/foro/$forumID';
    print(url);
    final response = await http.get(Uri.parse(url));
    final Foro decodata = Foro.fromJson(json.decode(response.body));
    discusion = decodata.category!;
    final discussionid = (decodata.category![0].id);
    if (decodata.category![0].id == null) {
      return null;
    } else {
      final url2 =
          '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&discussionid=$discussionid';
      print(url2);
      final response2 = await http.get(Uri.parse(url2));

      final body = json.decode(response2.body) as Map<String, dynamic>;
      final identifacions = List.generate(
        body.length,
        (index) => DiscussionForo.fromMap(
          body[index] as Map<String, dynamic>,
        ),
      );
      // if (response2.statusCode < 400) {
      //   List<DiscussionForo> contenidoForo = [];
      //   List<String> mapaRespBody = json.decode(response.body);
      //   print(mapaRespBody);
      //   for (var element in mapaRespBody) {
      //     contenidoForo.add(DiscussionForo.fromJson(element));
      //   }
      //   // final Discussion decodeData = Discussion.fromMap(response.body);
      //   // foroDiscusion = decodeData;
      print(identifacions);
      //   notifyListeners();
      return identifacions;
      // }
    }
    notifyListeners();
    return null;
  }
}
