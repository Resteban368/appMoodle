import 'package:campus_virtual/providers/providers.dart';
import 'package:campus_virtual/services/foroDiscussion_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/notificaciones_service.dart';
import 'services/sevices.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('es', null);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GeneralProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (_) => SiteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CursoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CursoContenidoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ForoDiscussionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificacionesService(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Campus Virtual',
      initialRoute: 'check',
      routes: {
        //chekeo
        'check': (_) => const ChekeoAuthScreen(),
        //validaciones
        'login': (context) => const LoginScreen(),
        //pantallas app
        'home': (context) => const BottomNavBar(),
        'inicio': (context) => const ScrollScreen(),
        'grupos': (context) => const ChatGrupo(),
        'Nuevo_grupo': (context) => const NuevoGrupoScreen(),
        // 'materias': (context) =>  MateriasScreen(),
      },

      //no lo instancia en el constructor porque no se necesita, ya que es una propiedad de estatica
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
