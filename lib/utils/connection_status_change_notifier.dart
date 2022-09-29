import 'dart:async';

import 'package:campus_virtual/main.dart';
import 'package:campus_virtual/utils/check_internet_connection.dart';
import 'package:flutter/cupertino.dart';

class ConnectionStatusChangeNotifier extends ChangeNotifier {
  late StreamSubscription _connectionSubscription;

  ConnectionStatus status = ConnectionStatus.online;

  ConnectionStatusChangeNotifier() {
    _connectionSubscription =
        internetChecker.internetStatus().listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
