import 'package:campus_virtual/models/cursoId.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/debate_service.dart';
import '../../services/foroDiscussion_service.dart';
import '../../theme/app_bar_theme.dart';

class ForoScreen extends StatefulWidget {
  Module contenido;
  ForoScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<ForoScreen> createState() => _ForoScreenState();
}

class _ForoScreenState extends State<ForoScreen> {
  void iniciarFucniones() async {
    // final foroDiscussion =
    //     Provider.of<ForoDiscussionService>(context, listen: false);
    // await foroDiscussion.getForo(widget.contenido.instance!);
    final debate = Provider.of<DebateService>(context, listen: false);
    await debate.getDebates(widget.contenido.instance!);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text('Foro'),
      ),
      body: FutureBuilder(
        future: foroDiscussion.getForo(widget.contenido.instance!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final debates = snapshot.data;
            return ListView.builder(
              itemCount: debates.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(debates[index].name),
                  subtitle: Text(debates[index].numreplies.toString()),
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
