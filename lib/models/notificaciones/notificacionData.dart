// To parse this JSON data, do
//
//     final tareaFechas = tareaFechasFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class TareaFechas {
  TareaFechas({
    this.cmid,
    this.instance,
    this.messagetype,
    this.blindmarking,
    this.uniqueidforuser,
    this.courseid,
  });

  String? cmid;
  String? instance;
  String? messagetype;
  bool? blindmarking;
  String? uniqueidforuser;
  String? courseid;

  factory TareaFechas.fromJson(String str) =>
      TareaFechas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TareaFechas.fromMap(Map<String, dynamic> json) => TareaFechas(
        cmid: json["cmid"],
        instance: json["instance"],
        messagetype: json["messagetype"],
        blindmarking: json["blindmarking"],
        uniqueidforuser: json["uniqueidforuser"],
        courseid: json["courseid"],
      );

  Map<String, dynamic> toMap() => {
        "cmid": cmid,
        "instance": instance,
        "messagetype": messagetype,
        "blindmarking": blindmarking,
        "uniqueidforuser": uniqueidforuser,
        "courseid": courseid,
      };
}
