// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<ResponseDataCursoForId> welcomeFromJson(String str) =>
    List<ResponseDataCursoForId>.from(
        json.decode(str).map((x) => ResponseDataCursoForId.fromJson(x)));

String welcomeToJson(List<ResponseDataCursoForId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseDataCursoForId {
  ResponseDataCursoForId({
    this.id,
    this.name,
    this.visible,
    this.summary,
    this.summaryformat,
    this.section,
    this.hiddenbynumsections,
    this.uservisible,
    this.modules,
  });

  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;
  List<Module>? modules;

  factory ResponseDataCursoForId.fromJson(Map<String, dynamic> json) =>
      ResponseDataCursoForId(
        id: json["id"],
        name: json["name"],
        visible: json["visible"],
        summary: json["summary"],
        summaryformat: json["summaryformat"],
        section: json["section"],
        hiddenbynumsections: json["hiddenbynumsections"],
        uservisible: json["uservisible"],
        modules:
            List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "visible": visible,
        "summary": summary,
        "summaryformat": summaryformat,
        "section": section,
        "hiddenbynumsections": hiddenbynumsections,
        "uservisible": uservisible,
        "modules": List<dynamic>.from(modules!.map((x) => x.toJson())),
      };
}

class Module {
  Module({
    this.id,
    this.name,
    this.instance,
    this.contextid,
    this.description,
    this.visible,
    this.uservisible,
    this.visibleoncoursepage,
    this.modicon,
    this.modname,
    this.modplural,
    this.indent,
    this.onclick,
    this.afterlink,
    // this.customdata,
    this.noviewlink,
    this.completion,
    this.completiondata,
    this.contents,
    this.dates,
    this.url,
  });

  int? id;
  String? name;
  int? instance;
  int? contextid;
  String? description;
  int? visible;
  bool? uservisible;
  int? visibleoncoursepage;
  String? modicon;
  String? modname;
  String? modplural;
  int? indent;
  String? onclick;
  dynamic afterlink;
  // Customdata? customdata;
  bool? noviewlink;
  int? completion;
  Completiondata? completiondata;
  List<Content>? contents;
  List<Date>? dates;
  String? url;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        id: json["id"],
        name: json["name"],
        instance: json["instance"],
        contextid: json["contextid"],
        description: json["description"],
        visible: json["visible"],
        uservisible: json["uservisible"],
        visibleoncoursepage: json["visibleoncoursepage"],
        modicon: json["modicon"],
        modname: json["modname"],
        modplural: json["modplural"],
        indent: json["indent"],
        onclick: json["onclick"],
        afterlink: json["afterlink"],
        // customdata: json["customdata"],
        noviewlink: json["noviewlink"],
        completion: json["completion"],
        completiondata: Completiondata.fromJson(json["completiondata"]),
        contents: json["contents"] == null
            ? null
            : List<Content>.from(
                json["contents"].map((x) => Content.fromJson(x))),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "instance": instance,
        "contextid": contextid,
        "description": description,
        "visible": visible,
        "uservisible": uservisible,
        "visibleoncoursepage": visibleoncoursepage,
        "modicon": modicon,
        "modname": modname,
        "modplural": modplural,
        "indent": indent,
        "onclick": onclick,
        "afterlink": afterlink,
        // "customdata": customdata,
        "noviewlink": noviewlink,
        "completion": completion,
        "completiondata":
            completiondata == null ? {} : completiondata!.toJson(),
        "contents": contents == null
            ? null
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "dates": List<dynamic>.from(dates!.map((x) => x.toJson())),
        "url": url,
      };
}

class Completiondata {
  Completiondata({
    this.state,
    this.timecompleted,
    this.overrideby,
    this.valueused,
    this.hascompletion,
    this.isautomatic,
    this.istrackeduser,
    this.uservisible,
    this.details,
  });

  int? state;
  int? timecompleted;
  dynamic overrideby;
  bool? valueused;
  bool? hascompletion;
  bool? isautomatic;
  bool? istrackeduser;
  bool? uservisible;
  List<dynamic>? details;

  factory Completiondata.fromJson(Map<String, dynamic> json) => Completiondata(
        state: json["state"],
        timecompleted: json["timecompleted"],
        overrideby: json["overrideby"],
        valueused: json["valueused"],
        hascompletion: json["hascompletion"],
        isautomatic: json["isautomatic"],
        istrackeduser: json["istrackeduser"],
        uservisible: json["uservisible"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "timecompleted": timecompleted,
        "overrideby": overrideby,
        "valueused": valueused,
        "hascompletion": hascompletion,
        "isautomatic": isautomatic,
        "istrackeduser": istrackeduser,
        "uservisible": uservisible,
        "details": List<dynamic>.from(details!.map((x) => x)),
      };
}

class Customdata {
  Customdata({
    this.duedate,
    this.allowsubmissionsfromdate,
  });

  int? duedate;
  int? allowsubmissionsfromdate;

  factory Customdata.fromJson(Map<String, dynamic> json) => Customdata(
        duedate: json["duedate"],
        allowsubmissionsfromdate: json["allowsubmissionsfromdate"],
      );

  Map<String, dynamic> toJson() => {
        "duedate": duedate,
        "allowsubmissionsfromdate": allowsubmissionsfromdate,
      };
}

class Content {
  Content({
    this.type,
    this.filename,
    this.filepath,
    this.filesize,
    this.fileurl,
    this.timecreated,
    this.timemodified,
    this.sortorder,
    this.mimetype,
    this.isexternalfile,
    this.userid,
    this.author,
    this.license,
  });

  String? type;
  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timecreated;
  int? timemodified;
  int? sortorder;
  String? mimetype;
  bool? isexternalfile;
  int? userid;
  String? author;
  String? license;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        type: json["type"],
        filename: json["filename"],
        filepath: json["filepath"],
        filesize: json["filesize"],
        fileurl: json["fileurl"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        sortorder: json["sortorder"],
        mimetype: json["mimetype"],
        isexternalfile: json["isexternalfile"],
        userid: json["userid"],
        author: json["author"],
        license: json["license"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "filename": filename,
        "filepath": filepath,
        "filesize": filesize,
        "fileurl": fileurl,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "sortorder": sortorder,
        "mimetype": mimetype,
        "isexternalfile": isexternalfile,
        "userid": userid,
        "author": author,
        "license": license,
      };
}

class Date {
  Date({
    this.label,
    this.timestamp,
  });

  String? label;
  int? timestamp;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        label: json["label"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "timestamp": timestamp,
      };
}
