// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class BannerService with ChangeNotifier {
  List<ResponseBanner> banner = [];

  Future<String?> getBanner() async {
    print('getBanner');
    try {
      const url = 'http://192.168.1.1:3000/api/banner/all';
      // print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));
      print('erm${response.body}');
      final List decodata = json.decode(response.body);

      banner = decodata.map((e) => ResponseBanner.fromMap(e)).toList();
      notifyListeners();
      return '';
    } catch (e) {
      print(e);
    }
    return null;
  }
}
