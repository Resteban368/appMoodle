// To parse this JSON data, do
//
//     final foroResponse = foroResponseFromMap(jsonString);

import 'dart:convert';

import 'package:campus_virtual/models/PostModel.dart';

ForoResponse foroResponseFromMap(String str) =>
    ForoResponse.fromMap(json.decode(str));

String foroResponseToMap(ForoResponse data) => json.encode(data.toMap());

class ForoResponse {
  ForoResponse({
    this.posts,
    this.forumid,
    this.courseid,
    this.ratinginfo,
    this.warnings,
  });

  List<PostModel>? posts;
  int? forumid;
  int? courseid;
  Ratinginfo? ratinginfo;
  List<dynamic>? warnings;

  factory ForoResponse.fromMap(Map<String, dynamic> json) => ForoResponse(
        posts: List<PostModel>.from(
            json["posts"].map((x) => PostModel.fromMap(x))),
        forumid: json["forumid"],
        courseid: json["courseid"],
        ratinginfo: Ratinginfo.fromMap(json["ratinginfo"]),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "posts": List<dynamic>.from(posts!.map((x) => x.toMap())),
        "forumid": forumid,
        "courseid": courseid,
        "ratinginfo": ratinginfo!.toMap(),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Urls {
  Urls({
    this.profile,
    this.profileimage,
  });

  String? profile;
  String? profileimage;

  factory Urls.fromMap(Map<String, dynamic> json) => Urls(
        profile: json["profile"],
        profileimage: json["profileimage"],
      );

  Map<String, dynamic> toMap() => {
        "profile": profile,
        "profileimage": profileimage,
      };
}

class Ratinginfo {
  Ratinginfo({
    this.contextid,
    this.component,
    this.ratingarea,
    this.canviewall,
    this.canviewany,
    this.scales,
    this.ratings,
  });

  int? contextid;
  String? component;
  String? ratingarea;
  dynamic canviewall;
  dynamic canviewany;
  List<dynamic>? scales;
  List<dynamic>? ratings;

  factory Ratinginfo.fromMap(Map<String, dynamic> json) => Ratinginfo(
        contextid: json["contextid"],
        component: json["component"],
        ratingarea: json["ratingarea"],
        canviewall: json["canviewall"],
        canviewany: json["canviewany"],
        scales: List<dynamic>.from(json["scales"].map((x) => x)),
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "contextid": contextid,
        "component": component,
        "ratingarea": ratingarea,
        "canviewall": canviewall,
        "canviewany": canviewany,
        "scales": List<dynamic>.from(scales!.map((x) => x)),
        "ratings": List<dynamic>.from(ratings!.map((x) => x)),
      };
}
