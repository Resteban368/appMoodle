// ignore_for_file: must_be_immutable

import 'package:campus_virtual/models/models.dart';
import 'package:campus_virtual/screens/chat/ver-pdf-a-exportar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../services/sevices.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';

class ChatUserScreen2 extends StatefulWidget {
  ResponseContacto contacto;
  ChatUserScreen2(this.contacto, {Key? key}) : super(key: key);
  @override
  State<ChatUserScreen2> createState() => _ChatUserScreenState2();
}

class _ChatUserScreenState2 extends State<ChatUserScreen2>
    with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  bool activo = false;
  late int userid2 = 0;
  late String fullname2 = '';
  late int conversationid;

  @override
  void initState() {
    super.initState();
    funcion();
  }

  Future<int> funcion() async {
    const storage = FlutterSecureStorage();
    final id = await storage.read(key: 'id');
    final fullname = await storage.read(key: 'fullname');
    final userid = int.parse(id!);
    fullname2 = fullname!;
    userid2 = userid;

    setState(() {});
    return userid;
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatListService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: AppTheme.primary,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 5),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage(
                      placeholder: const AssetImage('images/userDefault.png'),
                      image: NetworkImage(widget.contacto.profileimageurl!),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(width: 10),
                Text(widget.contacto.fullname!,
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
              ])),
      body: Column(
        children: [
          if (activo == false)
            Flexible(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.83,
              ),
            )
          else
            Flexible(
                child: FutureBuilder(
                    future: chatService.getMessages(conversationid, userid2),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Lottie.network(
                              'https://assets2.lottiefiles.com/packages/lf20_poqmycwy.json'),
                        );
                      } else {
                        final mensajes = snapshot.data;
                        //agregamos la lista de mensajes con snapshot.data
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: mensajes?.messages.length ?? 0,
                          itemBuilder: (_, int i) {
                            // _messages.insert(0, mensajes.messages[i]!);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  if (mensajes.messages[i].useridfrom !=
                                      userid2)
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      //colocar borderRadius al container
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppTheme.primary),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  mensajes.members[0]
                                                      .profileimageurl!),
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var item = 0;
                                                    item <
                                                        mensajes.members.length;
                                                    item++)
                                                  if (mensajes
                                                          .members[item].id ==
                                                      mensajes.messages[i]
                                                          .useridfrom)
                                                    Text(
                                                      mensajes.members[item]
                                                          .fullname!,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              AppTheme.primary),
                                                    ),
                                              ],
                                            ),
                                            subtitle: Html(
                                              data: mensajes.messages[i].text!,
                                              style: {
                                                "html": Style(
                                                  fontSize:
                                                      const FontSize(14.0),
                                                ),
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Text(
                                                getData(mensajes
                                                    .messages[i].timecreated),
                                                style: const TextStyle(
                                                    fontSize: 9)),
                                          )
                                        ],
                                      ),
                                    )
                                  else
                                    Container(
                                      //todos los bordes menos el inferior
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      //colocar borderRadius al container
                                      decoration: const BoxDecoration(
                                        color: AppTheme.primary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        // ignore: prefer_const_literals_to_create_immutables
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            subtitle: Html(
                                              data: mensajes.messages[i].text!,
                                              style: {
                                                "html": Style(
                                                  fontSize:
                                                      const FontSize(14.0),
                                                ),
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Text(
                                                getData(mensajes
                                                    .messages[i].timecreated),
                                                style: const TextStyle(
                                                    fontSize: 9)),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                          reverse: true,
                        );
                      }
                    })),
          const Divider(height: 1),
          //Todo: Caja de texto
          SizedBox(
            height: 50,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            //expandir la caja
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              // onChanged: (String texto) {
              //   setState(() {
              //     if (_textController.text.trim().isNotEmpty) {
              //       _estaEscribiendo = true;
              //     } else {
              //       _estaEscribiendo = false;
              //     }
              //   });
              // },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            ),
          ),
          //Boton de enviar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconTheme(
                data: const IconThemeData(color: AppTheme.primary),
                child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (activo == false) {
                        _handleSubmitNew(_textController.text);
                        // setState(() {
                        //   activo = false;
                        // });
                      } else {
                        _handleSubmit(_textController.text);
                        setState(() {
                          activo = true;
                        });
                        //   print('verde');
                      }
                    }
                    // : null,
                    ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) async {
    if (texto.isEmpty) return;
    final chatService = Provider.of<ChatListService>(context, listen: false);
    await chatService.addMessage(conversationid, _textController.text);
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  _handleSubmitNew(String texto) async {
    if (texto.isEmpty) return;
    final chatService = Provider.of<ChatListService>(context, listen: false);
    final chat = await chatService.addNewMessage(
        widget.contacto.id!, _textController.text, userid2);
    _textController.clear();
    _focusNode.requestFocus();
    conversationid = chat![0].conversationid!;
    setState(() {
      _estaEscribiendo = false;
      activo = true;
    });
  }
}
