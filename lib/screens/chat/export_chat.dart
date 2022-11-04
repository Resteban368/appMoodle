// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:campus_virtual/models/chat.dart';
import 'package:campus_virtual/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

Future<Uint8List> generateDocument(
    int userid, int conversationid, String fullname) async {
  final pw.Document doc = pw.Document();

  late ChatResponse messages = ChatResponse();
  const String baseUrl =
      'https://plataformavirtual.uniamazonia.edu.co/DistanciaVirtual';
  const String url = '/webservice/rest/server.php?';
  const String moodlewsrestformat = 'json';
  const String wsfunction = 'core_message_get_conversation';
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final url2 =
      '$baseUrl${url}wsfunction=$wsfunction&moodlewsrestformat=$moodlewsrestformat&wstoken=$token&conversationid=$conversationid&userid=$userid&includecontactrequests=1&includeprivacyinfo=1';
  try {
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode < 400) {
      final ChatResponse decodeData = ChatResponse.fromJson(response.body);
      messages = decodeData;
    }
  } catch (e) {
    print('error en el export chat-service: $e');
  }

  num numero = messages.messages?.length as num;

  doc.addPage(pw.MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        return pw.Container(
            child: pw.Text(
                'Reporte de conversación chat App Campus Virtual  ${DateTime.now()}',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (pw.Context context) => <pw.Widget>[
            pw.Header(
                level: 2,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('Reporte de conversación', textScaleFactor: 2),
                      pw.PdfLogo()
                    ])),
            //tabla con los datos del usuario
            pw.Table.fromTextArray(context: context, data: <List<String>>[
              <String>[
                'Nombre dl Usuario',
                'Fecha del Reporte',
                'Cantidad de mensajes',
                'Id del Usuario'
              ],
              <String>[
                fullname,
                '${DateTime.now()}',
                '$numero',
                '$userid',
              ],
            ]),

            //tabla con los datos de los participantes
            pw.Table.fromTextArray(context: context, data: <List<String>>[
              <String>[
                'Nombre de los Usuarios',
                'Id ',
              ],
              for (var i = 0; i < messages.members!.length; i++)
                <String>[
                  '${messages.members?[i].fullname}',
                  '${messages.members?[i].id}',
                ],
            ]),

            pw.Paragraph(text: ''),
            pw.Paragraph(text: 'Mensajes'),

            //TABLA CON LOS MENSAJES CON TAMANIO ESPECIFICO
            pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>[
                    'id del Usuario',
                    'Mensaje',
                    'Fecha',
                  ],
                  for (var i = 0; i < messages.messages!.length; i++)
                    <String>[
                      '${messages.messages?[i].useridfrom}',
                      '${messages.messages?[i].text}',
                      (getData(messages.messages![i].timecreated!)),
                    ],
                ],
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey200,
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(2))),
                //tamaño de las columnas
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(5),
                  2: pw.FlexColumnWidth(2),
                }),
            pw.Paragraph(text: 'Fin del reporte'),
          ]));

// //imprimir el pdf
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());

//compartir el pdf
  // await Printing.sharePdf(bytes: await doc.save(), filename: 'reporte.pdf');

  return doc.save();
}
