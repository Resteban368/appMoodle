// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';

class ContenidoSemestral extends StatelessWidget {
  int id;
  ContenidoSemestral(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contenido semestral'),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.9,
        child: FutureBuilder(
          future: category.getCategoryById(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return WebView(
                initialUrl: Uri.dataFromString(snapshot.data[0].description,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString(),
                javascriptMode: JavascriptMode.unrestricted,
              );
            }
          },
        ),
      ),
    );
  }
}
