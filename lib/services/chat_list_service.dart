// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:campus_virtual/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/chat.dart';

class ChatListService extends ChangeNotifier {
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _moodlewsrestformat = 'json';

  final TextEditingController controllerMessage = TextEditingController();

  Future<List<Conversation>?> getChatList(int userid) async {
    const String wsfunction = 'core_message_get_conversations';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&userid=$userid';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        List<Conversation> chatList = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['conversations']) {
          chatList.add(Conversation.fromMap(element));
        }
        notifyListeners();
        return chatList;
      }
    } catch (e) {
      print('error en el chatList service: $e');
    }
    notifyListeners();
    return null;
  }

  late ChatResponse messages = ChatResponse();
  //peticion para obtener los mensajes de un chat
  Future<ChatResponse?> getMessages(int conversationid, int userid) async {
    const String wsfunction = 'core_message_get_conversation';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url2 =
        '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&conversationid=$conversationid&userid=$userid&includecontactrequests=1&includeprivacyinfo=1';
    try {
      final response = await http.get(Uri.parse(url2));
      if (response.statusCode < 400) {
        final ChatResponse decodeData = ChatResponse.fromJson(response.body);
        messages = decodeData;
        print(messages.messages?[0].text);
        notifyListeners();
        return messages;
      }
    } catch (e) {
      print('error en el chat-service: $e');
    }
    notifyListeners();
    return null;
  }

//funcion para enviar un mensajes
  Future<String?> addMessage(int conversationid, String text) async {
    const String wsfunction = 'core_message_send_messages_to_conversation';
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token'));
    request.bodyFields = {
      'conversationid': conversationid.toString(),
      'messages[0][text]': text,
      'messages[0][textformat]': '1'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

// // Todo: exportar mensajes a un pdf
//   Future<ChatResponse?> exportPdf(int conversationid, int userid) async {
//     const String wsfunction = 'core_message_get_conversation';
//     const storage = FlutterSecureStorage();
//     final token = await storage.read(key: 'token');
//     final url2 =
//         '$_baseUrl${_url}wsfunction=$wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&conversationid=$conversationid&userid=$userid&includecontactrequests=1&includeprivacyinfo=1';
//     try {
//       final response = await http.get(Uri.parse(url2));
//       if (response.statusCode < 400) {
//         final ChatResponse decodeData = ChatResponse.fromJson(response.body);
//         messages = decodeData;
//         print(messages.messages?[0].text);
//         notifyListeners();
//         return messages;
//       }
//     } catch (e) {
//       print('error en el export chat-service: $e');
//     }
//     notifyListeners();
//     return null;
//   }
}
