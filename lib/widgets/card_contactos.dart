// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/chat/chat_user_screen.dart';
import '../screens/chat/chat_user_screen_clean.dart';
import '../seacrh/search_contactos.dart';
import '../services/sevices.dart';
import '../theme/theme.dart';

class CardContactos extends StatefulWidget {
  const CardContactos({Key? key}) : super(key: key);

  @override
  State<CardContactos> createState() => _CardContactosState();
}

class _CardContactosState extends State<CardContactos> {
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
    final contactosService =
        Provider.of<ContactosService>(context, listen: false);
    // final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.14,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 5),
          child: Text('Mis Contactos',
              style: TextStyle(fontSize: 15, color: AppTheme.primary)),
        ),
        Expanded(
          child: FutureBuilder(
            future: contactosService.getContactos(userid2),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final contacto = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: loaderCardList(),
                );
              } else {
                //guardamos todos los contactos en una lista
                // final contactos = contacto['contactos'];

                if (contacto!.length == null || contacto!.length == 0) {
                  return Center(
                    child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            //tamano de la tarjeta

                            elevation: 3,
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
                      //guardamos todos los contactos en una lista

                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Stack(children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
//todo: verificar nuevo proceso para optimizar
                                    final chatService =
                                        Provider.of<ChatListService>(context,
                                            listen: false);
                                    final chat =
                                        await chatService.getChatList(userid2);
                                    for (var i = 0; i < chat!.length; i++) {
                                      if (contacto[index].id ==
                                          chat[i].members![0].id) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    ChatUserScreen(chat[i])));
                                        //terminar el for
                                        break;
                                      } else {
                                        //terminar el for
                                        if (i == chat.length - 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ChatNuevo()));
                                        }
                                      }
                                    }
                                  },

                                  // print('chat length');
                                  // print(chat!.length);
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
                          Positioned(
                            top: 0,
                            right: 22,
                            child: (contacto[index].isonline == false)
                                ? Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  )
                                : Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                          ),
                        ]),
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

Widget loaderCardList() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: ClipRRect(
              //color del borde de la imagen
              borderRadius: BorderRadius.circular(50),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 50,
                    height: 10,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        }),
  );
}
