// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/sevices.dart';
import '../theme/theme.dart';

class CardNoticias extends StatelessWidget {
  const CardNoticias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    final bannerService = Provider.of<BannerService>(context, listen: false);
    // print(bannerService.getBanner().length);

    return SizedBox(
      width: double.infinity,
      height: size.width * 0.45,
      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
              future: bannerService.getBanner(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final banner = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: loaderNoticias(),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Container(
                            width: size.width * 0.9,
                            height: size.width * 0.45,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: banner[index].src,
                                placeholder: (context, url) => Image.asset(
                                  'images/noticia.jpg',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (banner[index].url == null) {
                              return;
                            } else {
                              await launch(banner[index].url);
                            }
                          },
                        );
                      });
                }
              }),
        ),
      ]),
    );
  }
}

Widget loaderNoticias() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    period: const Duration(seconds: 2),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            width: 350,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 70,
                color: Colors.white,
              ),
            ),
          );
        }),
  );
}
