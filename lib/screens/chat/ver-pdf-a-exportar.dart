import 'dart:io';

import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'export_chat.dart';

class Ver extends StatefulWidget {
  int userid;
  int conversationid;
  String fullname;

  Ver(this.conversationid, this.userid, this.fullname, {Key? key})
      : super(key: key);
  @override
  State<Ver> createState() => _VerState();
}

class _VerState extends State<Ver> {
  File? file;
  Uint8List archivoPdf = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte de chat'),
        backgroundColor: AppTheme.primary,
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
    Uint8List uint8list = await generateDocument(
        widget.userid, widget.conversationid, widget.fullname);
    Directory output = await getTemporaryDirectory();
    file = File(output.path + "/example.pdf");
    setState(() {
      file?.writeAsBytes(uint8list);
      print('direccionnnnn: ${file?.path}');
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('file', file));
  }
}
