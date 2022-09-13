// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../theme/app_bar_theme.dart';
import 'materias_curso_screen.dart';

class CursosScreen extends StatelessWidget {
  const CursosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final siteInfo = Provider.of<SiteProvider>(context, listen: false);
    final cursoInfo = Provider.of<CursoProvider>(context, listen: false);
    final providerGeneral =
        Provider.of<GeneralProvider>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    //mandamos a llamar el token para usarlo en esta clase

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Cursos'),
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
        body: FutureBuilder(
          future: cursoInfo.getInfoCurso(siteInfo.infoSite.userid!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.84,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    final urlImg = snapshot.data![i].overviewfiles![i].fileurl +
                        '?token=$token';
                    return ElasticInDown(
                      child:
                          //creamos una card para poner los cursos
                          Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppTheme.primary),
                                borderRadius: BorderRadius.circular(10),
                                //sombra
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.book,
                                      color: AppTheme.primary,
                                      size: 40,
                                    ),
                                    title: Text(snapshot.data[i].fullname,
                                        style: const TextStyle(fontSize: 20)),
                                    subtitle: const Text('Semestre 1'),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: urlImg,
                                    fit: BoxFit.fill,
                                  ),
                                  // Image.network(
                                  //   urlImg,

                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ButtonBar(
                                    children: [
                                      Center(
                                        child: FlatButton(
                                          color: AppTheme.primary,
                                          //poner el color del texto en blanco
                                          textColor: Colors.white,
                                          //poner borderradius
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),

                                          child: const Text('Ver Temas'),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MateriasScreen(
                                                            snapshot.data[i])));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
