import 'dart:convert';
import 'dart:io';

import 'package:campus_virtual/models/user_update.dart';
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
    final url = 'http://192.168.1.6:8000/api/user/$id';
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

  Future<String?> updateUser(int id, UserUpdate userUpdate) async {
    // Map data = {
    //   'json': '{"email":"$email","phone1":"$phone1"}',
    // };

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final response = await http.put(
        Uri.parse("http://192.168.1.6:8000/api/user/$id"),
        body: userUpdate.toJson(),
        headers: headers);
    if (response.statusCode < 400) {
      // userInfo = decodata.user!;]
      // userInfoController(decodata.us]er!);
      print("Usuario actualizado");
    } else {
      print("Error al actualizar usuario");
      print(response.statusCode);
    }
    // var request =
    //     http.Request('PUT', Uri.parse('http://192.168.1.6:8000/api/user/$id'));
    // request.bodyFields = {
    //   'json': '{"email":"$email","phone1":"$phone1"}',
    // };
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
    notifyListeners();
    return '';
  }
}
