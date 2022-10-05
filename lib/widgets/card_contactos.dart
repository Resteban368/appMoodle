import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../seacrh/search_contactos.dart';
import '../services/sevices.dart';
import '../theme/theme.dart';

class CardContactos extends StatelessWidget {
  const CardContactos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactosService =
        Provider.of<ContactosService>(context, listen: false);
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    // ignore: sized_box_for_whitespace
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.13,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 5),
          child: Text('Mis Contactos',
              style: TextStyle(fontSize: 15, color: AppTheme.primary)),
        ),
        Expanded(
          child: FutureBuilder(
            future: contactosService.getContactos(siteInfo.infoSite.userid!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final contacto = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (contacto.length == null || contacto.length == 0) {
                  return Center(
                    child: Container(
                        width: double.infinity,
                        height: 90,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset('images/userDefault.png'),
                              ),
                              title: const Text('No hay contactos'),
                              subtitle: const Text('Agrega contactos'),
                              trailing: IconButton(
                                  onPressed: () {
                                    //enviar al buscador de contactos
                                    showSearch(
                                        context: context,
                                        delegate: ContactosDeBusqueda());
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: AppTheme.primary,
                                  )),
                            ),
                          ),
                        )),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacto!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: 100,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: ClipRRect(
                                  //color del borde de la imagen
                                  borderRadius: BorderRadius.circular(50),
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'images/userDefault.png'),
                                    image: NetworkImage(
                                        contacto[index].profileimageurl),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                contacto[index].fullname,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ]),
    );
  }
}

// class _Contactos extends StatelessWidget {
//   const _Contactos({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 150,
//       // color: Color.fromARGB(255, 91, 219, 17),
//       margin: const EdgeInsets.only(top: 10),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {},
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: const FadeInImage(
//                 placeholder: AssetImage('images/acount.png'),
//                 image: AssetImage('images/acount.png'),
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const Text(
//             'esteban rpdriguez marles',
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
