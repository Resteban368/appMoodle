import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_models.dart';

class UserProvider with ChangeNotifier {
  File? newImage;

  late UserClass userInfo = UserClass();
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerLastname = TextEditingController();
  final TextEditingController controllerFirstname = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerDepartment = TextEditingController();
  final TextEditingController controllerCity = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();

  final TextEditingController controllerPhone1 = TextEditingController();

  late bool habilitarForm = false;

  Future<String?> getData(int id) async {
    final url = 'http://172.16.22.20:8000/api/user/$id';
    print(url);
    final response = await http.get(Uri.parse(url));
    final User decodata = User.fromJson(json.decode(response.body));
    userInfo = decodata.user!;
    userInfoController(decodata.user!);
    notifyListeners();
    return '';
  }

  userInfoController(UserClass userInfoController) {
    controllerId.text = userInfoController.id!.toString();
    controllerFirstname.text = userInfoController.firstname!;
    controllerLastname.text = userInfoController.lastname!;
    controllerEmail.text = userInfoController.email!;
    controllerDepartment.text = userInfoController.department!;
    controllerCity.text = userInfoController.city!.toString();
    controllerAddress.text = userInfoController.address!.toString();
    controllerPhone1.text = userInfoController.phone1!;
  }

  habilitarFormulario() {
    // print(habilitarForm);
    habilitarForm = !habilitarForm;
    notifyListeners();
  }

  void updateSelectedImage(String path) {
    this.newImage = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> updateUser(int id) async {
    final response = await http
        .post(Uri.parse("http://172.16.22.20:8000/api/user/$id"), body: {
      "email": controllerEmail.text,
      "department": controllerDepartment.text,
      "city": controllerCity.text,
      "address": controllerAddress.text,
      "phone1": controllerPhone1.text
    });
    final User decodata = User.fromJson(json.decode(response.body));
    if (response.statusCode < 400) {
      userInfo = decodata.user!;
      userInfoController(decodata.user!);
      print("Usuario actualizado");
    } else {
      print("Error al actualizar usuario");
    }
    notifyListeners();
  }
}
