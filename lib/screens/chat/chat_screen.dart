import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../seacrh/search_contactos.dart';
import '../../services/sevices.dart';
import '../screens.dart';
import '/theme/app_bar_theme.dart';

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
      body: Scaffold(
        body: ChatBackground(
          child: SingleChildScrollView(
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
                                        const _SolicitudesScreen()));
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
                const _ContenedorBotones(),
                const SizedBox(height: 10),
                const _ContenedorListChat(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SolicitudesScreen extends StatelessWidget {
  const _SolicitudesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactosService =
        Provider.of<ContactosService>(context, listen: false);
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Solicitudes'),
        backgroundColor: AppTheme.primary,
      ),
      body: FutureBuilder(
          future: contactosService.getSolicitudes(siteInfo.infoSite.userid!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final solicitudes = snapshot.data;
            if (solicitudes.length == 0) {
              return Center(
                  child: Container(
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
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await contactosService
                      .getSolicitudes(siteInfo.infoSite.userid!);
                },
                child: ListView.builder(
                    itemCount: solicitudes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ElasticInDown(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    solicitudes[index].profileimageurl),
                              ),
                              title: Text(solicitudes[index].fullname!),
                              subtitle: const Text('Quiere contactar contigo'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        // await contactosService
                                        //     .aceptarSolicitud(solicitudes[index].id!);
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const ChatScreen()));
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        // await contactosService
                                        //     .rechazarSolicitud(solicitudes[index].id!);
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const ChatScreen()));
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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

class _ContenedorListChat extends StatelessWidget {
  const _ContenedorListChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.62,
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int i) {
                  return ElasticInDown(
                    child: Stack(
                      children: [
                        Card(
                          child: ListTile(
                            leading: Hero(
                              tag: 'erm',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: const FadeInImage(
                                  placeholder: AssetImage('images/acount.png'),
                                  image: AssetImage('images/acount.png'),
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: const Text('Esteban Rodriguez',
                                style: TextStyle(color: AppTheme.primary)),
                            subtitle: const Text('Hola como estas?'),
                            trailing: const Text('2:45'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ChatUserScreen()));
                            },
                          ),
                        ),
                        //onlie
                        Positioned(
                          top: 9,
                          right: MediaQuery.of(context).size.width * 0.8,
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
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
              onPressed: () {
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
