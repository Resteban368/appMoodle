// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class BannerService with ChangeNotifier {
  //construcctor
  BannerService() {
    getBanner();
  }

  Future<List<Result>?> getBanner() async {
    try {
      const url = 'http://172.16.23.187:3000/api/banner/all';
      // print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<Result> banner = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          banner.add(Result.fromMap(element));
        }
        notifyListeners();
        return banner;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }
}
