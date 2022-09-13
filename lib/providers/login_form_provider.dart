import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
