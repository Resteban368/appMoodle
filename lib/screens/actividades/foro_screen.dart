// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/models/cursoId.dart';
import 'package:campus_virtual/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../services/debate_service.dart';
import '../../services/foroDiscussion_service.dart';
import '../../theme/app_bar_theme.dart';

class ForoScreen extends StatefulWidget {
  //global key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                          Form(
                        key: widget._formKey,
                        child: Column(
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value != null && value.length >= 2) {
                                    return null;
                                  }
                                  return 'Asunto incorrecto minimo 2 caracteres';
                                },
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
                              height: 5,
                            ),
                            //textArea para agregar el mensaje
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: TextFormField(
                                validator: (value) {
                                  if (value != null && value.length >= 2) {
                                    return null;
                                  }
                                  return 'Mensaje incorrecto minimo 2 caracteres';
                                },
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
                                MaterialButton(
                                    onPressed: _isButtonDisabled
                                        ? null
                                        : () async {
                                            if (widget._formKey.currentState!
                                                .validate()) {
                                              final foroDiscussion =
                                                  Provider.of<DebateService>(
                                                      context,
                                                      listen: false);
                                              final peticion =
                                                  await foroDiscussion
                                                      .addDebate(
                                                          widget.contenido
                                                              .instance!,
                                                          debate
                                                              .controllerSubject
                                                              .text,
                                                          debate
                                                              .controllerMessage
                                                              .text);
                                              if (peticion == '') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 32, 99, 35),
                                                    content: Text(
                                                        'Se agrego un debate correctamente'),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 235, 99, 90),
                                                    content: Text(
                                                        'No se pudo agregar el debate'),
                                                  ),
                                                );
                                              }
                                              //BORRAR EL CONTROLADOR
                                              debate.controllerSubject.clear();
                                              debate.controllerMessage.clear();
                                              //CERRAR EL TECLADO
                                              FocusScope.of(context).unfocus();
                                              await debate.getDebates(
                                                  widget.contenido.instance!);
                                            }
                                          },
                                    color: AppTheme.primary,
                                    textColor: Colors.white,
                                    child: const Text('Enviar al foro')),
                                MaterialButton(
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
                                  color: Colors.grey,
                                  textColor: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
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
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: FutureBuilder(
                      future: debate.getDebates(widget.contenido.instance!),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        final debates = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data.length == 0) {
                            return SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  children: const [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Icon(
                                      Icons.question_answer,
                                      color: AppTheme.primary,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'No hay debates',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await debate
                                    .getDebates(widget.contenido.instance!);
                                setState(() {});
                              },
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: debates.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(
                                          debates[index].name,
                                          style: const TextStyle(
                                              color: AppTheme.primary,
                                              fontSize: 20),
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
                                                Text(debates[index]
                                                    .userfullname),
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          _ContenidoDebates(
                                                              debates[index]
                                                                  .discussion,
                                                              debates[index]
                                                                  .name)));
                                          // print(debates[index].discussion);
                                        },
                                      ),
                                    );
                                  }),
                            );
                          }
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

class _ContenidoDebates extends StatefulWidget {
  // final CursoContenidoProvider cursoIContenido;
  int discussionid;
  String name;
  _ContenidoDebates(this.discussionid, this.name, {Key? key}) : super(key: key);

  @override
  State<_ContenidoDebates> createState() => _ContenidoDebatesState();
}

class _ContenidoDebatesState extends State<_ContenidoDebates> {
//global key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final foroDiscussion =
        Provider.of<ForoDiscussionService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: foroDiscussion.getForo(widget.discussionid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final post = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await foroDiscussion.getForo(widget.discussionid);
                  setState(() {});
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: post!.length,
                  itemBuilder: (BuildContext context, int i) {
                    final htmlData = post[i].message;
                    final htmlDataFecha = post[i].html.authorsubheading;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElasticInDown(
                        child:

                            //creamos una card para poner los debates
                            Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 80,
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
                                          //justificar todo el texto
                                          textAlign: TextAlign.justify),
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: SingleChildScrollView(
                                  child: Html(
                                    data: htmlData,
                                    style: {
                                      'body': Style(
                                          fontSize: const FontSize(15),
                                          //justificar todo el texto
                                          textAlign: TextAlign.justify),
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  //color
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.primary,
                                  ),
                                  onPressed: () {
                                    //ventana emergente
                                    showDialog(
                                        context: context,
                                        //no cerrar la ventana emergente al dar click afuera
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                            },
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  title: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Responder a :',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primary),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        //ponerle borde al container
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey[200]!)
                                                          // border radius

                                                          ,
                                                        ),
                                                        height: 110,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Html(
                                                            data: htmlData,
                                                            style: {
                                                              'body': Style(
                                                                  fontSize:
                                                                      const FontSize(
                                                                          15),

                                                                  //justificar todo el texto
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify),
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  content: SizedBox(
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.18,
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                foroDiscussion
                                                                    .controllerMessage,
                                                            maxLines: 5,
                                                            validator: (value) {
                                                              if (value !=
                                                                      null &&
                                                                  value.length >=
                                                                      2) {
                                                                return null;
                                                              }
                                                              return 'Mensaje incorrecto minimo 2 caracteres';
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Escriba su respuesta...',
                                                              //color a los bordes
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppTheme
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    MaterialButton(
                                                        //color de texto
                                                        textColor: Colors.white,
                                                        color: AppTheme.primary,
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            final peticion =
                                                                await foroDiscussion.addPost(
                                                                    post[i].id!,
                                                                    post[i]
                                                                        .subject!,
                                                                    foroDiscussion
                                                                        .controllerMessage
                                                                        .text);
                                                            await foroDiscussion
                                                                .getForo(widget
                                                                    .discussionid);
                                                            if (peticion ==
                                                                '') {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          32,
                                                                          99,
                                                                          35),
                                                                  content: Text(
                                                                      'Se agrego la respuesta correctamente'),
                                                                ),
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              //LIMPIAR LOS CONTROLADORES
                                                              foroDiscussion
                                                                  .controllerMessage
                                                                  .clear();
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          235,
                                                                          99,
                                                                          90),
                                                                  content: Text(
                                                                      'No se pudo agregar su respuesta'),
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            null;
                                                          }
//LLAMAR NUEVAMENTE LA API
                                                        },
                                                        child: const Text(
                                                            'Enviar al foro')),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.grey,
                                                        ),
                                                        onPressed: () {
                                                          foroDiscussion
                                                              .controllerMessage
                                                              .clear();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Cancelar')),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text('Responder'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
