// To parse this JSON data, do
//
//     final foro = foroFromJson(jsonString);

import 'dart:convert';

class Foro {
  Foro({
    this.code,
    this.status,
    this.category,
  });

  int? code;
  String? status;
  List<Category>? category;

  factory Foro.fromRawJson(String str) => Foro.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Foro.fromJson(Map<String, dynamic> json) => Foro(
        code: json["code"],
        status: json["status"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.course,
    this.forum,
    this.name,
    this.firstpost,
    this.userid,
    this.groupid,
    this.assessed,
    this.timemodified,
    this.usermodified,
    this.timestart,
    this.timeend,
    this.pinned,
    this.timelocked,
  });

  int? id;
  int? course;
  int? forum;
  String? name;
  int? firstpost;
  int? userid;
  int? groupid;
  int? assessed;
  int? timemodified;
  int? usermodified;
  int? timestart;
  int? timeend;
  int? pinned;
  int? timelocked;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        course: json["course"],
        forum: json["forum"],
        name: json["name"],
        firstpost: json["firstpost"],
        userid: json["userid"],
        groupid: json["groupid"],
        assessed: json["assessed"],
        timemodified: json["timemodified"],
        usermodified: json["usermodified"],
        timestart: json["timestart"],
        timeend: json["timeend"],
        pinned: json["pinned"],
        timelocked: json["timelocked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "forum": forum,
        "name": name,
        "firstpost": firstpost,
        "userid": userid,
        "groupid": groupid,
        "assessed": assessed,
        "timemodified": timemodified,
        "usermodified": usermodified,
        "timestart": timestart,
        "timeend": timeend,
        "pinned": pinned,
        "timelocked": timelocked,
      };
}
