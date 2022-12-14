// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CursosScreen extends StatefulWidget {
  const CursosScreen({Key? key}) : super(key: key);

  @override
  State<CursosScreen> createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
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
    final cursoInfo = Provider.of<CursoService>(context, listen: false);
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
          future: cursoInfo.getInfoCurso(userid2),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: loaderCardList(),
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
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ElasticInDown(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.primary),
                                  borderRadius: BorderRadius.circular(10),
                                  //sombra
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MateriasScreen(
                                                            snapshot.data[i])));
                                      },
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.book,
                                          color: AppTheme.primary,
                                          size: 40,
                                        ),
                                        title: Text(snapshot.data[i].fullname,
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        subtitle: Text(snapshot.data[i].name,
                                            style:
                                                const TextStyle(fontSize: 15)),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppTheme.primary,
                                        ),
                                      ),
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

  Widget loaderCardList() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      period: const Duration(seconds: 2),
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
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
                        color: Colors.grey,
                        size: 40,
                      ),
                      subtitle: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.grey,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     color: Colors.grey,
                    //     width: double.infinity,
                    //     height: 200,
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
