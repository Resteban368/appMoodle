// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CursosScreen extends StatelessWidget {
  const CursosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    final cursoInfo = Provider.of<CursoService>(context, listen: false);
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    //mandamos a llamar el token para usarlo en esta clase
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cursos'),
          backgroundColor: AppTheme.primary,
          actions: [
            NamedIcon(
              iconData: Icons.notifications,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificacionesScreen()));
              },
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
              if (snapshot.data.length == 0) {
                return Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.book, size: 100, color: AppTheme.primary),
                        Text(
                          'No hay cursos disponibles',
                          style: TextStyle(fontSize: 20, color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.84,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      // final urlImg =
                      //     snapshot.data![i].overviewfiles![0].fileurl +
                      //         '?token=$token';
                      // print(urlImg);
                      // final urlImg = 'https://via.placeholder.com/350x150';
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
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
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
                                    Container(
                                        color: AppTheme.primary,
                                        width: double.infinity,
                                        height: 200,
                                        child: Image.asset(
                                          'images/course-default.png',
                                          fit: BoxFit.fill,
                                        )),
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
                                                              snapshot
                                                                  .data[i])));
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
            }
          },
        ));
  }
}
