// ignore_for_file: must_be_immutable, unused_element

import 'package:campus_virtual/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class TareaScreen extends StatefulWidget {
  Module contenido;
  TareaScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarea '),
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
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  _ContainerBanner(widget.contenido),
                  const SizedBox(height: 5),
                  _ContainerInformacionTarea(widget.contenido),
                  const SizedBox(height: 5),
                  // _ComentarioTarea(widget.contenido),
                ],
              ),
            ),
          ),
        ));
  }
}

class _ContainerBanner extends StatelessWidget {
  Module contenido;
  _ContainerBanner(
    this.contenido, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
        elevation: 3,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              contenido.name!,
              style: const TextStyle(fontSize: 20, color: AppTheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
            child: Row(
              children: [
                Text(
                  contenido.dates![0].label!,
                  style: const TextStyle(color: AppTheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(getData(contenido.dates![0].timestamp!)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
            child: Row(
              children: [
                Text(
                  contenido.dates![1].label!,
                  style: const TextStyle(color: AppTheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Text(getData(contenido.dates![1].timestamp!)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _ContainerInformacionTarea extends StatelessWidget {
  Module contenido;
  _ContainerInformacionTarea(
    this.contenido, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tarea = Provider.of<TareaService>(context, listen: false);
    //PROVIDER DE SITEiNFO
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);

    return FutureBuilder(
        future: tarea.getTarea(siteInfo.infoSite.userid!, contenido.instance!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              final tarea = snapshot.data;
              return const Text('helo');
              // return SizedBox(
              //   width: double.infinity,
              //   height: MediaQuery.of(context).size.height * 0.5,
              //   child: Card(
              //     elevation: 3,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(children: [
              //         const Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Text(
              //             'Estado de la entrega',
              //             style:
              //                 TextStyle(fontSize: 22, color: AppTheme.primary),
              //           ),
              //         ),
              //         const SizedBox(height: 10),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 2.0, left: 2.0),
              //                 child: Text('Estado de la entrega: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: Text(''),
              //                 )),
              //           ],
              //         ),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 2.0, left: 2.0),
              //                 child: Text('Estado de la calificación: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: Text(''),
              //                 )),
              //           ],
              //         ),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 8.0, left: 2.0),
              //                 child: Text('Tiempo restante: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: const Padding(
              //                   padding: EdgeInsets.only(left: 8.0, right: 8.0),
              //                   child: Text(''),
              //                 )),
              //           ],
              //         ),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 2.0, left: 2.0),
              //                 child: Text('Última modificación: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     tarea.lastattempt.submission ?? 0
              //                         ? getData(tarea
              //                             .lastattempt!
              //                             .submission!
              //                             .plugins![0]
              //                             .fileareas![0]
              //                             .files![0]
              //                             .timemodified)
              //                         : 'No hay mofigicaciones',
              //                   ),
              //                 )),
              //           ],
              //         ),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 2.0, left: 2.0),
              //                 child: Text('Archivos enviados: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       tarea.lastattempt!.submission!.plugins![0]
              //                                   .fileareas![0].files.length >
              //                               0
              //                           ? tarea
              //                               .lastattempt!
              //                               .submission!
              //                               .plugins![0]
              //                               .fileareas![0]
              //                               .files![0]
              //                               .filename
              //                           : 'No hay archivos',
              //                     ))),
              //           ],
              //         ),
              //         const Divider(),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: MediaQuery.of(context).size.width * 0.3,
              //               height: MediaQuery.of(context).size.height * 0.05,
              //               child: const Padding(
              //                 padding: EdgeInsets.only(top: 2.0, left: 2.0),
              //                 child: Text('Comentarios de la entrega: ',
              //                     style: TextStyle(color: AppTheme.primary)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             SizedBox(
              //                 width: MediaQuery.of(context).size.width * 0.6,
              //                 height: MediaQuery.of(context).size.height * 0.05,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: Text('Comentarios (0)'),
              //                 )),
              //           ],
              //         ),
              //       ]),
              //     ),
              //   ),
              // );
            } else {
              return const Text('No hay tarea');
            }
          }
        });
  }
}

class _ComentarioTarea extends StatelessWidget {
  Module contenido;
  _ComentarioTarea(
    this.contenido, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tarea = Provider.of<TareaService>(context, listen: false);

    String newValue = '';
    String html = '';

    return FutureBuilder(
        future: tarea.getTarea(3, contenido.instance!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final tarea = snapshot.data;

          if (snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Comentario',
                        style: TextStyle(fontSize: 22, color: AppTheme.primary),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 2.0),
                            child: Text('Calificacion: ',
                                style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(newValue),
                                ],
                              ),
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 2.0),
                            child: Text('Calificado sobre: ',
                                style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(''),
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 2.0),
                            child: Text('Calificado por: ',
                                style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(''),
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 2.0),
                            child: Text('Comentarios de retroalimentación: ',
                                style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Html(
                                    data: html,
                                    style: {
                                      'body': Style(
                                          fontSize: const FontSize(14),
                                          //justificar todo el texto
                                          textAlign: TextAlign.justify),
                                    },
                                  ),
                                ))),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 2.0),
                            child: Text('Archivos de retroalimentación: ',
                                style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tarea.feedback!.plugins![2]
                                  .fileareas![0].files![0].filename),
                            )),
                      ],
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
