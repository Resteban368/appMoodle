// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class CategoryService with ChangeNotifier {
  //construcctor

  Future<List<ResultCategory>?> getCategoryById(int id) async {
    final url = 'http://172.16.23.187:3000/api/category/Category/$id';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 400) {
        List<ResultCategory> category = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          category.add(ResultCategory.fromMap(element));
        }
        notifyListeners();
        print(category[0].description);
        return category;
      }
    } catch (e) {
      print('error en el service de categorias: $e');
    }
    notifyListeners();
    return null;
  }
}
