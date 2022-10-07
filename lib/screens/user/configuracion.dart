import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ThemeProvider.dart';
import '../../share_preferences/share_preferences.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({Key? key}) : super(key: key);

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuración'),
          backgroundColor: AppTheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                SwitchListTile.adaptive(
                    value: Preferences.isDarkmode,
                    title: const Text('Modo oscuro'),
                    onChanged: (value) {
                      Preferences.isDarkmode = value;
                      final themeProvider =
                          Provider.of<ThemeProvider>(context, listen: false);

                      value
                          ? themeProvider.setDarkmode()
                          : themeProvider.setLightMode();

                      setState(() {});
                    }),
                const Divider(),
                // RadioListTile<int>(
                //     value: 1,
                //     groupValue: Preferences.gender,
                //     title: const Text('Masculino'),
                //     onChanged: (value) {
                //       Preferences.gender = value ?? 1;
                //       setState(() {});
                //     }),
                // const Divider(),
                // RadioListTile<int>(
                //     value: 2,
                //     groupValue: Preferences.gender,
                //     title: const Text('Femenino'),
                //     onChanged: (value) {
                //       Preferences.gender = value ?? 2;
                //       setState(() {});
                //     }),
                // const Divider(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: TextFormField(
                //     initialValue: Preferences.name,
                //     onChanged: (value) {
                //       Preferences.name = value;
                //       setState(() {});
                //     },
                //     decoration: const InputDecoration(
                //         labelText: 'Nombre', helperText: 'Nombre del usuario'),
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
