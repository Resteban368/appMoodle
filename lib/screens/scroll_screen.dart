import 'package:campus_virtual/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
          page1(),
          const LoginScreen(),
        ]));
  }
}

// ignore: camel_case_types, use_key_in_widget_constructors
class page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InicioBackground(
      child: Stack(
        children: const [
          TextoInicio(),
        ],
      ),
    ));
  }
}

class TextoInicio extends StatelessWidget {
  const TextoInicio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _HeaderIcon(),
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Direccion de Eduacion a Distancia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center),
          ),
          Expanded(child: Container()),
          //todo arrow
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 100),
        ],
      ),
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
        height: 240,
        margin: const EdgeInsets.only(top: 200),
        child: Image.asset(
          'images/udla_icon_blanco.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

//todo perzonalizacion del fondo

class InicioBackground extends StatelessWidget {
  final Widget child;

  const InicioBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _FondoBox(),
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
      decoration: _FondoBackground(),
    );
  }

  // ignore: non_constant_identifier_names
  BoxDecoration _FondoBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 37, 188, 183),
            Color.fromARGB(255, 57, 221, 216),
          ],
        ),
      );
}
