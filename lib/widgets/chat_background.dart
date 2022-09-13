// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

class ChatBackground extends StatelessWidget {
  final Widget child;

  const ChatBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _FondoBox(),
        //contenedor para poner el widget del icono de login
        //agregarmos el contenerdor del child
        child,
      ]),
    );
  }
}

class _FondoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      //vamos agregarle un gradiente
      decoration: _FondoBackground(),
    );
  }

  BoxDecoration _FondoBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
      );
}
