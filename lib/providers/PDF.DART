import 'dart:async';

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(url);
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

}