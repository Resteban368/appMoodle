// To parse this JSON data, do
//
//     final responseCategory = responseCategoryFromMap(jsonString);

import 'dart:convert';

class ResponseCategory {
  ResponseCategory({
    this.ok,
    this.results,
  });

  bool? ok;
  List<ResultCategory>? results;

  factory ResponseCategory.fromJson(String str) =>
      ResponseCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseCategory.fromMap(Map<String, dynamic> json) =>
      ResponseCategory(
        ok: json["ok"],
        results: List<ResultCategory>.from(
            json["results"].map((x) => ResultCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class ResultCategory {
  ResultCategory({
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

  factory ResultCategory.fromJson(String str) =>
      ResultCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCategory.fromMap(Map<String, dynamic> json) => ResultCategory(
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
