// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../services/sevices.dart';

class ContactosDeBusqueda extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Contacto';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // ignore: todo
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.search_off,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No hay resultados',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _emptyContainer() {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.search_off,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No hay resultados',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final contactosService =
        Provider.of<ContactosService>(context, listen: false);
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    return FutureBuilder(
        future: contactosService.searchContacto(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return _emptyContainer();
          }

          final contactos = snapshot.data;
          return GestureDetector(
            onTap: () {
              //cerrar el teclado
              FocusScope.of(context).unfocus();
            },
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElasticInDown(
                  child: ListView.builder(
                    itemCount: contactos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            //color del borde de la imagen

                            backgroundImage:
                                NetworkImage(contactos[index].profileimageurl),
                          ),
                          title: Text(contactos[index].fullname),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              //cambiar color del icono segun el estado
                            ),
                            onPressed: () async {
                              //cerrar el delete
                              const storage = FlutterSecureStorage();
                              final id = await storage.read(key: 'id');
                              final userid = int.parse(id!);

                              final peticion = await contactosService
                                  .addSolicitud(userid, contactos[index].id);
                              if (peticion == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        'Solicitud enviada a: ${contactos[index].fullname}'),
                                  ),
                                  //cerrar search delegate
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Error al enviar solicitud'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
