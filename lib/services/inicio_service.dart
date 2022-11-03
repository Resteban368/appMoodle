// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InicioService extends ChangeNotifier {
  //varaibles para la peticion de la informacion del usuario
  final storage = const FlutterSecureStorage();
  //construcctor
  InicioService() {
    readUserId();
    readUserName();
    readFullName();
  }

  Future<String> readUserId() async {
    Map<String, dynamic> ids;
    final userId = await storage.read(key: 'id') ?? '';
    if (userId == '') {
      return '';
    }
    ids = {'id': userId};
    print('Leyendo el id: $userId');
    return ids['id'];
  }

  //funcion para leer el nombre del usuario
  Future<String> readUserName() async {
    Map<String, dynamic> names;
    final userName = await storage.read(key: 'username') ?? '';
    if (userName == '') {
      return '';
    }
    names = {'username': userName};
    print('Leyendo el Username: $userName');
    return names['username'];
  }

  //funcion para leer el nombre del usuario
  Future<String> readFullName() async {
    Map<String, dynamic> names;
    final fullName = await storage.read(key: 'fullname') ?? '';
    if (fullName == '') {
      return '';
    }
    names = {'fullname': fullName};
    print('Leyendo el Fullname: $fullName');
    return names['fullname'];
  }
}
