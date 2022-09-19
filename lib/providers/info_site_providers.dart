import 'package:campus_virtual/models/InfoSite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/InfoSite.dart';

class SiteProvider extends ChangeNotifier {
  //varaibles para la peticion de la informacion del usuario
  final String _baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  final String _url = '/webservice/rest/server.php?';
  final String _wsfunction = 'core_webservice_get_site_info';
  final String _moodlewsrestformat = 'json';
  late InfoSiteUser infoSite = InfoSiteUser();

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
        final InfoSiteUser decodeData = InfoSiteUser.fromJson(response.body);
        infoSite = decodeData;
        notifyListeners();
      }
    } catch (e) {
      print('error en el provider de info site: $e');
    }
    return '';
  }
}
