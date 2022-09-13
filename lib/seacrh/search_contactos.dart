import 'package:flutter/material.dart';

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
    // ignore: todo
    // TODO: implement buildResults
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // ignore: todo
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.person_rounded,
          color: Colors.black38,
          size: 130,
        ),
      );
    }
    return Container();
  }
}
