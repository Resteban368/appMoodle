import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_bar_theme.dart';

class PaginaScreen extends StatefulWidget {
  Module contenido;
  PaginaScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<PaginaScreen> createState() => _PaginaScreenState();
}

class _PaginaScreenState extends State<PaginaScreen> {
  @override
  void initSate() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final providerGeneral =
        Provider.of<GeneralProvider>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    final url = widget.contenido.contents![0].fileurl! + '&token=$token';
    print(url);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página'),
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
      ),
    );
  }
}
