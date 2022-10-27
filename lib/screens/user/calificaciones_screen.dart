// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/services/sevices.dart';
import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/notasCurso.dart';

class CalificacionesScreen extends StatelessWidget {
  const CalificacionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notasService = Provider.of<NotasService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calificaciones'),
        backgroundColor: AppTheme.primary,
      ),
      body: SizedBox(
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
                future: notasService.getNotas(3),
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
                                subtitle: Text(notas[i].grade.toString()),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppTheme.primary,
                                  size: 25,
                                ),
                              ),
                            ),
                            onTap: () {
                              //enviamos a la screen DetalleNotasCursoScreen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DetalleNotasCursoScreen(notas[i])));
                            },
                          ),
                        );
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class DetalleNotasCursoScreen extends StatelessWidget {
  DetalleNotasCursoScreen(this.idCurso, {Key? key}) : super(key: key);
  Notas idCurso;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(idCurso.courseid.toString()),
        backgroundColor: AppTheme.primary,
      ),
      body: Center(
        child: Text('DetalleNotasCursoScreen'),
      ),
    );
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
