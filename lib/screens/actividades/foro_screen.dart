// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/models/cursoId.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../services/debate_service.dart';
import '../../services/foroDiscussion_service.dart';
import '../../theme/app_bar_theme.dart';
import 'dart:math' as math;

class ForoScreen extends StatefulWidget {
  Module contenido;
  ForoScreen(this.contenido, {Key? key}) : super(key: key);

  @override
  State<ForoScreen> createState() => _ForoScreenState();
}

class _ForoScreenState extends State<ForoScreen> {
  void iniciarFucniones() async {
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
    final debate = Provider.of<DebateService>(context, listen: false);
    late bool habilitarForm = debate.habilitarForm;
    bool _isButtonDisabled = !habilitarForm;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: Text(widget.contenido.name!),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1.0,
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: //inputs para agregar un nuevo debate
                          Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              debate.habilitarFormulario();
                              setState(
                                () {},
                              );
                            },
                            child: const Text('Agregar un nuevo debate'),
                            //color al boton
                            style: ElevatedButton.styleFrom(
                              primary: habilitarForm
                                  ? AppTheme.primary
                                  : Colors.grey,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            color: Colors.white,
                            child: TextField(
                              enabled: habilitarForm,
                              controller: debate.controllerSubject,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Asunto',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //textArea para agregar el mensaje
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: TextField(
                              enabled: habilitarForm,
                              controller: debate.controllerMessage,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mensaje',
                                //color a los bordes
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: _isButtonDisabled
                                      ? null
                                      : () async {
                                          final foroDiscussion =
                                              Provider.of<DebateService>(
                                                  context,
                                                  listen: false);
                                          final peticion =
                                              await foroDiscussion.addDebate(
                                                  widget.contenido.instance!,
                                                  debate.controllerSubject.text,
                                                  debate
                                                      .controllerMessage.text);
                                          if (peticion == '') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 32, 99, 35),
                                                content: Text(
                                                    'Se agrego un debate correctamente'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 235, 99, 90),
                                                content: Text(
                                                    'No se pudo agregar el debate'),
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.primary,
                                  ),
                                  child: const Text('Enviar al foro')),
                              ElevatedButton(
                                onPressed: _isButtonDisabled
                                    ? null
                                    : () {
                                        debate.controllerMessage.clear();
                                        debate.controllerSubject.clear();
                                        debate.habilitarFormulario();
                                        setState(
                                          () {},
                                        );
                                      },
                                child: const Text('Cancelar'),
                                //color al boton
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[400],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                    child: Text('Debate',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppTheme.primary,
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: FutureBuilder(
                      future: debate.getDebates(widget.contenido.instance!),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final debates = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: debates.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.grey[200],
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    debates[index].name,
                                    style: const TextStyle(
                                        color: AppTheme.primary, fontSize: 20),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Comenzado por:'),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                          Image.network(
                                            debates[index].userpictureurl,
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(debates[index].userfullname),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Último mensaje:'),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                          Image.network(
                                            debates[index]
                                                .usermodifiedpictureurl,
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(debates[index]
                                              .usermodifiedfullname),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Réplicas:'),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(debates[index]
                                              .numreplies
                                              .toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                _ContenidoDebates(
                                                    debates[index].discussion,
                                                    debates[index].name)));
                                    // print(debates[index].discussion);
                                  },
                                ),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContenidoDebates extends StatelessWidget {
  // final CursoContenidoProvider cursoIContenido;
  int discussionid;
  String name;
  _ContenidoDebates(this.discussionid, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foroDiscussion =
        Provider.of<ForoDiscussionService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: foroDiscussion.getForo(discussionid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final post = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: post!.length,
                itemBuilder: (BuildContext context, int i) {
                  final htmlData = post[i].message;
                  final htmlDataFecha = post[i].html.authorsubheading;
                  return ElasticInDown(
                    child:

                        //creamos una card para poner los debates
                        Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            color: Colors.grey[200],
                            child: ListTile(
                              leading: Image.network(
                                post[i].author.urls.profileimage!,
                                width: 50,
                              ),
                              title: Text(post[i].subject!,
                                  style: const TextStyle(fontSize: 18)),
                              subtitle: Html(
                                data: htmlDataFecha,
                                style: {
                                  'body': Style(
                                      fontSize: const FontSize(14),
                                      color: const Color(0xFF000000),
                                      //justificar todo el texto
                                      textAlign: TextAlign.justify),
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: Colors.white,
                            height: 100,
                            child: SingleChildScrollView(
                              child: Html(
                                data: htmlData,
                                style: {
                                  'body': Style(
                                      fontSize: const FontSize(15),
                                      color: const Color(0xFF000000),
                                      //justificar todo el texto
                                      textAlign: TextAlign.justify),
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              //color
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.primary,
                              ),
                              onPressed: () {
                                print('respondiendo');
                              },
                              child: const Text('Responder'),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
