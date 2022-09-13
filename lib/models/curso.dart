// To parse this JSON data, do
//
//     final responseCursos = responseCursosFromJson(jsonString);

import 'dart:convert';

List<ResponseCursos> responseCursosFromJson(String str) =>
    List<ResponseCursos>.from(
        json.decode(str).map((x) => ResponseCursos.fromJson(x)));

String responseCursosToJson(List<ResponseCursos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseCursos {
  ResponseCursos({
    this.id,
    this.shortname,
    this.fullname,
    this.displayname,
    this.enrolledusercount,
    this.idnumber,
    this.visible,
    this.summary,
    this.summaryformat,
    this.format,
    this.showgrades,
    this.lang,
    this.enablecompletion,
    this.completionhascriteria,
    this.completionusertracked,
    this.category,
    this.progress,
    this.completed,
    this.startdate,
    this.enddate,
    this.marker,
    this.lastaccess,
    this.isfavourite,
    this.hidden,
    this.overviewfiles,
    this.showactivitydates,
    this.showcompletionconditions,
  });

  int? id;
  String? shortname;
  String? fullname;
  String? displayname;
  int? enrolledusercount;
  String? idnumber;
  int? visible;
  String? summary;
  int? summaryformat;
  String? format;
  bool? showgrades;
  String? lang;
  bool? enablecompletion;
  bool? completionhascriteria;
  bool? completionusertracked;
  int? category;
  dynamic progress;
  bool? completed;
  int? startdate;
  int? enddate;
  int? marker;
  dynamic lastaccess;
  bool? isfavourite;
  bool? hidden;
  List<Overviewfile>? overviewfiles;
  bool? showactivitydates;
  bool? showcompletionconditions;

  factory ResponseCursos.fromJson(Map<String, dynamic> json) => ResponseCursos(
        id: json["id"],
        shortname: json["shortname"],
        fullname: json["fullname"],
        displayname: json["displayname"],
        enrolledusercount: json["enrolledusercount"],
        idnumber: json["idnumber"],
        visible: json["visible"],
        summary: json["summary"],
        summaryformat: json["summaryformat"],
        format: json["format"],
        showgrades: json["showgrades"],
        lang: json["lang"],
        enablecompletion: json["enablecompletion"],
        completionhascriteria: json["completionhascriteria"],
        completionusertracked: json["completionusertracked"],
        category: json["category"],
        progress: json["progress"],
        completed: json["completed"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        marker: json["marker"],
        lastaccess: json["lastaccess"],
        isfavourite: json["isfavourite"],
        hidden: json["hidden"],
        overviewfiles: List<Overviewfile>.from(
            json["overviewfiles"].map((x) => Overviewfile.fromJson(x))),
        showactivitydates: json["showactivitydates"],
        showcompletionconditions: json["showcompletionconditions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shortname": shortname,
        "fullname": fullname,
        "displayname": displayname,
        "enrolledusercount": enrolledusercount,
        "idnumber": idnumber,
        "visible": visible,
        "summary": summary,
        "summaryformat": summaryformat,
        "format": format,
        "showgrades": showgrades,
        "lang": lang,
        "enablecompletion": enablecompletion,
        "completionhascriteria": completionhascriteria,
        "completionusertracked": completionusertracked,
        "category": category,
        "progress": progress,
        "completed": completed,
        "startdate": startdate,
        "enddate": enddate,
        "marker": marker,
        "lastaccess": lastaccess,
        "isfavourite": isfavourite,
        "hidden": hidden,
        "overviewfiles":
            List<dynamic>.from(overviewfiles!.map((x) => x.toJson())),
        "showactivitydates": showactivitydates,
        "showcompletionconditions": showcompletionconditions,
      };
}

class Overviewfile {
  Overviewfile({
    this.filename,
    this.filepath,
    this.filesize,
    this.fileurl,
    this.timemodified,
    this.mimetype,
  });
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timemodified;
  String? mimetype;

  factory Overviewfile.fromJson(Map<String, dynamic> json) => Overviewfile(
        filename: json["filename"],
        filepath: json["filepath"],
        filesize: json["filesize"],
        fileurl: json["fileurl"],
        timemodified: json["timemodified"],
        mimetype: json["mimetype"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "filepath": filepath,
        "filesize": filesize,
        "fileurl": fileurl,
        "timemodified": timemodified,
        "mimetype": mimetype,
      };
}
