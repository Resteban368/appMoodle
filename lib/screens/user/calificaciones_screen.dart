// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/services/sevices.dart';
import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CalificacionesScreen extends StatefulWidget {
  const CalificacionesScreen({Key? key}) : super(key: key);

  @override
  State<CalificacionesScreen> createState() => _CalificacionesScreenState();
}

class _CalificacionesScreenState extends State<CalificacionesScreen> {
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
          title: const Text('Calificaciones'),
          backgroundColor: AppTheme.primary,
        ),
        body: (userid2 == 8)
            ? const NotasDocenteScreen()
            : const NotasEstudianteScreen());
  }
}

class NotasEstudianteScreen extends StatefulWidget {
  const NotasEstudianteScreen({Key? key}) : super(key: key);

  @override
  State<NotasEstudianteScreen> createState() => _NotasEstudianteScreen();
}

class _NotasEstudianteScreen extends State<NotasEstudianteScreen> {
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
    final notasService = Provider.of<NotasService>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('Cursos que estoy tomando',
                style: TextStyle(fontSize: 20, color: AppTheme.primary)),
          ),
          FutureBuilder(
              future: notasService.getNotas(userid2),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: loaderCardListNotas());
                } else {
                  final notas = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: notas.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      return ElasticInDown(
                        child: GestureDetector(
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              leading: const Icon(
                                Icons.assessment,
                                color: AppTheme.primary,
                                size: 45,
                              ),
                              title: Text(notas[i].courseid.toString()),
                              subtitle: Text(
                                  'Calificacion ${notas[i].grade.toString()}'),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.primary,
                                size: 25,
                              ),
                            ),
                          ),
                          onTap: () {
                            //enviamos a la screen DetalleNotasCursoScreen
                            final int idcurso = notas[i].courseid;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetalleNotasCursoScreen(idcurso)));
                          },
                        ),
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}

class DetalleNotasCursoScreen extends StatefulWidget {
  DetalleNotasCursoScreen(this.idCurso, {Key? key}) : super(key: key);
  int idCurso;

  @override
  State<DetalleNotasCursoScreen> createState() =>
      _DetalleNotasCursoScreenState();
}

