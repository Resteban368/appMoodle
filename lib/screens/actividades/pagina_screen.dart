import 'dart:async';
import 'dart:io';

import 'package:campus_virtual/services/sevices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_bar_theme.dart';

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
//     final providerGeneral =
//         Provider.of<GeneralProvider>(context, listen: false);
//     final token = providerGeneral.tokencillo.toString();
//     final url = widget.contenido.contents![0].fileurl! + '&token=$token';
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
//             // 'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/webservice/pluginfile.php/123/mod_page/content/index.html?forcedownload=1&token=7c66c6eb548e990c420ab25911f9ef17',
//             newUrl,
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

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaginaScreen extends StatefulWidget {
  Module contenido;

  PaginaScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  _PaginaScreen createState() => _PaginaScreen();
}

class _PaginaScreen extends State<PaginaScreen> {
  int _stackIndex = 1;
  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    final url = widget.contenido.contents![0].fileurl! + '&token=$token';
    // final url2 =
    //     'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual/webservice/pluginfile.php/123/mod_page/content/index.html?forcedownload=1&token=$token';
    final newUrl = url.replaceAll("forcedownload=1", "");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contenido.name!),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Expanded(
          child: IndexedStack(
            index: _stackIndex,
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(newUrl), headers: {
                  "Content-Type": "text/html",
                }),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform:
                      InAppWebViewOptions(useShouldOverrideUrlLoading: true),
                ),
                onLoadStop: (_, __) {
                  setState(() {
                    _stackIndex = 0;
                  });
                },
                onLoadError: (_, __, ___, ____) {
                  setState(() {
                    _stackIndex = 0;
                  });
                  //TODO: Show error alert message (Error in receive data from server)
                },
                onLoadHttpError: (_, __, ___, ____) {
                  setState(() {
                    _stackIndex = 0;
                  });
                  //TODO: Show error alert message (Error in receive data from server)
                },
              ),
              const SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
