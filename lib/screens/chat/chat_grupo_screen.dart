import 'package:animate_do/animate_do.dart';
import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ChatGrupo extends StatelessWidget {
  const ChatGrupo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
        backgroundColor: AppTheme.primary,
        actions: [
          NamedIcon(
            iconData: Icons.notifications,
            notificationCount: 2,
            onTap: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: const [
            SizedBox(height: 15),
            NuevoGrupo(),
            SizedBox(height: 15),
            _ContenedorListChat(),
          ],
        ),
      ),
    );
  }
}

class NuevoGrupo extends StatelessWidget {
  const NuevoGrupo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 50,
          height: 50,
          color: AppTheme.primary,
          child: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
        ),
      ),
      title: const Text('Nuevo Grupo',
          style: TextStyle(color: AppTheme.primary, fontSize: 15)),
      onTap: () {
        Navigator.pushNamed(context, 'Nuevo_grupo');
      },
    );
  }
}

class _ContenedorListChat extends StatelessWidget {
  const _ContenedorListChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.62,
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int i) {
                  return ElasticInDown(
                    child: Card(
                      child: ListTile(
                        leading: Hero(
                          tag: 'grupo',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: const FadeInImage(
                              placeholder: AssetImage('images/grupo.jpeg'),
                              image: AssetImage('images/grupo.jpeg'),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: const Text('Grupo de Tareas',
                            style: TextStyle(color: AppTheme.primary)),
                        subtitle: const Text('Hola a todos'),
                        trailing: const Text('8:45'),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