class _DetalleNotasCursoScreenState extends State<DetalleNotasCursoScreen> {
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
    final notasService = Provider.of<NotasService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.idCurso.toString()),
          backgroundColor: AppTheme.primary,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
              future: notasService.getItemNotas(userid2, widget.idCurso),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: loaderCardListNotas());
                } else {
                  final notasItems = snapshot.data;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Notas del curso',
                            style: TextStyle(
                                fontSize: 25, color: AppTheme.primary)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataTable(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.primary)),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Item de Calificación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ponderación calculada',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Calificación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Rango',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Porcentaje',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Retroalimentación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Aporte total al curso',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: notasItems[0].gradeitems.map<DataRow>((item) {
                              return DataRow(
                                selected: true,
                                cells: <DataCell>[
                                  DataCell(
                                    (item.itemname != null)
                                        ? Text(item.itemname.toString())
                                        : const Text('Total Curso'),
                                  ),
                                  DataCell(
                                    (item.weightformatted != null)
                                        ? Text(item.weightformatted.toString())
                                        : const Text('-'),
                                  ),
                                  DataCell(
                                    (item.graderaw != null)
                                        ? Text(item.graderaw.toString())
                                        : const Text('-'),
                                  ),
                                  DataCell(Text(
                                    //poner grademin y grademax
                                    '${item.grademin} - ${item.grademax}',
                                  )),
                                  DataCell(Text(
                                      item.percentageformatted.toString())),
                                  DataCell(
                                    SingleChildScrollView(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Html(
                                          data: item.feedback.toString(),
                                          style: {
                                            'body': Style(
                                                fontSize: const FontSize(14),
                                                //justificar todo el texto
                                                textAlign: TextAlign.justify),
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(
                                      item.percentageformatted.toString())),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ));
  }
}

class NotasDocenteScreen extends StatelessWidget {
  const NotasDocenteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notasService = Provider.of<NotasService>(context, listen: false);
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
          future: notasService.getAllStudentsNotas(2),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: loaderCardListNotas());
            } else {
              final notasallItems = snapshot.data;
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Informe del calificador',
                        style: TextStyle(
                            fontSize: 25,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Todos los participantes',
                        style:
                            TextStyle(fontSize: 25, color: AppTheme.primary)),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Nombre / Apellidos',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Accion',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Asistencia',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Primer Aprendizaje Autónomo',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Primer Producto de Interaprendizaje',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Autoevaluación Virtual',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Segundo Producto de Autoaprendizaje',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Segundo Producto de Interaprendizaje',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '2da. Autoevaluación virtual',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '1er. Heteroevaluación',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '2da. Heteroevaluación',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Coevaluación Virtual',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Total del curso',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: notasallItems.map<DataRow>((item) {
                          return DataRow(
                            selected: true,
                            cells: <DataCell>[
                              DataCell(
                                Text(item.userfullname.toString()),
                              ),
                              DataCell(
                                //boton de ver notas,
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                _EstudianteScreen(item.courseid,
                                                    item.userid)));
                                  },
                                  child: const Text('Ver notas'),
                                  //color del boton
                                  style: ElevatedButton.styleFrom(
                                      primary: AppTheme.primary),
                                ),
                              ),
                              DataCell(
                                (item.gradeitems[0].graderaw != null)
                                    ? Text(
                                        item.gradeitems[0].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[1].graderaw != null)
                                    ? Text(
                                        item.gradeitems[1].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[2].graderaw != null)
                                    ? Text(
                                        item.gradeitems[2].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[3].graderaw != null)
                                    ? Text(
                                        item.gradeitems[3].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[4].graderaw != null)
                                    ? Text(
                                        item.gradeitems[4].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[5].graderaw != null)
                                    ? Text(
                                        item.gradeitems[5].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[6].graderaw != null)
                                    ? Text(
                                        item.gradeitems[6].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[7].graderaw != null)
                                    ? Text(
                                        item.gradeitems[7].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[8].graderaw != null)
                                    ? Text(
                                        item.gradeitems[8].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[9].graderaw != null)
                                    ? Text(
                                        item.gradeitems[9].graderaw.toString())
                                    : const Text('-'),
                              ),
                              DataCell(
                                (item.gradeitems[10].graderaw != null)
                                    ? Text(
                                        item.gradeitems[10].graderaw.toString())
                                    : const Text('-'),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    ));
  }
}

class _EstudianteScreen extends StatelessWidget {
  int userid;
  int idCurso;

  _EstudianteScreen(this.idCurso, this.userid, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notasService = Provider.of<NotasService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(idCurso.toString()),
          backgroundColor: AppTheme.primary,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
              future: notasService.getItemNotas(userid, idCurso),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: loaderCardListNotas());
                } else {
                  final notasItems = snapshot.data;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Notas del curso',
                            style: TextStyle(
                                fontSize: 25, color: AppTheme.primary)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataTable(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.primary)),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Item de Calificación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ponderación calculada',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Calificación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Rango',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Porcentaje',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Retroalimentación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Aporte total al curso',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: notasItems[0].gradeitems.map<DataRow>((item) {
                              return DataRow(
                                selected: true,
                                cells: <DataCell>[
                                  DataCell(
                                    (item.itemname != null)
                                        ? Text(item.itemname.toString())
                                        : const Text('Total Curso'),
                                  ),
                                  DataCell(
                                    (item.weightformatted != null)
                                        ? Text(item.weightformatted.toString())
                                        : const Text('-'),
                                  ),
                                  DataCell(
                                    (item.graderaw != null)
                                        ? Text(item.graderaw.toString())
                                        : const Text('-'),
                                  ),
                                  DataCell(Text(
                                    //poner grademin y grademax
                                    '${item.grademin} - ${item.grademax}',
                                  )),
                                  DataCell(Text(
                                      item.percentageformatted.toString())),
                                  DataCell(
                                    SingleChildScrollView(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Html(
                                          data: item.feedback.toString(),
                                          style: {
                                            'body': Style(
                                                fontSize: const FontSize(14),
                                                //justificar todo el texto
                                                textAlign: TextAlign.justify),
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(
                                      item.percentageformatted.toString())),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ));
  }
}

Widget loaderCardListNotas() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        itemCount: 8,
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
                  Icons.assessment,
                  color: Colors.grey,
                ),
                title: Container(
                  width: 100,
                  height: 20,
                  color: Colors.grey,
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
