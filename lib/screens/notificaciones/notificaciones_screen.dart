import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../providers/user_providers.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({Key? key}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  late Category cate = Category();

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.6:8000/api/category"));
    final Category decodata = Category.fromJson(json.decode(response.body));
    cate = decodata;
    return decodata.categories!;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data![i].name.toString()),
                    leading: const Icon(Icons.widgets), //Icon(Icons.widgets),
                  );
                }),
          );
        }
      },
    ));
  }
}
