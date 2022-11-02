// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _FondoBox(),
        //contenedor para poner el widget del icono de login
        const _HeaderIcon(),
        //agregarmos el contenerdor del child
        child,
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(top: 50),
        child: //imagen de asset
            Image.asset(
          'images/appicon.png',
        ),
      ),
    );
  }
}

class _FondoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      //vamos agregarle un gradiente
      decoration: _FondoBackground(),
      child: Stack(children: const [
        Center(
          child: Text("Campus Virtual",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ]),
    );
  }

  BoxDecoration _FondoBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 37, 188, 183),
            Color.fromARGB(255, 57, 221, 216),
          ],
        ),
      );
}
