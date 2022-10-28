// ignore_for_file: must_be_immutable, unused_element

import 'dart:ffi';

import 'package:campus_virtual/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class TareaScreen extends StatefulWidget {
  int idTarea;
  TareaScreen(this.idTarea, {Key? key}) : super(key: key);

  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  late int userid2 = 0;
  @override
  void initState() {
    super.initState();
    funcion();
  }

  Future<int> funcion() async {
    const storage = FlutterSecureStorage();
    final id = await storage.read(key: 'id');
    final userid = int.parse(id!);
    userid2 = userid;
    setState(() {});
    return userid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nombre Tarea'),
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
                  _ContainerBanner(widget.idTarea, userid2),
                  const SizedBox(height: 5),
                  // _ContainerInformacionTarea(widget.contenido),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ));
  }
}

class _ContainerBanner extends StatelessWidget {
  final int idTarea;
  final int userid;
  const _ContainerBanner(
    this.idTarea,
    this.userid, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaService = Provider.of<TareaService>(context, listen: false);
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        child: FutureBuilder(
          future: tareaService.getFechasTare(userid, idTarea),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final fechaDate = snapshot.data;
              return Card(
                elevation: 3,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Nombre Tarea',
                      style: TextStyle(fontSize: 20, color: AppTheme.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Apertura',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child:
                              Text(getData(fechaDate.allowsubmissionsfromdate)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Cierre',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Text(getData(fechaDate.duedate)),
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            }
          },
        ));
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
        future: tarea.getTarea(3, 1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final tarea = snapshot.data;
            return _EstadoEntrega(tarea!);
            // return Container();
          }
        });
  }
}

class _EstadoEntrega extends StatelessWidget {
  TareaCalificacionResponse tarea;
  _EstadoEntrega(this.tarea, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1.5,
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Estado de la entrega',
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
                        child: Text('Estado de la entrega: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (tarea.lastattempt!.submission!.status ==
                                  'submitted')
                              ? const Text('Enviado para calificar')
                              : const Text('No entregado'),
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
                        child: Text('Estado de la calificación: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (tarea.feedback == null)
                              ? const Text('No calificado')
                              : const Text('Calificado')),
                    ),
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
                        child: Text('Tiempo restante: ',
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
                        child: Text('Última modificación: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(getData(
                              tarea.lastattempt!.submission!.timemodified!)),
                        )),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2.0, left: 2.0),
                        child: Text('Archivos enviados: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SingleChildScrollView(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: tarea.lastattempt!.submission!
                                      .plugins![0].fileareas![0].files!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      elevation: 2,
                                      child: GestureDetector(
                                        child: ListTile(
                                          trailing: Column(
                                            children: const [
                                              SizedBox(height: 15),
                                              Icon(
                                                Icons.download,
                                                color: AppTheme.primary,
                                              ),
                                            ],
                                          ),
                                          leading: Column(
                                            children: const [
                                              SizedBox(height: 15),
                                              Icon(
                                                Icons.insert_drive_file,
                                                color: AppTheme.primary,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          title: Text(
                                            tarea
                                                .lastattempt!
                                                .submission!
                                                .plugins![0]
                                                .fileareas![0]
                                                .files![index]
                                                .filename!,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          subtitle: Text(
                                              getFecha(tarea
                                                  .lastattempt!
                                                  .submission!
                                                  .plugins![0]
                                                  .fileareas![0]
                                                  .files![index]
                                                  .timemodified!),
                                              style: const TextStyle(
                                                  fontSize: 11)),
                                        ),
                                        onTap: () async {
                                          // print(tarea
                                          //     .lastattempt!
                                          //     .submission!
                                          //     .plugins![0]
                                          //     .fileareas![0]
                                          //     .files![0]
                                          //     .fileurl!);
                                          // await launch(tarea
                                          //     .lastattempt!
                                          //     .submission!
                                          //     .plugins![0]
                                          //     .fileareas![0]
                                          //     .files![0]
                                          //     .fileurl!);
                                        },
                                      ),
                                    );
                                  }))),
                    ),
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
                        child: Text('Comentarios de la entrega: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Comentarios (0)'),
                        )),
                  ],
                ),
              ]),
            ),
          ),
          Card(
            elevation: 2,
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
                Row(children: [
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
                      child: Text(''),
                    ),
                  ),
                ]),
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
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width * 0.6,
                    //     height: MediaQuery.of(context).size.height * 0.10,
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: SingleChildScrollView(
                    //           child: Html(
                    //             data: html,
                    //             style: {
                    //               'body': Style(
                    //                   fontSize: const FontSize(14),
                    //                   //justificar todo el texto
                    //                   textAlign: TextAlign.justify),
                    //             },
                    //           ),
                    //         ))),
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
                          child: Text(''),
                        )),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
    );
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
                                children: [(tarea!.fe)],
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
                              child: Text(''),
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
