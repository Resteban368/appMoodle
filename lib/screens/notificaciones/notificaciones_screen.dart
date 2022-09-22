import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/info_site_providers.dart';
import '../../services/foroDiscussion_service.dart';
import '../../services/notificaciones_service.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({Key? key}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  Widget build(BuildContext context) {
    final siteInfo = Provider.of<SiteProvider>(context, listen: false);
    final notificacion =
        Provider.of<NotificacionesService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: notificacion.getNotificaciones(siteInfo.infoSite.userid!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final notificaciones = snapshot.data;
            return ListView.builder(
              itemCount: notificaciones.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(notificaciones[index].subject),
                  subtitle: Text(notificaciones[index].id.toString()),
                );
              },
            );
          } else {
            return Center(
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
