import 'package:flutter/material.dart';

class AppTheme {
  //colores primarios tema light
  static const Color primary = Color.fromARGB(255, 37, 188, 183);

  static const Color secondary = Color.fromARGB(195, 227, 225, 225);
  static const Color notificacionesLeidas = Color.fromARGB(214, 131, 245, 241);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: Colors.indigo,

    // AppBar Theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // AppBar Theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
    // scaffoldBackgroundColor: Color.fromARGB(178, 0, 0, 0),

    // Text Theme
    // textTheme: const TextTheme(
    //   headline1: TextStyle(color: Colors.white),
    //   headline2: TextStyle(color: Colors.white),
    //   headline3: TextStyle(color: Colors.white),
    //   headline4: TextStyle(color: Colors.white),
    //   headline5: TextStyle(color: Colors.white),
    //   headline6: TextStyle(color: Colors.white),
    //   bodyText1: TextStyle(color: Colors.white),
    //   bodyText2: TextStyle(color: Colors.white),
    //   subtitle1: TextStyle(color: Colors.white),
    //   subtitle2: TextStyle(color: Colors.white),
    //   caption: TextStyle(color: Colors.white),
    //   button: TextStyle(color: Colors.white),
    //   overline: TextStyle(color: Colors.white),
    // ),

    //card theme
  );
}
