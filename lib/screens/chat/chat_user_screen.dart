import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/sevices.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';

class ChatUserScreen extends StatelessWidget {
  Conversation chatList;
  ChatUserScreen(this.chatList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatListService>(context, listen: false);
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        //cerrar teclado
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.18,
              color: AppTheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                        textDirection: TextDirection.ltr,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Hero(
                          tag: chatList.id!,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('images/userDefault.png'),
                                image: NetworkImage(
                                    chatList.members![0].profileimageurl!),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(height: 5),
                        Text(chatList.members![0].fullname!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.82,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      //poner borderRadius al container
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: FutureBuilder(
                        future: chatService.getMessages(
                            chatList.id!, siteInfo.infoSite.userid!),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final mensajes = snapshot.data;
                            return ListView.builder(
                                itemCount: mensajes.messages.length,
                                itemBuilder: (BuildContext context, int i) =>
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          if (mensajes.messages[i].useridfrom ==
                                              mensajes.members![0].id)
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              //colocar borderRadius al container
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppTheme.primary),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(mensajes
                                                              .members[0]
                                                              .profileimageurl!),
                                                    ),
                                                    title: Text(
                                                      mensajes
                                                          .members[0].fullname!,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              AppTheme.primary),
                                                    ),
                                                    subtitle: Html(
                                                      data: mensajes
                                                          .messages[i].text!,
                                                      style: {
                                                        "html": Style(
                                                          fontSize:
                                                              const FontSize(
                                                                  14.0),
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, bottom: 5),
                                                    child: Text(
                                                        getData(mensajes
                                                            .messages[i]
                                                            .timecreated),
                                                        style: const TextStyle(
                                                            fontSize: 9)),
                                                  )
                                                ],
                                              ),
                                            )
                                          else
                                            Container(
                                              //todos los bordes menos el inferior
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              //colocar borderRadius al container
                                              decoration: const BoxDecoration(
                                                color: AppTheme.primary,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                                // ignore: prefer_const_literals_to_create_immutables
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    subtitle: Html(
                                                      data: mensajes
                                                          .messages[i].text!,
                                                      style: {
                                                        "html": Style(
                                                          fontSize:
                                                              const FontSize(
                                                                  14.0),
                                                        ),
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, bottom: 5),
                                                    child: Text(
                                                        getData(mensajes
                                                            .messages[i]
                                                            .timecreated),
                                                        style: const TextStyle(
                                                            fontSize: 9)),
                                                  )
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ));
                          }
                        },
                      ),
                    ),
                  ),
                  const BotonEnviar(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class BotonEnviar extends StatelessWidget {
  const BotonEnviar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Escribir',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send_outlined,
                color: AppTheme.primary,
              ))
        ],
      ),
    );
  }
}
