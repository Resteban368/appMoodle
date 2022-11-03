import 'dart:convert';

import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';

class PaginaScreen extends StatefulWidget {
  Module contenido;

  PaginaScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  _PaginaScreen createState() => _PaginaScreen();
}

class _PaginaScreen extends State<PaginaScreen> {
  Future<String?> getContent(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode < 400) {
      print('good');
      final content = response.body;
      print(content);
      return content;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    final url = widget.contenido.contents![0].fileurl! + '&token=$token';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(widget.contenido.name!),
        //accion del retroceder a la pagina anterior
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<String?>(
        future: getContent(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Html(data: snapshot.data);
            return WebView(
              initialUrl: Uri.dataFromString(snapshot.data!,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
            );
          } else {
            return Center(
              child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_poqmycwy.json'),
            );
          }
        },
      ),
    );
  }
}
