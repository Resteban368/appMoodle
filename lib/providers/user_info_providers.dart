import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class UserInfoProvider extends ChangeNotifier {
  //varaibles para la peticion de la informacion del usuario
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'core_user_get_users_by_field';
  final String _moodlewsrestformat = 'json';
  final String _field = 'username';
  late InfoUser userInfo = InfoUser();

  final TextEditingController controllerProfileimageurlsmall =
      TextEditingController();
  final TextEditingController controllerProfileimageurl =
      TextEditingController();

  Future<String?> geInfoUser(String username) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token&field=$_field&values[0]=$username';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode < 400) {
      final InfoUser decodeData =
          InfoUser.fromJson(json.decode(response.body)[0]);
      userInfo = decodeData;
      userInfoController(decodeData);
      notifyListeners();
    }
    return '';
  }

  userInfoController(InfoUser userInfoController) {
    controllerProfileimageurlsmall.text =
        userInfoController.profileimageurlsmall!;
    controllerProfileimageurl.text = userInfoController.profileimageurl!;
  }
}
