import 'package:flutter/material.dart';

import '../../theme/app_bar_theme.dart';
import '../../widgets/widgets.dart';

class NuevoGrupoScreen extends StatelessWidget {
  const NuevoGrupoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Grupo'),
        backgroundColor: AppTheme.primary,
        actions: [
          NamedIcon(
            iconData: Icons.notifications,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
