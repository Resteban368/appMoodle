import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ChatUserScreen extends StatelessWidget {
  const ChatUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Column(children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.22,
          color: AppTheme.primary,
          child: Stack(
            children: [
              Padding(
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
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Hero(
                          tag: 'erm',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: const FadeInImage(
                              placeholder: AssetImage('images/acount.png'),
                              image: AssetImage('images/acount.png'),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text('Esteban Rodriguez Marles',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.085,
                right: MediaQuery.of(context).size.width * 0.4,
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
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: const [
              _CajaMensajes(),
              BotonEnviar(),
            ],
          ),
        )
      ]),
    );
  }
}

class _CajaMensajes extends StatelessWidget {
  const _CajaMensajes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      //poner borderRadius al container
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
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
                labelStyle: const TextStyle(color: Colors.black38),
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
