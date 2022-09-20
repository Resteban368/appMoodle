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
    return Scaffold(
      appBar: AppBar(
        title: Text('foro'),
      ),
      body: Center(
        child: Text('ForoScreen'),
      ),
    );
  }
}
