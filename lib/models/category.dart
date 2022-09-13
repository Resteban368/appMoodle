// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    this.code,
    this.status,
    this.categories,
  });

  int? code;
  String? status;
  List<CategoryElement>? categories;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: json["code"],
        status: json["status"],
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class CategoryElement {
  CategoryElement({
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

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
        idnumber: json["idnumber"] == null ? null : json["idnumber"],
        description: json["description"] == null ? null : json["description"],
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "idnumber": idnumber == null ? null : idnumber,
        "description": description == null ? null : description,
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
