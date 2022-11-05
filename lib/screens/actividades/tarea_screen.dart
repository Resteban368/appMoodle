// ignore_for_file: must_be_immutable, unused_element, unrelated_type_equality_checks, deprecated_member_use, prefer_const_constructors

import 'package:campus_virtual/screens/actividades/url_PdfScreen.dart';
import 'package:campus_virtual/services/tarea_service.dart';
import 'package:campus_virtual/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
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
          title: const Text('Nombre Tarea'),
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
                  _ContainerInformacionTarea(widget.idTarea, userid2),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ));
  }
}

class _ContainerBanner extends StatefulWidget {
  final int idTarea;
  final int userid;

  const _ContainerBanner(
    this.idTarea,
    this.userid, {
    Key? key,
  }) : super(key: key);

  @override
  State<_ContainerBanner> createState() => _ContainerBannerState();
}

class _ContainerBannerState extends State<_ContainerBanner> {
  @override
  Widget build(BuildContext context) {
    final tareaService = Provider.of<TareaService>(context, listen: false);
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.23,
        child: FutureBuilder(
          future: tareaService.getFechasTare(widget.userid, widget.idTarea),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final fechaDate = snapshot.data;

              //Todo: fechas
              // final fechaFinal = getFechaNormal(fechaDate.duedate);
              // final fechaConvertida = DateTime.parse(fechaFinal);

              // final fechaHoy = DateTime.now();
              // var diferencia = fechaConvertida.difference(fechaHoy);
              // final diferenciaTotal = (' Minutos: ${diferencia.inMinutes}');

              // final minutos = diferencia.inMinutes;

              // final tiempo = getTiempo(minutos);

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
                          'Apertura :',
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
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Cierre :',
                          style: TextStyle(color: AppTheme.primary),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Text(getData(fechaDate.duedate)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0, left: 10.0),
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
                          child: Text('tiempo'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.046,
                    color: AppTheme.primary,
                    child: FutureBuilder(
                        future: tareaService.getDispacherid(widget.idTarea),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Cargando...',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            final tarea = snapshot.data;
                            return MaterialButton(
                              onPressed: () {
                                if (tarea.length == 0) {
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PDFViewerFromUrl(
                                                url: tarea[0].src,
                                              )));
                                }
                              },
                              child: const Text(
                                'Evidencia de aprendizaje',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                        }),
                    //boton material
                  )
                ]),
              );
            }
          },
        ));
  }
}

