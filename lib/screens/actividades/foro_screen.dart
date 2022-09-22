import 'package:campus_virtual/models/cursoId.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/foroDiscussion_service.dart';

class ForoScreen extends StatefulWidget {
  Module contenido;
  ForoScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<ForoScreen> createState() => _ForoScreenState();
}

class _ForoScreenState extends State<ForoScreen> {
  void iniciarFucniones() async {
    final foroDiscussion =
        Provider.of<ForoDiscussionService>(context, listen: false);
    await foroDiscussion.getForo(widget.contenido.instance!);
  }

  @override
  void initState() {
    iniciarFucniones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foroDiscussion =
        Provider.of<ForoDiscussionService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('foro'),
      ),
      body: FutureBuilder(
        future: foroDiscussion.getForo(widget.contenido.instance!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(posts[index].subject),
                  subtitle: Text(posts[index].message),
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
