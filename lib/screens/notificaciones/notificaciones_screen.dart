import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/sevices.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({Key? key}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  @override
  Widget build(BuildContext context) {
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    final notificacion =
        Provider.of<NotificacionesService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            onPressed: () async {
              await notificacion
                  .marcarNotificaciones(siteInfo.infoSite.userid!);
            },
            icon: const Icon(
              Icons.check_circle_outline,
              size: 27,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: notificacion.getNotificaciones(siteInfo.infoSite.userid!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final notificaciones = snapshot.data;
            return ListView.builder(
              itemCount: notificaciones.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  color: notificaciones[index].read == true
                      ? Colors.white
                      : AppTheme.notificacionesLeidas,
                  child: ListTile(
                    leading: Column(children: [
                      if (notificaciones[index].eventtype ==
                          'messagecontactrequests')
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                if (notificaciones[index].read == false)
                                  const Icon(Icons.lightbulb,
                                      size: 30, color: Colors.white)
                                else if (notificaciones[index].read == true)
                                  const Icon(Icons.lightbulb,
                                      size: 30, color: AppTheme.primary)
                              ],
                            ),
                          ],
                        )
                      else if (notificaciones[index].eventtype ==
                          'assign_notification')
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                if (notificaciones[index].read == false)
                                  const Icon(Icons.task,
                                      size: 30, color: Colors.white)
                                else if (notificaciones[index].read == true)
                                  const Icon(Icons.task,
                                      size: 30, color: AppTheme.primary)
                              ],
                            ),
                          ],
                        )
                    ]),
                    title: Text(
                      notificaciones[index].subject,
                      style: const TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(notificaciones[index].timecreatedpretty),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppTheme.primary,
                      size: 25,
                    ),
                    onTap: () async {
                      // Navigator.pushNamed(context, 'notificacion',
                      //     arguments: notificaciones[index]);
                      await notificacion
                          .getCountNotificaciones(siteInfo.infoSite.userid!);
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}



























// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

// import '../../models/category.dart';

// class NotificacionesScreen extends StatefulWidget {
//   const NotificacionesScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificacionesScreen> createState() => _NotificacionesScreenState();
// }

// class _NotificacionesScreenState extends State<NotificacionesScreen> {
//   late Category cate = Category();

//   Future<List<dynamic>> getData() async {
//     final response =
//         await http.get(Uri.parse("http://192.168.1.6:8000/api/category"));
//     final Category decodata = Category.fromJson(json.decode(response.body));
//     cate = decodata;
//     return decodata.categories!;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder<List>(
//       future: getData(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, i) {
//                   return ListTile(
//                     title: Text(snapshot.data![i].name.toString()),
//                     leading: const Icon(Icons.widgets), //Icon(Icons.widgets),
//                   );
//                 }),
//           );
//         }
//       },
//     ));
//   }
// }
