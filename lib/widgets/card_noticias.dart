import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardNoticias extends StatelessWidget {
  const CardNoticias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: size.width * 0.45,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, int index) {
              return const _Noticias();
            },
          ),
        ),
      ]),
    );
  }
}

class _Noticias extends StatelessWidget {
  const _Noticias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //variable para saber el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.98,
      height: size.height,
      // color: Color.fromARGB(255, 91, 219, 17),
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                // CachedNetworkImage(
                //   imageUrl:
                //       'https://www.uniamazonia.edu.co/inicio/images/banners/2022/megabanner%20elecciones%202021-01.jpg',
                //   fit: BoxFit.cover,
                // ),
                Image.asset(
              'images/noticia.jpg',
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
