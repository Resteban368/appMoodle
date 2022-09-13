import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            const SizedBox(height: 10),
            miCardImageCarga(),
          ]);
        });
  }
}

Card miCardImageCarga() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        FadeInImage(
          image: Image.asset('images/noticia.jpg').image,
          placeholder: const AssetImage('images/udla_icon_blanco.png'),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Titulo de la noticia'),
        ),
      ],
    ),
  );
}
