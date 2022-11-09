// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/screens/Cursos/contenidoSemestral.dart';
import 'package:campus_virtual/screens/actividades/url_PdfScreen.dart';
import 'package:campus_virtual/services/sevices.dart';
import 'package:campus_virtual/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/models.dart';
import '../../theme/app_bar_theme.dart';
import '../screens.dart';
import 'package:campus_virtual/utils/utils.dart';

class MateriasScreen extends StatelessWidget {
  ResultCursos contenido;

  MateriasScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cursoIContenido =
        Provider.of<CursoContenidoService>(context, listen: false);
    // final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    // final token = providerGeneral.tokencillo.toString();
    // final urlImg = contenido.overviewfiles![0].fileurl! + '?token=$token';
    final htmlData = contenido.summary;
    return Scaffold(
      appBar: AppBar(
        title: Text(contenido.fullname!, style: const TextStyle(fontSize: 18)),
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
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: AppTheme.primary,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset(
                        'images/course-default.png',
                        fit: BoxFit.fill,
                      )),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Html(
                        data: htmlData,
                        style: {
                          'body': Style(
                              fontSize: const FontSize(15),
                              //justificar todo el texto
                              textAlign: TextAlign.justify),
                        },
                      )),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContenidoSemestral(contenido.id!)));
            },
            child: const Text('Contenido Semestral'),
            color: AppTheme.primary,
            textColor: Colors.white,
          ),
          _Temas(cursoIContenido: cursoIContenido, contenido: contenido),
        ],
      ),
    );
  }
}

class _Temas extends StatelessWidget {
  const _Temas({
    Key? key,
    required this.cursoIContenido,
    required this.contenido,
  }) : super(key: key);

  final CursoContenidoService cursoIContenido;
  final ResultCursos contenido;

// arrglo de  7 iconos

