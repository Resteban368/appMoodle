// To parse this JSON data, do
//
//     final responseCategories = responseCategoriesFromJson(jsonString);

import 'dart:convert';

ResponseCategories responseCategoriesFromMap(String str) =>
    ResponseCategories.fromMap(json.decode(str));

String responseCategoriesToMap(ResponseCategories data) =>
    json.encode(data.toMap());

class ResponseCategories {
  ResponseCategories({
    required this.category,
  });

  List<Category> category;

  factory ResponseCategories.fromMap(Map<String, dynamic> json) =>
      ResponseCategories(
        category: List<Category>.from(
            json["results"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(category.map((x) => x.toMap())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.idnumber,
    this.description,
    this.descriptionformat,
    this.parent,
    this.sortorder,
    this.coursecount,
    this.visible,
    this.visibleold,
    this.timemodified,
    this.depth,
    this.path,
    this.theme,
  });

  int? id;
  String? name;
  String? idnumber;
  String? description;
  int? descriptionformat;
  int? parent;
  int? sortorder;
  int? coursecount;
  int? visible;
  int? visibleold;
  int? timemodified;
  int? depth;
  String? path;
  dynamic theme;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        idnumber: json["idnumber"],
        description: json["description"],
        descriptionformat: json["descriptionformat"],
        parent: json["parent"],
        sortorder: json["sortorder"],
        coursecount: json["coursecount"],
        visible: json["visible"],
        visibleold: json["visibleold"],
        timemodified: json["timemodified"],
        depth: json["depth"],
        path: json["path"],
        theme: json["theme"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "idnumber": idnumber,
        "description": description,
        "descriptionformat": descriptionformat,
        "parent": parent,
        "sortorder": sortorder,
        "coursecount": coursecount,
        "visible": visible,
        "visibleold": visibleold,
        "timemodified": timemodified,
        "depth": depth,
        "path": path,
        "theme": theme,
      };
}
