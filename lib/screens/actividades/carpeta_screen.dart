// ignore_for_file: deprecated_member_use, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:campus_virtual/services/sevices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
import '../../theme/theme.dart';

class CarpetaScreen extends StatelessWidget {
  Module contenido;
  CarpetaScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Carpeta'),
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Row(
                children: [
                  Image.asset(
                    'images/folder.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    contenido.name!,
                    style:
                        const TextStyle(fontSize: 30, color: AppTheme.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                itemCount: contenido.contents!.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                    child: GestureDetector(
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                            title: Text(
                                contenido.contents![i].filename.toString()),
                            leading: Column(
                              children: [
                                const SizedBox(height: 5),
                                Image.asset(
                                  'images/files.png',
                                  fit: BoxFit.contain,
                                  height: 40,
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.download,
                                color: AppTheme.primary, size: 30)),
                      ),
                      onTap: () async {
                        await launch(
                            contenido.contents![0].fileurl! + '&token=$token');
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
