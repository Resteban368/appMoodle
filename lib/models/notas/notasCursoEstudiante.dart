// To parse this JSON data, do
//
//     final notasItemCursoEstudiante = notasItemCursoEstudianteFromMap(jsonString);

import 'dart:convert';

class NotasItemCursoEstudiante {
  NotasItemCursoEstudiante({
    this.usergrades,
    this.warnings,
  });

  List<Usergrade2>? usergrades;
  List<dynamic>? warnings;

  factory NotasItemCursoEstudiante.fromJson(String str) =>
      NotasItemCursoEstudiante.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotasItemCursoEstudiante.fromMap(Map<String, dynamic> json) =>
      NotasItemCursoEstudiante(
        usergrades: List<Usergrade2>.from(
            json["usergrades"].map((x) => Usergrade2.fromMap(x))),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "usergrades": List<dynamic>.from(usergrades!.map((x) => x.toMap())),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Usergrade2 {
  Usergrade2({
    this.courseid,
    this.courseidnumber,
    this.userid,
    this.userfullname,
    this.useridnumber,
    this.maxdepth,
    this.gradeitems,
  });

  int? courseid;
  String? courseidnumber;
  int? userid;
  String? userfullname;
  String? useridnumber;
  int? maxdepth;
  List<Gradeitem2>? gradeitems;

  factory Usergrade2.fromJson(String str) =>
      Usergrade2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usergrade2.fromMap(Map<String, dynamic> json) => Usergrade2(
        courseid: json["courseid"],
        courseidnumber: json["courseidnumber"],
        userid: json["userid"],
        userfullname: json["userfullname"],
        useridnumber: json["useridnumber"],
        maxdepth: json["maxdepth"],
        gradeitems: List<Gradeitem2>.from(
            json["gradeitems"].map((x) => Gradeitem2.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "courseid": courseid,
        "courseidnumber": courseidnumber,
        "userid": userid,
        "userfullname": userfullname,
        "useridnumber": useridnumber,
        "maxdepth": maxdepth,
        "gradeitems": List<dynamic>.from(gradeitems!.map((x) => x.toMap())),
      };
}

class Gradeitem2 {
  Gradeitem2({
    this.id,
    this.itemname,
    this.itemtype,
    this.itemmodule,
    this.iteminstance,
    this.itemnumber,
    this.idnumber,
    this.categoryid,
    this.outcomeid,
    this.scaleid,
    this.locked,
    this.cmid,
    this.weightraw,
    this.weightformatted,
    this.status,
    this.graderaw,
    this.gradedatesubmitted,
    this.gradedategraded,
    this.gradehiddenbydate,
    this.gradeneedsupdate,
    this.gradeishidden,
    this.gradeislocked,
    this.gradeisoverridden,
    this.gradeformatted,
    this.grademin,
    this.grademax,
    this.rangeformatted,
    this.percentageformatted,
    this.feedback,
    this.feedbackformat,
  });

  int? id;
  String? itemname;
  String? itemtype;
  String? itemmodule;
  int? iteminstance;
  int? itemnumber;
  String? idnumber;
  int? categoryid;
  dynamic outcomeid;
  dynamic scaleid;
  bool? locked;
  int? cmid;
  int? weightraw;
  String? weightformatted;
  String? status;
  double? graderaw;
  int? gradedatesubmitted;
  int? gradedategraded;
  bool? gradehiddenbydate;
  bool? gradeneedsupdate;
  bool? gradeishidden;
  bool? gradeislocked;
  bool? gradeisoverridden;
  String? gradeformatted;
  int? grademin;
  int? grademax;
  String? rangeformatted;
  String? percentageformatted;
  String? feedback;
  int? feedbackformat;

  factory Gradeitem2.fromJson(String str) =>
      Gradeitem2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gradeitem2.fromMap(Map<String, dynamic> json) => Gradeitem2(
        id: json["id"],
        itemname: json["itemname"],
        itemtype: json["itemtype"],
        itemmodule: json["itemmodule"],
        iteminstance: json["iteminstance"],
        itemnumber: json["itemnumber"],
        idnumber: json["idnumber"],
        categoryid: json["categoryid"],
        outcomeid: json["outcomeid"],
        scaleid: json["scaleid"],
        locked: json["locked"],
        cmid: json["cmid"],
        weightraw: json["weightraw"],
        weightformatted: json["weightformatted"],
        status: json["status"],
        // ignore: prefer_null_aware_operators
        graderaw: json["graderaw"],
        gradedatesubmitted: json["gradedatesubmitted"],
        gradedategraded: json["gradedategraded"],
        gradehiddenbydate: json["gradehiddenbydate"],
        gradeneedsupdate: json["gradeneedsupdate"],
        gradeishidden: json["gradeishidden"],
        gradeislocked: json["gradeislocked"],
        gradeisoverridden: json["gradeisoverridden"],
        gradeformatted: json["gradeformatted"],
        grademin: json["grademin"],
        grademax: json["grademax"],
        rangeformatted: json["rangeformatted"],
        percentageformatted: json["percentageformatted"],
        feedback: json["feedback"],
        feedbackformat: json["feedbackformat"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "itemname": itemname,
        "itemtype": itemtype,
        "itemmodule": itemmodule,
        "iteminstance": iteminstance,
        "itemnumber": itemnumber,
        "idnumber": idnumber,
        "categoryid": categoryid,
        "outcomeid": outcomeid,
        "scaleid": scaleid,
        "locked": locked,
        "cmid": cmid,
        "weightraw": weightraw,
        "weightformatted": weightformatted,
        "status": status,
        "graderaw": graderaw,
        "gradedatesubmitted": gradedatesubmitted,
        "gradedategraded": gradedategraded,
        "gradehiddenbydate": gradehiddenbydate,
        "gradeneedsupdate": gradeneedsupdate,
        "gradeishidden": gradeishidden,
        "gradeislocked": gradeislocked,
        "gradeisoverridden": gradeisoverridden,
        "gradeformatted": gradeformatted,
        "grademin": grademin,
        "grademax": grademax,
        "rangeformatted": rangeformatted,
        "percentageformatted": percentageformatted,
        "feedback": feedback,
        "feedbackformat": feedbackformat,
      };
}
