// ignore_for_file: camel_case_types, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:campus_virtual/screens/screens.dart';
import 'package:campus_virtual/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../services/sevices.dart';
import '../../theme/app_bar_theme.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool colorEye = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final userInfoProvider2 = Provider.of<UserInfoProvider>(context);
    final userInfoProvider = Provider.of<UserProvider>(context);

    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);
    String imgeDefault =
        'https://st1.uvnimg.com/d4/4a/006304a74db4902c0b4d8d8026c8/chevrolet-corvette-c8-stingray-2020-1280-08.jpg';

    late bool habilitarForm = userInfoProvider.habilitarForm;

    print(userInfoProvider2.userInfo.profileimageurl!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppTheme.primary,
        //para cerrar sesion
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: AppTheme.primary),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Cerrar sesión'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.settings, color: AppTheme.primary),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Configuración'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                authService.logout();
                //navegar a la pantalla de login
                Navigator.pushReplacementNamed(context, 'inicio');
              } else if (value == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfiguracionScreen()));
              }
            },
          )
        ],
      ),
      //todo container donde esta todo
      body: Container(
        width: double.infinity,
        height: size.height * 0.8,
        padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Container(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: (_imageFile != null)
                                  ? Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      userInfoProvider2
                                                  .userInfo.profileimageurl !=
                                              null
                                          ? userInfoProvider2
                                              .userInfo.profileimageurl!
                                          : imgeDefault,
                                      // imgeDefault,

                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: AppTheme.primary),
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => BottomSheetImage());
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BuildTextFiled(
                labelText: "Nombre",
                placeholder: "",
                controller: userInfoProvider.controllerFirstname,
                isRead: false,
              ),
              BuildTextFiled(
                labelText: "Apellidos",
                placeholder: '',
                controller: userInfoProvider.controllerLastname,
                isRead: false,
              ),
              BuildTextFiled(
                labelText: "Correo Institucional",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: false,
              ),
              BuildTextFiled(
                labelText: "Correo Personal",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Departamento",
                placeholder: '',
                controller: userInfoProvider.controllerDepartment,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Ciudad",
                placeholder: '',
                controller: userInfoProvider.controllerCity,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Direccion",
                placeholder: '',
                controller: userInfoProvider.controllerAddress,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Cuenta de Skype",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Cuenta de Facebook",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Cuenta de Twitter",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Cuenta de Youtube",
                placeholder: '',
                controller: userInfoProvider.controllerYahoo,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Cuenta de Instagram",
                placeholder: '',
                controller: userInfoProvider.controllerEmail,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Telfono",
                placeholder: "",
                controller: userInfoProvider.controllerPhone1,
                isRead: habilitarForm,
              ),
              const SizedBox(height: 5),
              const Text('EN CASO DE EMERGENCIA CONTACTO',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 30),
              BuildTextFiled(
                labelText: "Nombre Completo",
                placeholder: "",
                controller: userInfoProvider.controllerFirstname,
                isRead: habilitarForm,
              ),
              BuildTextFiled(
                labelText: "Telfono Celular",
                placeholder: '',
                controller: userInfoProvider.controllerPhone2,
                isRead: habilitarForm,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'ACEPTAR TERMINOS Y CONDICIONES',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary),
                    ),
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith((states) =>
                        states.contains(MaterialState.selected)
                            ? AppTheme.primary
                            : Colors.grey),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ],
              ),
              const Text(
                  "El diligenciamiento de mi información personal será requerida para explorar el campus virtual. La información suministrada se encuentra amparada mediante la Ley de Protección de Datos Personales (L. 1581 de Octubre 17 de 2012)",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: isChecked == false
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 235, 99, 90),
                                  content: Text(
                                      'Debe aceptar los terminos y condiciones'),
                                ),
                              );
                            }
                          : () async {
                              final siteInfo = Provider.of<InfoSiteService>(
                                  context,
                                  listen: false);
                              final peticion =
                                  await userInfoProvider.updateUser(
                                      siteInfo.infoSite.userid!,
                                      userInfoProvider.controllerEmail.text,
                                      userInfoProvider.controllerPhone1.text);
                              if (peticion == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 32, 99, 35),
                                    content: Text(
                                        'Se actualizo la información correctamente'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 235, 99, 90),
                                    content: Text(
                                        'No se pudo actualizar la información'),
                                  ),
                                );
                              }
                            },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Guardar",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        userInfoProvider.habilitarFormulario();
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Editar ",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ))
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "En este formato hay campos obligatorios",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget BottomSheetImage() {
    return Container(
      color: AppTheme.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Cambiar Foto',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text('Camara',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                    onPressed: () {
                      takePhoto(ImageSource.camera);
                    },
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Row(
                children: [
                  const Text('Galeria',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.photo,
                      size: 30,
                    ),
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FotoPerfil extends StatelessWidget {
  final String urlimagen;
  const FotoPerfil({
    Key? key,
    required this.urlimagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.white),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1)),
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(urlimagen).image,
          )),
    );
  }
}

class BuildTextFiled extends StatelessWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController controller;
  final bool? isRead;
  const BuildTextFiled(
      {Key? key,
      required this.labelText,
      required this.placeholder,
      required this.controller,
      this.isRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          enabled: isRead,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.primary, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ));
  }
}