  @override
  Widget build(BuildContext context) {
    final List<Icon> iconos = [
      Icon(
        Icons.slow_motion_video_sharp,
        color: Colors.red[600],
      ),
      Icon(
        Icons.recent_actors,
        color: Colors.orange[900],
      ),
      Icon(
        Icons.assignment_ind_rounded,
        color: Colors.green[400],
      ),
      Icon(
        Icons.recent_actors,
        color: Colors.orange[900],
      ),
      Icon(
        Icons.assignment_ind_rounded,
        color: Colors.green[400],
      ),
      Icon(
        Icons.groups,
        color: Colors.blue[400],
      ),
      const Icon(
        Icons.person,
        color: AppTheme.primary,
      ),
      Icon(
        Icons.folder_sharp,
        color: Colors.amber[400],
      ),
    ];

    int indice;
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: FutureBuilder(
          future: cursoIContenido.getInfoCursoID(contenido.id!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: loaderCursoList(),
              );
            } else {
              return ListView.builder(
                // reverse: true,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  indice = int.parse((snapshot.data.length - i).toString());
                  return ElasticInDown(
                    child:
                        //creamos una card para poner los cursos
                        Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(
                          iconos[indice - 1].icon,
                          color: iconos[indice - 1].color,
                          size: 30,
                        ),
                        title: Text(snapshot.data[i].name!,
                            style: const TextStyle(fontSize: 18)),
                        subtitle: Text(snapshot.data[i].summary!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15)),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppTheme.primary,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      _ContenidoTemas(snapshot.data[i])));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class _ContenidoTemas extends StatelessWidget {
  // final CursoContenidoProvider cursoIContenido;
  ResponseDataCursoForId contenido;
  _ContenidoTemas(this.contenido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerGeneral = Provider.of<GeneralService>(context, listen: false);
    final token = providerGeneral.tokencillo.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contenido'),
        backgroundColor: AppTheme.primary,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                contenido.name!,
                style: const TextStyle(fontSize: 20, color: AppTheme.primary),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: contenido.modules!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ElasticInDown(
                        child: Column(children: [
                          if (contenido.modules![i].modplural == 'Etiquetas')
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                contenido.modules![i].name!,
                                style: const TextStyle(
                                    color: AppTheme.primary, fontSize: 20),
                              ),
                            )
                          else
                            Card(
                              // color: Colors.grey[200],
                              elevation: 2,
                              child: ListTile(
                                leading: Column(
                                  children: [
                                    if (contenido.modules![i].modplural! ==
                                        'Foros')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/Foros.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Carpetas')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/Carpetas.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'URLs')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/URLs.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Archivos')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/Archivos.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Páginas')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/Paginas.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Tareas')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/Tareas.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Asistencias')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/asistencia.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                    else if (contenido.modules![i].modplural! ==
                                        'Cuestionarios')
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Image.asset(
                                            'images/auto.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(contenido.modules![i].name!,
                                          style: const TextStyle(fontSize: 13)),
                                    ),
                                  ],
                                ),

                                // ignore: todo
                                //TODO: tRAILING
                                trailing: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (contenido.modules![i].modplural! ==
                                            'Tareas' ||
                                        contenido.modules![i].modplural! ==
                                            'Foros' ||
                                        contenido.modules![i].modplural! ==
                                            'Carpetas' ||
                                        contenido.modules![i].modplural! ==
                                            'Asistencias')
                                      const Icon(Icons.keyboard_arrow_right,
                                          color: AppTheme.primary, size: 30)
                                    else if (contenido.modules![i].modplural! ==
                                            'URLs' ||
                                        contenido.modules![i].modplural! ==
                                            'Páginas')
                                      const Icon(Icons.public_rounded,
                                          color: AppTheme.primary, size: 30)
                                    else if (contenido.modules![i].modplural! ==
                                        'Archivos')
                                      if (contenido.modules![i].contents![0]
                                              .mimetype ==
                                          'application/pdf')
                                        const Icon(Icons.picture_as_pdf_rounded,
                                            color: AppTheme.primary, size: 30)
                                      else
                                        const Icon(Icons.download,
                                            color: AppTheme.primary, size: 30),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    if (contenido
                                            .modules![i].contents?.isEmpty ??
                                        true)
                                      const Text('')
                                    else
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Tipo de Archivo: ' +
                                                contenido
                                                    .modules![i].modplural!,
                                          ),
                                        ),
                                      ),
                                    //Todo: implemtacion de los Date
                                    if (contenido.modules![i].dates?.isEmpty ??
                                        true)
                                      const Text('')
                                    else
                                      SizedBox(
                                        width: double.infinity,
                                        child: FittedBox(
                                          child: Row(
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        contenido.modules![i]
                                                            .dates![0].label!,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: AppTheme
                                                                .primary)),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: Text(
                                                        getData(contenido
                                                            .modules![i]
                                                            .dates![0]
                                                            .timestamp!),
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ]),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      contenido.modules![i]
                                                          .dates![1].label!,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: AppTheme
                                                              .primary)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: Text(
                                                      getData(contenido
                                                          .modules![i]
                                                          .dates![1]
                                                          .timestamp!),
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                onTap: () async {
                                  if (contenido.modules![i].modplural ==
                                      'Tareas') {
                                    //enviar a la pantalla de tareas
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TareaScreen(
                                                contenido
                                                    .modules![i].instance!)));
                                  } else if (contenido.modules![i].modplural ==
                                      'Archivos') {
                                    if (contenido.modules![i].contents![0]
                                            .mimetype ==
                                        'application/pdf') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UrlPDFScreen(
                                                      contenido.modules![i])));
                                    } else {
                                      await launch(contenido.modules![i]
                                              .contents![0].fileurl! +
                                          '&token=$token');
                                    }
                                  } else if (contenido.modules![i].modplural ==
                                      'Páginas') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaginaScreen(
                                                contenido.modules![i])));
                                  } else if (contenido.modules![i].modplural ==
                                      'Carpetas') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CarpetaScreen(
                                                contenido.modules![i])));
                                  } else if (contenido.modules![i].modplural ==
                                      'URLs') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaginaScreen(
                                                contenido.modules![i])));
                                  } else if (contenido.modules![i].modplural ==
                                      'Foros') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForoScreen(
                                                contenido.modules![i])));
                                  }
                                },
                              ),
                            ),
                        ]),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget loaderCursoList() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              child: ListTile(
                leading: const Icon(
                  Icons.book,
                  color: Colors.grey,
                ),
                title: Container(
                  width: 100,
                  height: 20,
                  color: Colors.red,
                ),
                subtitle: Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.primary,
                  size: 25,
                ),
              ),
            ),
          );
        }),
  );
}
