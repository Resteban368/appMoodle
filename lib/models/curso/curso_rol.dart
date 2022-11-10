// To parse this JSON data, do
//
//     final rolUserCourse = rolUserCourseFromMap(jsonString);

import 'dart:convert';

class RolUserCourse {
  RolUserCourse({
    this.results,
  });

  List<ResultCursoId>? results;

  factory RolUserCourse.fromJson(String str) =>
      RolUserCourse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolUserCourse.fromMap(Map<String, dynamic> json) => RolUserCourse(
        results: List<ResultCursoId>.from(
            json["results"].map((x) => ResultCursoId.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class ResultCursoId {
  ResultCursoId({
    this.fullname,
    this.shortname,
    this.firstname,
    this.lastname,
    this.username,
    this.idRol,
    this.name,
    this.idCategory,
  });

  String? fullname;
  String? shortname;
  String? firstname;
  String? lastname;
  String? username;
  int? idRol;
  String? name;
  int? idCategory;

  factory ResultCursoId.fromJson(String str) =>
      ResultCursoId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCursoId.fromMap(Map<String, dynamic> json) => ResultCursoId(
        fullname: json["fullname"],
        shortname: json["shortname"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        idRol: json["idRol"],
        name: json["name"],
        idCategory: json["idCategory"],
      );

  Map<String, dynamic> toMap() => {
        "fullname": fullname,
        "shortname": shortname,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "idRol": idRol,
        "name": name,
        "idCategory": idCategory,
      };
}
