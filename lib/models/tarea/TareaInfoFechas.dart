// To parse this JSON data, do
//
//     final tareaFechas = tareaFechasFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class TareaFechas {
  TareaFechas({
    this.id,
    this.fullname,
    this.submitted,
    this.requiregrading,
    this.grantedextension,
    this.blindmarking,
    this.allowsubmissionsfromdate,
    this.duedate,
    this.cutoffdate,
    this.duedatestr,
  });

  int? id;
  String? fullname;
  bool? submitted;
  bool? requiregrading;
  bool? grantedextension;
  bool? blindmarking;
  int? allowsubmissionsfromdate;
  int? duedate;
  int? cutoffdate;
  String? duedatestr;

  factory TareaFechas.fromJson(String str) =>
      TareaFechas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TareaFechas.fromMap(Map<String, dynamic> json) => TareaFechas(
        id: json["id"],
        fullname: json["fullname"],
        submitted: json["submitted"],
        requiregrading: json["requiregrading"],
        grantedextension: json["grantedextension"],
        blindmarking: json["blindmarking"],
        allowsubmissionsfromdate: json["allowsubmissionsfromdate"],
        duedate: json["duedate"],
        cutoffdate: json["cutoffdate"],
        duedatestr: json["duedatestr"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "submitted": submitted,
        "requiregrading": requiregrading,
        "grantedextension": grantedextension,
        "blindmarking": blindmarking,
        "allowsubmissionsfromdate": allowsubmissionsfromdate,
        "duedate": duedate,
        "cutoffdate": cutoffdate,
        "duedatestr": duedatestr,
      };
}
