// class PaginaScreen extends StatefulWidget {
//   Module contenido;
//   PaginaScreen(this.contenido, {Key? key}) : super(key: key);

//   @override
//   State<PaginaScreen> createState() => _PaginaScreenState();
// }

// class _PaginaScreenState extends State<PaginaScreen> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final providerGeneral =
//     //     Provider.of<GeneralProvider>(context, listen: false);
//     // final token = providerGeneral.tokencillo.toString();
//     final url = widget.contenido.contents![0].fileurl! +
//         '&token=6551d6b4f1495fd4fcdaa64547703da2';
//     // final url2 =
//     //     'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/webservice/pluginfile.php/123/mod_page/content/index.html?forcedownload=1&token=$token';
//     final newUrl = url.replaceAll("forcedownload=1", "");
//     print(url);
//     print(newUrl);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.contenido.name!),
//         backgroundColor: AppTheme.primary,
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.notifications,
//               size: 30,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: WebView(
//         // initialUrl: url2,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//           webViewController.loadUrl(
//             'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/webservice/pluginfile.php/52/mod_page/content/index.html?&token=6551d6b4f1495fd4fcdaa64547703da2',

//             headers: {"Content-Disposition": "inline"},
//             //parametros
//           );
//         },
//         // onProgress: (int progress) {
//         //   print('WebView is loading (progress : $progress%)');
//         // },
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:convert';

import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
