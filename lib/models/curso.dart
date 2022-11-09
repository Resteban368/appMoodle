// To parse this JSON data, do
//
//     final responseCursos = responseCursosFromMap(jsonString);

import 'dart:convert';

class ResponseCursos {
  ResponseCursos({
    this.ok,
    this.results,
  });

  bool? ok;
  List<ResultCursos>? results;

  factory ResponseCursos.fromJson(String str) =>
      ResponseCursos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseCursos.fromMap(Map<String, dynamic> json) => ResponseCursos(
        ok: json["ok"],
        results: List<ResultCursos>.from(
            json["results"].map((x) => ResultCursos.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class ResultCursos {
  ResultCursos({
    this.id,
    this.category,
    this.sortorder,
    this.fullname,
    this.shortname,
    this.idnumber,
    this.summary,
    this.summaryformat,
    this.format,
    this.showgrades,
    this.newsitems,
    this.startdate,
    this.enddate,
    this.relativedatesmode,
    this.marker,
    this.maxbytes,
    this.legacyfiles,
    this.showreports,
    this.visible,
    this.visibleold,
    this.downloadcontent,
    this.groupmode,
    this.groupmodeforce,
    this.defaultgroupingid,
    this.lang,
    this.calendartype,
    this.theme,
    this.timecreated,
    this.timemodified,
    this.requested,
    this.enablecompletion,
    this.completionnotify,
    this.cacherev,
    this.originalcourseid,
    this.showactivitydates,
    this.showcompletionconditions,
    this.name,
    this.description,
    this.descriptionformat,
    this.parent,
    this.coursecount,
    this.depth,
    this.path,
  });

  int? id;
  int? category;
  int? sortorder;
  String? fullname;
  String? shortname;
  String? idnumber;
  String? summary;
  int? summaryformat;
  String? format;
  int? showgrades;
  int? newsitems;
  int? startdate;
  int? enddate;
  int? relativedatesmode;
  int? marker;
  int? maxbytes;
  int? legacyfiles;
  int? showreports;
  int? visible;
  int? visibleold;
  dynamic downloadcontent;
  int? groupmode;
  int? groupmodeforce;
  int? defaultgroupingid;
  String? lang;
  String? calendartype;
  dynamic theme;
  int? timecreated;
  int? timemodified;
  int? requested;
  int? enablecompletion;
  int? completionnotify;
  int? cacherev;
  int? originalcourseid;
  int? showactivitydates;
  int? showcompletionconditions;
  String? name;
  String? description;
  int? descriptionformat;
  int? parent;
  int? coursecount;
  int? depth;
  String? path;

  factory ResultCursos.fromJson(String str) =>
      ResultCursos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCursos.fromMap(Map<String, dynamic> json) => ResultCursos(
        id: json["id"],
        category: json["category"],
        sortorder: json["sortorder"],
        fullname: json["fullname"],
        shortname: json["shortname"],
        idnumber: json["idnumber"],
        summary: json["summary"],
        summaryformat: json["summaryformat"],
        format: json["format"],
        showgrades: json["showgrades"],
        newsitems: json["newsitems"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        relativedatesmode: json["relativedatesmode"],
        marker: json["marker"],
        maxbytes: json["maxbytes"],
        legacyfiles: json["legacyfiles"],
        showreports: json["showreports"],
        visible: json["visible"],
        visibleold: json["visibleold"],
        downloadcontent: json["downloadcontent"],
        groupmode: json["groupmode"],
        groupmodeforce: json["groupmodeforce"],
        defaultgroupingid: json["defaultgroupingid"],
        lang: json["lang"],
        calendartype: json["calendartype"],
        theme: json["theme"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        requested: json["requested"],
        enablecompletion: json["enablecompletion"],
        completionnotify: json["completionnotify"],
        cacherev: json["cacherev"],
        originalcourseid:
            json["originalcourseid"] == null ? null : json["originalcourseid"],
        showactivitydates: json["showactivitydates"],
        showcompletionconditions: json["showcompletionconditions"],
        name: json["name"],
        description: json["description"],
        descriptionformat: json["descriptionformat"],
        parent: json["parent"],
        coursecount: json["coursecount"],
        depth: json["depth"],
        path: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "sortorder": sortorder,
        "fullname": fullname,
        "shortname": shortname,
        "idnumber": idnumber,
        "summary": summary,
        "summaryformat": summaryformat,
        "format": format,
        "showgrades": showgrades,
        "newsitems": newsitems,
        "startdate": startdate,
        "enddate": enddate,
        "relativedatesmode": relativedatesmode,
        "marker": marker,
        "maxbytes": maxbytes,
        "legacyfiles": legacyfiles,
        "showreports": showreports,
        "visible": visible,
        "visibleold": visibleold,
        "downloadcontent": downloadcontent,
        "groupmode": groupmode,
        "groupmodeforce": groupmodeforce,
        "defaultgroupingid": defaultgroupingid,
        "lang": lang,
        "calendartype": calendartype,
        "theme": theme,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "requested": requested,
        "enablecompletion": enablecompletion,
        "completionnotify": completionnotify,
        "cacherev": cacherev,
        "originalcourseid": originalcourseid == null ? null : originalcourseid,
        "showactivitydates": showactivitydates,
        "showcompletionconditions": showcompletionconditions,
        "name": name,
        "description": description,
        "descriptionformat": descriptionformat,
        "parent": parent,
        "coursecount": coursecount,
        "depth": depth,
        "path": path,
      };
}
