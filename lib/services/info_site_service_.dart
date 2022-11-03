// ignore_for_file: avoid_print

import 'package:campus_virtual/models/InfoSite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/InfoSite.dart';

class InfoSiteService extends ChangeNotifier {
  //varaibles para la peticion de la informacion del usuario
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'core_webservice_get_site_info';
  final String _moodlewsrestformat = 'json';
  late InfoSiteUser infoSite = InfoSiteUser();

// Obtain shared preferences.

// Save an integer value to 'counter' key.

  Future<String?> getInfoSite() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
        '$_baseUrl${_url}wsfunction=$_wsfunction&moodlewsrestformat=$_moodlewsrestformat&wstoken=$token';
    try {
      final response = await http.get(Uri.parse(url));
      // print('url site info provider: $url');
      if (response.statusCode < 400) {
        // print('status code info site: ${response.statusCode}');
        // print(response.body);
        //guardamos el id en el storage

        final InfoSiteUser decodeData = InfoSiteUser.fromJson(response.body);
        infoSite = decodeData;

        //guardamos el id en el storage scure
        print('guardando datos al secure storage');
        await storage.write(key: 'id', value: decodeData.userid.toString());
        //guardamos el nombre el storage scure
        await storage.write(key: 'username', value: decodeData.username!);

        //guardamos el fullname el storage scure
        await storage.write(key: 'fullname', value: decodeData.fullname!);

        notifyListeners();
      }
    } catch (e) {
      print('error en el provider de info site: $e');
    }
    return '';
  }
}
