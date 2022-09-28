// ignore_for_file: avoid_print

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
  final TextEditingController controllerPhone2 = TextEditingController();
  final TextEditingController controllerYahoo = TextEditingController();
  final TextEditingController controllerMsm = TextEditingController();

  late bool habilitarForm = false;

  Future<String?> getData(int id) async {
    try {
      final url = 'http://10.0.2.2:8000/api/user/$id';
      print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));
      final User decodata = User.fromJson(json.decode(response.body));
      userInfo = decodata.user!;
      userInfoController(decodata.user!);
      notifyListeners();
      return '';
    } catch (e) {
      print(e);
    }
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
    controllerPhone2.text = userInfoController.phone2!;
    controllerYahoo.text = userInfoController.yahoo!;
    controllerMsm.text = userInfoController.msn!;
  }

  habilitarFormulario() {
    // print(habilitarForm);
    habilitarForm = !habilitarForm;
    notifyListeners();
  }

  void updateSelectedImage(String path) {
    newImage = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> updateUser(int id, String email, String phone1) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var request =
        http.Request('PUT', Uri.parse('http://10.0.2.2:8000/api/user/$id'));
    request.bodyFields = {
      'json': '{"email":"$email","phone1":"$phone1"}',
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 400) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
    return '';
  }
}
