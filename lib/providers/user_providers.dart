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

  Future<UserClass?> getData(int id) async {
    try {
      final url = 'http://172.16.23.187:3000/api/user/user/$id';
      print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<UserClass> infoUser = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          infoUser.add(UserClass.fromMap(element));
        }
        userInfo = infoUser[0];
        userInfoController(userInfo);
        print(userInfo);
        notifyListeners();
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
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
    // controllerYahoo.text = userInfoController.yahoo!;
    // controllerMsm.text = userInfoController.msn!;
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
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('http://172.16.23.187:3000/api/user/user/3'));
    request.body = json.encode({"email": email, "phone1": phone1});
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
