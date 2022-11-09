// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/utils/utils.dart';
import 'package:campus_virtual/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../seacrh/search_contactos.dart';
import '../../services/sevices.dart';
import '../screens.dart';
import '/theme/app_bar_theme.dart';
import 'package:flutter_html/flutter_html.dart';

class ChatScreen extends StatelessWidget {
  void fucniones() async {}
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //para ver el tamaño de la pantalla
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: [
                  const _BarraBuscar(),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SolicitudesScreen()));
                      },
                      icon: const Icon(
                        Icons.inbox_outlined,
                        size: 40,
                        color: AppTheme.primary,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const CardContactos(),
            const SizedBox(height: 10),
            // const _ContenedorBotones(),
            const SizedBox(height: 10),
            const _ContenedorListChat(),
          ],
        ),
      ),
    );
  }
}

class SolicitudesScreen extends StatefulWidget {
  const SolicitudesScreen({Key? key}) : super(key: key);

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
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
    final chatSolicitud =
        Provider.of<ChatSolicitudService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        backgroundColor: AppTheme.primary,
      ),
      body: FutureBuilder(
          future: contactosService.getSolicitudes(userid2),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return loaderSolicitudesList();
            }
            final solicitudes = snapshot.data;
            if (solicitudes.length == 0) {
              return Center(
                  child: SizedBox(
                width: double.infinity,
                height: 200,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.group,
                      size: 100,
                      color: AppTheme.primary,
                    ),
                    Text(
                      'No hay solicitudes',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await contactosService.getSolicitudes(userid2);
                  setState(
                    () {},
                  );
                },
                child: ElasticInDown(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: solicitudes.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        elevation: 3,
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor:
                                    const Color.fromARGB(255, 65, 63, 63),
                                flex: 2,
                                onPressed: (_) async {
                                  await chatSolicitud.acepetarSolicitud(
                                      solicitudes[index].id!, userid2);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 32, 99, 35),
                                      content: Text(
                                          'Solicitud aceptada correctamente'),
                                    ),
                                  );
                                  await contactosService
                                      .getSolicitudes(userid2);
                                  setState(
                                    () {},
                                  );
                                },
                                foregroundColor: AppTheme.primary,
                                icon: Icons.check,
                                label: 'Aceptar',
                              ),
                              SlidableAction(
                                backgroundColor:
                                    const Color.fromARGB(255, 65, 63, 63),
                                flex: 2,
                                onPressed: (_) async {
                                  await chatSolicitud.rechazarSolicitud(
                                      solicitudes[index].id!, userid2);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 235, 99, 90),
                                      content: Text(
                                          'Solicitud rechazada correctamente'),
                                    ),
                                  );
                                  await contactosService
                                      .getSolicitudes(userid2);
                                  setState(
                                    () {},
                                  );
                                },
                                foregroundColor: AppTheme.primary,
                                icon: Icons.close,
                                label: 'Rechazar',
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    solicitudes[index].profileimageurl),
                              ),
                              title: Text(solicitudes[index].fullname!),
                              subtitle: const Text('Quiere contactar contigo'),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        height: size.height * 0.8,
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}

class _ContenedorListChat extends StatefulWidget {
  const _ContenedorListChat({Key? key}) : super(key: key);

  @override
  State<_ContenedorListChat> createState() => _ContenedorListChatState();
}

class _ContenedorListChatState extends State<_ContenedorListChat> {
  late int userid2 = 0;
  late int click = 0;
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
    final chatService = Provider.of<ChatListService>(context, listen: false);

    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.62,
        child: FutureBuilder(
          future: chatService.getChatList(userid2),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: loaderCardList(),
              );
            } else {
              final chatList = snapshot.data;
              return ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int i) {
                  return ElasticInDown(
                    child: Stack(children: [
                      GestureDetector(
                        //que al precionsar solo una vez se abra el chat y si se preciona dos veces que no haga nada
                        onTap: () async {
                          click++;
                          if (click == 1) {
                            await chatService.conversacionLeida(
                                userid2, chatList[i].id);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChatUserScreen(chatList[i])));
                          } else {
                            click = 0;
                          }
                        },

                        child: Card(
                          child: Stack(children: [
                            ListTile(
                              leading: Hero(
                                tag: chatList[i].id,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'images/userDefault.png'),
                                      image:

                                          // (chatList[i].imageurl == null ||
                                          //         chatList[i].imageurl.isEmpty)

                                          //     ?
                                          NetworkImage(chatList[i]
                                              .members[0]
                                              .profileimageurl)
                                      // : NetworkImage(
                                      //     '${chatList[i].imageurl}'),

                                      ,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              title: (chatList[i].name.isEmpty)
                                  ? Text(chatList[i].members[0].fullname!,
                                      style: const TextStyle(
                                          color: AppTheme.primary))
                                  : Text(chatList[i].name!,
                                      style: const TextStyle(
                                          color: AppTheme.primary)),
                              subtitle: Column(
                                children: [
                                  if (chatList[i].messages.length > 0)
                                    Html(
                                      data: chatList[i].messages[0].text!,
                                      style: {
                                        "html": Style(
                                          fontSize: const FontSize(14.0),
                                        ),
                                      },
                                    )
                                  else
                                    const Text(''),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (chatList[i].messages.length > 0)
                                    Column(
                                      children: [
                                        Text(
                                            getFecha(chatList[i]
                                                .messages[0]
                                                .timecreated),
                                            style:
                                                const TextStyle(fontSize: 9)),
                                        Text(
                                            getHora(chatList[i]
                                                .messages[0]
                                                .timecreated),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                      ],
                                    )
                                  else
                                    const Text(''),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: (chatList.length > 0)
                                  ? (chatList[i].isread == false)
                                      ? Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        )
                                      : const Text('')
                                  : const Text(''),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: MediaQuery.of(context).size.width * 0.82,
                        child: (chatList[i].messages.length > 0)
                            ? (chatList[i].members[0].isonline == true)
                                ? Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  )
                                : Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  )
                            : const Text(''),
                      ),
                    ]),
                  );
                },
              );
            }
          },
        ));
  }
}

class _BarraBuscar extends StatelessWidget {
  const _BarraBuscar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: ContactosDeBusqueda());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Buscar Contactos',
                    style: TextStyle(color: AppTheme.primary, fontSize: 15)),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppTheme.primary,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: ContactosDeBusqueda());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContenedorBotones extends StatelessWidget {
  const _ContenedorBotones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.04,
      child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: ElevatedButton(
              onPressed: () async {
                //ruta a la pantalle de crear grupo
                Navigator.pushNamed(context, 'grupos');
              },
              // ignore: sort_child_properties_last
              child: const Text(
                "Grupos",
                style: TextStyle(
                    fontSize: 15, letterSpacing: 2, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppTheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ))),
    );
  }
}

Widget loaderCardList() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        itemCount: 10,
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
                  Icons.person,
                  color: Colors.grey,
                  size: 50,
                ),
                title: Container(
                  width: 100,
                  height: 20,
                  color: Colors.red,
                ),
                subtitle: Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
                trailing: const Icon(
                  Icons.timelapse,
                  color: AppTheme.primary,
                  size: 25,
                ),
              ),
            ),
          );
        }),
  );
}

Widget loaderSolicitudesList() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        itemCount: 5,
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
                  Icons.person,
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
