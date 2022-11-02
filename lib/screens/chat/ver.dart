import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import 'export_chat.dart';

class Ver extends StatefulWidget {
  int userid;
  int conversationid;

  Ver(this.conversationid, this.userid, {Key? key}) : super(key: key);
  @override
  State<Ver> createState() => _VerState();
}

class _VerState extends State<Ver> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte de chat'),
      ),
      body: Center(
          child: file != null
              ? PDFView(
                  filePath: file?.path,
                  autoSpacing: false,
                  pageFling: false,
                )
              : Container()),
    );
  }

  @override
  void initState() {
    getPdf();
    super.initState();
  }

  void getPdf() async {
    Uint8List uint8list =
        await generateDocument(widget.userid, widget.conversationid);
    Directory output = await getTemporaryDirectory();
    file = File(output.path + "/example.pdf");
    setState(() {
      file?.writeAsBytes(uint8list);
      print(file?.path);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}
