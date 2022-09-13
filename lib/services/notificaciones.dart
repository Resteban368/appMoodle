// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class NotificationsService {
  //meotodos y propiedades staticas

  //propiedades estaticas
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  //metodos estaticos
  //vamos a mostrar un mensaje de error en la pantalla
  static showSnackbar(String message) {
    final snackBar = new SnackBar(
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
    //llamamos al metodo de la propiedad statica messengerKey
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
