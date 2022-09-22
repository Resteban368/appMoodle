// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';

class UrlScreen extends StatefulWidget {
  Module contenido;
  UrlScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<UrlScreen> createState() => _UrlScreenState();
}

class _UrlScreenState extends State<UrlScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    final url = widget.contenido.contents![0].fileurl!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contenido.name!),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: WebView(
        initialUrl: url,

        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        // onProgress: (int progress) {
        //   print('WebView is loading (progress : $progress%)');
        // },
        // navigationDelegate: (NavigationRequest request) {
        //   if (request.url.startsWith('https://www.youtube.com/')) {
        //     print('blocking navigation to $request}');
        //     return NavigationDecision.prevent;
        //   }
        //   print('allowing navigation to $request');
        //   return NavigationDecision.navigate;
        // },
        // onPageStarted: (String url) {
        //   print('Page started loading: $url');
        // },
        // onPageFinished: (String url) {
        //   print('Page finished loading: $url');
        // },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }
}
