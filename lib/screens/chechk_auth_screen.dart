import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/sevices.dart';
import 'screens.dart';

class ChekeoAuthScreen extends StatelessWidget {
  const ChekeoAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.isLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ScrollScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const BottomNavBar(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
