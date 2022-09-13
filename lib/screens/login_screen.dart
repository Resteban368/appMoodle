// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../providers/user_providers.dart';
import '../services/sevices.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
              child: Column(
        children: [
          const SizedBox(height: 300),
          CardContainer(
              child: Column(children: [
            const SizedBox(height: 10),
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: const _loginForm(),
            ),
          ])),
          const SizedBox(height: 30),
        ],
      ))),
    );
  }
}

// ignore: camel_case_types
class _loginForm extends StatelessWidget {
  const _loginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passController = TextEditingController();
    final usernameController = TextEditingController();
    final formProvider = Provider.of<LoginFormProvider>(context);
    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            controller: usernameController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'es.rodriguez',
                labelText: 'Usuario Chaira',
                prefixIcon: Icons.email),
            onChanged: (value) => formProvider.username = value,
            //validacon para el campo email
            validator: (value) {
              String pattern = r'';
              // ignore: unnecessary_new
              RegExp regExp = new RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Invalid email';
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock),
            onChanged: (value) => formProvider.password = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Invalida la contraseña minimo 4 caracteres';
            },
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 37, 188, 183),
              // ignore: sort_child_properties_last
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(formProvider.isloading ? 'Iniciando...' : 'Iniciar',
                    style: const TextStyle(color: Colors.white)),
              ),
              onPressed: formProvider.isloading
                  ? null
                  : () async {
                      //quitar al hacer clik el teclado
                      FocusScope.of(context).unfocus();
                      //todo tener acceso a mi AuthService
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      //validar el formulario
                      if (!formProvider.isValidForm()) return;
                      formProvider.isloading = true;
                      //todo: validar si el login es correcto
                      final String? error = await authService.login(
                          formProvider.username, formProvider.password);
                      if (error == null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        final siteInfo =
                            Provider.of<SiteProvider>(context, listen: false);
                        await siteInfo.getInfoSite();
                        await prefs.setString(
                            'username', siteInfo.infoSite.username!);
                        await prefs.setInt('userid', siteInfo.infoSite.userid!);

                        print(siteInfo.infoSite.username);

                        final userInfo = Provider.of<UserInfoProvider>(context,
                            listen: false);
                        await userInfo.geInfoUser(siteInfo.infoSite.username!);

                        final cursoInfo =
                            Provider.of<CursoProvider>(context, listen: false);
                        await cursoInfo.getInfoCurso(siteInfo.infoSite.userid!);

                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        await userProvider.getData(siteInfo.infoSite.userid!);

                        final token = Provider.of<GeneralProvider>(context,
                            listen: false);
                        await token.ObtenerToken();
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        //todo MOSTRAR ERROR EN PANTALLA
                        NotificationsService.showSnackbar(error);
                        formProvider.isloading = false;
                      }
                      //vamos a esperar un tiempo
                      // Future.delayed(const Duration(seconds: 2), () {a
                    }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
