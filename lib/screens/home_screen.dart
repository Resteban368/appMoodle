// ignore_for_file: use_build_context_synchronously

import 'package:campus_virtual/screens/screens.dart';
import 'package:campus_virtual/services/sevices.dart';
import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/socket_service.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    iniciarFucniones();
    super.initState();
  }

  void iniciarFucniones() async {
    
    final sockets = Provider.of<SocketService>(context, listen: false);
    sockets.connect();

    final token = Provider.of<GeneralService>(context, listen: false);
    await token.ObtenerToken();
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    await siteInfo.getInfoSite();

    final notificacionesProvider =
        Provider.of<NotificacionesService>(context, listen: false);
    await notificacionesProvider.getNotificaciones(siteInfo.infoSite.userid!);

    await notificacionesProvider
        .getCountNotificaciones(siteInfo.infoSite.userid!);

    final userInfo = Provider.of<UserInfoProvider>(context, listen: false);
    await userInfo.geInfoUser(siteInfo.infoSite.username!);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getData(siteInfo.infoSite.userid!);

    final cursoInfo = Provider.of<CursoService>(context, listen: false);
    await cursoInfo.getInfoCurso(siteInfo.infoSite.userid!);
  }

  final int _pageIndex = 0;
  // ignore: prefer_final_fields
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final NoticiasScreen _noticias = const NoticiasScreen();
  final ChatScreen _chat = const ChatScreen();
  final CursosScreen _cursos = const CursosScreen();
  // final NotificacionesScreen _notificaciones = const NotificacionesScreen();
  final AccountScreen _perfil = const AccountScreen();

  Widget _showPage = const NoticiasScreen();

  Widget? _seleccionarPagiona(int page) {
    switch (page) {
      case 0:
        return _noticias;
      case 1:
        return _chat;
      case 2:
        return _cursos;
      case 3:
        return _perfil;
      // case 4:
      //   return _notificaciones;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _pageIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.chat, size: 30, color: Colors.white),
          Icon(Icons.folder, size: 30, color: Colors.white),
          // Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: AppTheme.primary,
        buttonBackgroundColor: AppTheme.primary, //color de iconos activados
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _seleccionarPagiona(tappedIndex)!;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.white,
        child: _showPage,
      ),
    );
  }
}
