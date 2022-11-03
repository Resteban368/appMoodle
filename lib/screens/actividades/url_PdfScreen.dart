// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';

class UrlPDFScreen extends StatefulWidget {
  Module contenido;
  UrlPDFScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<UrlPDFScreen> createState() => _UrlPDFScreenState();
}

class _UrlPDFScreenState extends State<UrlPDFScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    final url = widget.contenido.contents![0].fileurl! + '&token=' + token;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.contenido.name!),
          backgroundColor: AppTheme.primary,
          actions: [
            //iconbuton para descargar el pdf
            IconButton(
                onPressed: () async {
                  // ignore: deprecated_member_use
                  await launch(url);
                  //descargar pdf
                },
                icon: const Icon(Icons.download))
          ],
        ),
        body: PDFViewerFromUrl(
          url: url.toString(),
        ));
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PDF().fromUrl(
        url,
        // placeholder: (double progress) => Center(child: Text('$progress %')),
        placeholder: (double progress) => Center(
          child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_poqmycwy.json'),
        ),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

// class PDFViewerCachedFromUrl extends StatelessWidget {
//   const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

//   final String url;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cached PDF From Url'),
//       ),
//       body: const PDF().cachedFromUrl(
//         url,
//         placeholder: (double progress) => Center(child: Text('$progress %')),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
//     );
//   }
// }
