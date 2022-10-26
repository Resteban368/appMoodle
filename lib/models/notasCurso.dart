// To parse this JSON data, do
//
//     final notaFinalCurso = notaFinalCursoFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class NotaFinalCurso {
  NotaFinalCurso({
    this.grades,
    this.warnings,
  });

  List<Notas>? grades;
  List<dynamic>? warnings;

  factory NotaFinalCurso.fromJson(String str) =>
      NotaFinalCurso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotaFinalCurso.fromMap(Map<String, dynamic> json) => NotaFinalCurso(
        grades: List<Notas>.from(json["grades"].map((x) => Notas.fromMap(x))),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "grades": List<dynamic>.from(grades!.map((x) => x.toMap())),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Notas {
  Notas({
    this.courseid,
    this.grade,
    this.rawgrade,
  });

  int? courseid;
  String? grade;
  String? rawgrade;

  factory Notas.fromJson(String str) => Notas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notas.fromMap(Map<String, dynamic> json) => Notas(
        courseid: json["courseid"],
        grade: json["grade"],
        rawgrade: json["rawgrade"],
      );

  Map<String, dynamic> toMap() => {
        "courseid": courseid,
        "grade": grade,
        "rawgrade": rawgrade,
      };
}
