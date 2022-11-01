// To parse this JSON data, do
//
//     final notasItemCurso = notasItemCursoFromMap(jsonString);

// ignore_for_file: prefer_null_aware_operators, constant_identifier_names, file_names

import 'dart:convert';

class NotasItemCurso {
  NotasItemCurso({
    this.usergrades,
    this.warnings,
  });

  List<Usergrade>? usergrades;
  List<dynamic>? warnings;

  factory NotasItemCurso.fromJson(String str) =>
      NotasItemCurso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotasItemCurso.fromMap(Map<String, dynamic> json) => NotasItemCurso(
        usergrades: List<Usergrade>.from(
            json["usergrades"].map((x) => Usergrade.fromMap(x))),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "usergrades": List<dynamic>.from(usergrades!.map((x) => x.toMap())),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Usergrade {
  Usergrade({
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
  List<Gradeitem>? gradeitems;

  factory Usergrade.fromJson(String str) => Usergrade.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usergrade.fromMap(Map<String, dynamic> json) => Usergrade(
        courseid: json["courseid"],
        courseidnumber: json["courseidnumber"],
        userid: json["userid"],
        userfullname: json["userfullname"],
        useridnumber: json["useridnumber"],
        maxdepth: json["maxdepth"],
        gradeitems: List<Gradeitem>.from(
            json["gradeitems"].map((x) => Gradeitem.fromMap(x))),
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

class Gradeitem {
  Gradeitem({
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

  factory Gradeitem.fromJson(String str) => Gradeitem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gradeitem.fromMap(Map<String, dynamic> json) => Gradeitem(
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

// enum Gradeformatted { EMPTY, THE_380 }



// enum Itemmodule { ATTENDANCE, ASSIGN, QUIZ }

// final itemmoduleValues = EnumValues({
//     "assign": Itemmodule.ASSIGN,
//     "attendance": Itemmodule.ATTENDANCE,
//     "quiz": Itemmodule.QUIZ
// });

// enum Itemtype { MOD, COURSE }

// final itemtypeValues = EnumValues({
//     "course": Itemtype.COURSE,
//     "mod": Itemtype.MOD
// });

// enum Percentageformatted { EMPTY, THE_7600 }

// final percentageformattedValues = EnumValues({
//     "-": Percentageformatted.EMPTY,
//     "76,00 %": Percentageformatted.THE_7600
// });

// enum Rangeformatted { THE_0_NDASH_100, THE_0_NDASH_5, THE_0_NDASH_10 }

// final rangeformattedValues = EnumValues({
//     "0&ndash;10": Rangeformatted.THE_0_NDASH_10,
//     "0&ndash;100": Rangeformatted.THE_0_NDASH_100,
//     "0&ndash;5": Rangeformatted.THE_0_NDASH_5
// });

// enum Weightformatted { THE_000, THE_10000 }

// final weightformattedValues = EnumValues({
//     "0,00 %": Weightformatted.THE_000,
//     "100,00 %": Weightformatted.THE_10000
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
