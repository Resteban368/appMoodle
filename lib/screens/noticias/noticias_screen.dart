// ignore_for_file: deprecated_member_use

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:campus_virtual/utils/warning_widget_change_notifier.dart';
import 'package:campus_virtual/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_bar_theme.dart';
import '../screens.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedFloatingActionButtonState> key =
        GlobalKey<AnimatedFloatingActionButtonState>();
    //tamaño de la pantalla
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: AppTheme.primary,
        actions: [
          NamedIcon(
            iconData: Icons.notifications,
            onTap: () {
              //enviar al screen de notificaciones
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificacionesScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              WarningWidgetChangeNotifier(),
              SizedBox(height: 10),
              // CardNoticias(),
              SizedBox(height: 20),
              Text(
                'OFERTA ACADÉMICA',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Programas de formación a nivel de pregrado y tecnologías',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 10),
              _OfertaAcademica(),
              SizedBox(height: 10),
              Text(
                'NUESTRA MISIÓN',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                  '"Hacer presencia en la Amazonia Colombiana brindando programas a distancia con apoyo virtual"',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _CardMision(),
              SizedBox(height: 10),
              _Informacion(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),

      //boton flotante con varias opciones
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedFloatingActionButton(
            fabButtons: <Widget>[float1(), float2()],
            key: key,
            colorStartAnimation: AppTheme.primary,
            colorEndAnimation: Colors.grey,
            animatedIconData: AnimatedIcons.menu_close //To principal button
            ),
      ),
    );
  }
}

Widget float1() {
  return FloatingActionButton(
    backgroundColor: AppTheme.primary,
    onPressed: null,
    heroTag: "btn1",
    tooltip: 'Preguntas Frecuentes',
    child: IconButton(
      icon: const Icon(Icons.book),
      onPressed: () async {
        await launch(
            'https://distancia.uniamazonia.edu.co/distancia/Recursos/PreguntasFrecuentes/');
      },
    ),
  );
}

Widget float2() {
  return FloatingActionButton(
    backgroundColor: AppTheme.primary,
    onPressed: null,
    heroTag: "btn2",
    tooltip: 'Datos de Interes',
    child: IconButton(
      icon: const Icon(Icons.question_mark_outlined),
      onPressed: () async {
        await launch(
            'https://distancia.uniamazonia.edu.co/distancia/Recursos/distancia/');
      },
    ),
  );
}

class _OfertaAcademica extends StatelessWidget {
  const _OfertaAcademica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 100,
                    // color: Colors.indigo,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await launch(
                                'https://distancia.uniamazonia.edu.co/distancia/login/index.php/');
                          },
                          icon: const Icon(Icons.book),
                          color: AppTheme.primary,
                          iconSize: 30,
                        ),
                        const Text("Guías Didácticas - Docentes",
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.primary)),
                        const SizedBox(height: 5),
                        const Text(
                          "Envío de Guías Didácticas.",
                          style: TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await launch(
                                'https://distancia.uniamazonia.edu.co/distancia/');
                          },
                          icon: const Icon(Icons.health_and_safety_outlined),
                          color: AppTheme.primary,
                          iconSize: 30,
                        ),
                        const Text("Bienestar Universitario",
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.primary)),
                        const SizedBox(height: 5),
                        const Text(
                          "Acceda a servicios médicos, lúdicos y recreativos que el campus virtual le ofrece.",
                          style: TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            ]), //Row 1/2

            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await launch(
                                'https://distancia.uniamazonia.edu.co/rrm/#/');
                          },
                          icon: const Icon(Icons.insert_drive_file_outlined),
                          color: AppTheme.primary,
                          iconSize: 30,
                        ),
                        const Text("Recursos Educativos Digitales",
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.primary)),
                        const SizedBox(height: 5),
                        const Text(
                          "Repositorio de Recursos Educativos Digitales",
                          style: TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await launch(
                                'https://distancia.uniamazonia.edu.co/distancia/login/index.php');
                          },
                          icon: const Icon(Icons.calendar_month),
                          color: AppTheme.primary,
                          iconSize: 30,
                        ),
                        const Text("Induccion Virtual",
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.primary)),
                        const SizedBox(height: 5),
                        const Text(
                          "Aprende cómo se estudia a distancia.",
                          style: TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            ]), //Row 2/2
            // Text Bottom
          ],
        ),
      ),
    );
  }
}

class _CardMision extends StatelessWidget {
  const _CardMision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    final List<String> images = [
      'images/Encuentros.png',
      'images/guias.png',
      'images/Calendario.png',
      'images/Acuerdo.png',
    ];

    //lista de links
    final List<String> links = [
      'https://distancia.uniamazonia.edu.co/distancia/login/index.php',
      'https://distancia.uniamazonia.edu.co/distancia/login/index.php',
      'https://distancia.uniamazonia.edu.co/distancia/Noticias/CalendarioAcademico//',
      'https://distancia.uniamazonia.edu.co/distancia/Recursos/Calendario/',
    ];
    return SizedBox(
      width: double.infinity,
      height: size.width * 0.5,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (_, int index) {
              return GestureDetector(
                child: Container(
                  width: size.width * 0.85,
                  height: size.height,
                  // color: Color.fromARGB(255, 91, 219, 17),
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () async {
                  await launch(links[index]);
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _Informacion extends StatelessWidget {
  const _Informacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              height: 80,
              child: Column(children: [
                IconButton(
                  onPressed: () async {
                    await launch(
                        'https://www.google.com/maps/place/Florencia,+Caquet%C3%A1/@1.618869,-75.603842,14z/data=!3m1!4b1!4m5!3m4!1s0x8e244e1a71ba142f:0x408dc3d21376d444!8m2!3d1.6153858!4d-75.6042364');
                  },
                  icon: const Icon(Icons.location_on_outlined,
                      color: AppTheme.primary),
                  color: AppTheme.primary,
                  iconSize: 30,
                ),
                const Text(
                  'Florencia, Caquetá',
                  style: TextStyle(fontSize: 12),
                )
              ]),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 80,
            child: Column(children: [
              IconButton(
                onPressed: () async {
                  await launch('mailto:edistancia@uniamazonia.edu.co');
                },
                icon: const Icon(Icons.email, color: AppTheme.primary),
                color: AppTheme.primary,
                iconSize: 30,
              ),
              const Text(
                'edistancia@uniamazonia.edu.co',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.28,
            height: 80,
            child: Column(children: [
              IconButton(
                onPressed: () async {
                  await launch('tel:+57 3214687286');
                },
                icon: const Icon(Icons.phone, color: AppTheme.primary),
                color: AppTheme.primary,
                iconSize: 30,
              ),
              const Text(
                '+57 3214687286',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