class _ContainerInformacionTarea extends StatelessWidget {
  int idTarea;
  int userid;
  _ContainerInformacionTarea(
    this.idTarea,
    this.userid, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tarea = Provider.of<TareaService>(context, listen: false);
    //PROVIDER DE SITEiNFO

    return FutureBuilder(
        future: tarea.getTarea(userid, idTarea),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final tarea = snapshot.data;
            print('idTarea$idTarea');
            return _EstadoEntrega(tarea);
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
    String nota;
    String resultNota;
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1.5,
      child: Column(children: [
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tarea.lastattempt!.submission?.status ==
                                'submitted')
                              const Text('Enviado para calificar')
                            else if (tarea.lastattempt!.submission?.status ==
                                'draft')
                              const Text('Borrador (no enviado)')
                            else
                              const Text('No entregado')
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
                        child: (tarea.lastattempt!.graded == false)
                            ? const Text('Sin calificar')
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
                    child: Container(
                        color: Colors.grey[200],
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: tarea
                                        .lastattempt!
                                        .submission!
                                        .plugins![0]
                                        .fileareas![0]
                                        .files
                                        ?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
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
                                                  .filename ??
                                              '',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        subtitle: Text(
                                            getFecha(tarea
                                                    .lastattempt!
                                                    .submission!
                                                    .plugins![0]
                                                    .fileareas![0]
                                                    .files![index]
                                                    .timemodified ??
                                                0),
                                            style:
                                                const TextStyle(fontSize: 11)),
                                      ),
                                      onTap: () async {
                                        const storage = FlutterSecureStorage();
                                        final token =
                                            await storage.read(key: 'token');
                                        final url = tarea
                                            .lastattempt!
                                            .submission!
                                            .plugins![0]
                                            .fileareas![0]
                                            .files![0]
                                            .fileurl;
                                        // print('$url?token=$token');
                                        await launch('$url?token=$token');
                                      },
                                    ),
                                  );
                                }))),
                  ),
                ],
              ),
            ]),
          ),
        ),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                          child: (tarea.lastattempt!.graded == 'false')
                              ? const Text('Sin calificar')
                              : Text(
                                  '${tarea.feedback?.gradefordisplay.replaceAll('&nbsp;', '')}',
                                ))),
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
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (tarea.lastattempt!.graded == 'false')
                              ? const Text('Sin calificar')
                              : Text(
                                  getData(tarea.feedback?.gradeddate ?? 0),
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
                        child: Text('Comentarios de retroalimentación: ',
                            style: TextStyle(color: AppTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                        color: Colors.grey[200],
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Html(
                                data: tarea.feedback?.plugins?[0]
                                        .editorfields?[0].text ??
                                    '-',
                                style: {
                                  'body': Style(
                                      fontSize: const FontSize(14),
                                      //justificar todo el texto
                                      color: Colors.black,
                                      textAlign: TextAlign.justify),
                                },
                              ),
                            ))),
                  ],
                ),
                const Divider(),
                (tarea.lastattempt!.graded == 'false')
                    ? const SizedBox()
                    : Row(
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
                          SingleChildScrollView(
                            child: Container(
                                color: Colors.grey[200],
                                width: MediaQuery.of(context).size.width * 0.6,
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        itemCount:
                                            (tarea.feedback?.plugins?.length ==
                                                    1)
                                                ? tarea.feedback!.plugins![0]
                                                    .fileareas![0].files!.length
                                                : tarea
                                                        .feedback
                                                        ?.plugins?[2]
                                                        .fileareas?[0]
                                                        .files
                                                        ?.length ??
                                                    0,
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
                                                title: (tarea.feedback?.plugins
                                                            ?.length ==
                                                        1)
                                                    ? Text(tarea
                                                        .feedback!
                                                        .plugins![0]
                                                        .fileareas![0]
                                                        .files![index]
                                                        .filename!)
                                                    : Text(
                                                        tarea
                                                                .feedback
                                                                ?.plugins?[2]
                                                                .fileareas?[0]
                                                                .files?[index]
                                                                .filename ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                subtitle: (tarea.feedback
                                                            ?.plugins?.length ==
                                                        1)
                                                    ? Text(getFecha(tarea
                                                            .feedback!
                                                            .plugins![0]
                                                            .fileareas![0]
                                                            .files![index]
                                                            .timemodified ??
                                                        0))
                                                    : Text(
                                                        getFecha(tarea
                                                                .feedback
                                                                ?.plugins?[2]
                                                                .fileareas?[0]
                                                                .files?[index]
                                                                .timemodified ??
                                                            0),
                                                        style: const TextStyle(
                                                            fontSize: 11)),
                                              ),
                                              onTap: () async {
                                                const storage =
                                                    FlutterSecureStorage();
                                                final token = await storage
                                                    .read(key: 'token');

                                                if (tarea.feedback?.plugins
                                                        ?.length ==
                                                    1) {
                                                  final url = tarea
                                                          .feedback
                                                          ?.plugins?[0]
                                                          .fileareas?[0]
                                                          .files?[index]
                                                          .fileurl ??
                                                      '';
                                                  await launch(
                                                      '$url?token=$token');
                                                } else {
                                                  final url = tarea
                                                          .feedback
                                                          ?.plugins?[2]
                                                          .fileareas?[0]
                                                          .files?[index]
                                                          .fileurl ??
                                                      '';
                                                  await launch(
                                                      '$url?token=$token');
                                                }
                                              },
                                            ),
                                          );
                                        }))),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

//

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
