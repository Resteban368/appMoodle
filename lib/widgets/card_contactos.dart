import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CardContactos extends StatelessWidget {
  const CardContactos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Contactos favoritos',
              style: TextStyle(fontSize: 15, color: AppTheme.primary)),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (_, int index) {
              return const _Contactos();
            },
          ),
        ),
      ]),
    );
  }
}

class _Contactos extends StatelessWidget {
  const _Contactos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      // color: Color.fromARGB(255, 91, 219, 17),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: const FadeInImage(
                placeholder: AssetImage('images/acount.png'),
                image: AssetImage('images/acount.png'),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'esteban rpdriguez marles',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
