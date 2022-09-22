import 'package:campus_virtual/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class TareaScreen extends StatelessWidget {
  Module contenido;
  TareaScreen(this.contenido, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarea'),
          backgroundColor: AppTheme.primary,
          actions: [
            NamedIcon(
              iconData: Icons.notifications,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificacionesScreen()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              _ContainerBanner(contenido),
              const SizedBox(height: 5),
              const _ContainerInformacionTarea(),
            ],
          ),
        ));
  }
}

class _ContainerBanner extends StatelessWidget {
  Module contenido;
  _ContainerBanner(
    this.contenido, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
        elevation: 3,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              contenido.name!,
              style: const TextStyle(fontSize: 20, color: AppTheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
            child: Row(
              children: [
                Text(
                  contenido.dates![0].label!,
                  style: const TextStyle(color: AppTheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(getData(contenido.dates![0].timestamp!)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 5.0, top: 8.0),
            child: Row(
              children: [
                Text(
                  contenido.dates![1].label!,
                  style: const TextStyle(color: AppTheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Text(getData(contenido.dates![1].timestamp!)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _ContainerInformacionTarea extends StatelessWidget {
  const _ContainerInformacionTarea({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Estado de la entrega',
                style: TextStyle(fontSize: 22, color: AppTheme.primary),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 2.0),
                    child: Text('Estado de la entrega: ',
                        style: TextStyle(color: AppTheme.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No entregado'),
                    )),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 2.0),
                    child: Text('Estado de la calificación: ',
                        style: TextStyle(color: AppTheme.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No calificada'),
                    )),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 2.0),
                    child: Text('Tiempo restante: ',
                        style: TextStyle(color: AppTheme.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child:
                          Text('La Tarea está retrasada por: 29 días 20 horas'),
                    )),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 2.0),
                    child: Text('Última modificación: ',
                        style: TextStyle(color: AppTheme.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No calificada'),
                    )),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 2.0),
                    child: Text('Comentarios de la entrega: ',
                        style: TextStyle(color: AppTheme.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.grey[100],
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Comentarios (0)'),
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
