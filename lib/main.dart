import 'package:campus_virtual/providers/providers.dart';
import 'package:campus_virtual/services/socket_service.dart';
import 'package:campus_virtual/share_preferences/share_preferences.dart';
import 'package:campus_virtual/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/sevices.dart';

import 'package:intl/date_symbol_data_local.dart';

final internetChecker = CheckInternetConnection();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  initializeDateFormatting('es', null);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode)),
        ChangeNotifierProvider(
          create: (_) => GeneralService(),
        ),
        ChangeNotifierProvider(
          create: (_) => InfoSiteService(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatListService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CursoService(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CursoContenidoService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ForoDiscussionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificacionesService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DebateService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactosService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatSolicitudService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TareaService(),
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
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
