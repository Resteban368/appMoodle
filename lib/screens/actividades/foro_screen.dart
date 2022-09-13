import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ForoScreen extends StatelessWidget {
  const ForoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foros'),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Foros'),
      ),
    );
  }
}
