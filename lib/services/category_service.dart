import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class CategoryService with ChangeNotifier {
  //construcctor
  CategoryService() {
    getCategoryById(2);
  }

  Future<List<Category>?> getCategoryById(int id) async {
    print('getCtaegoryById');

    try {
      final url = 'http://172.16.23.187:3000/api/course/Category/$id';
      // print(Uri.parse(url));
      // print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode < 400) {
        List<Category> category = [];
        Map<String, dynamic> mapaRespBody = json.decode(response.body);
        for (var element in mapaRespBody['results']) {
          category.add(Category.fromMap(element));
        }
        notifyListeners();
        print(category);
        return category;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }
}
