// To parse this JSON data, do
//
//     final infoUser = infoUserFromJson(jsonString);

import 'dart:convert';

List<InfoUser> infoUserFromJson(String str) =>
    List<InfoUser>.from(json.decode(str).map((x) => InfoUser.fromJson(x)));

String infoUserToJson(List<InfoUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoUser {
  InfoUser({
    this.id,
    this.username,
    this.lastname,
    this.fullname,
    this.email,
    this.department,
    this.firstaccess,
    this.lastaccess,
    this.auth,
    this.suspended,
    this.confirmed,
    this.lang,
    this.theme,
    this.timezone,
    this.mailformat,
    this.description,
    this.descriptionformat,
    this.city,
    this.country,
    this.profileimageurlsmall,
    this.profileimageurl,
  });

  int? id;
  String? username;
  String? lastname;
  String? fullname;
  String? email;
  String? department;
  int? firstaccess;
  int? lastaccess;
  String? auth;
  bool? suspended;
  bool? confirmed;
  String? lang;
  String? theme;
  String? timezone;
  int? mailformat;
  String? description;
  int? descriptionformat;
  String? city;
  String? country;
  String? profileimageurlsmall;
  String? profileimageurl;

  factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(
        id: json["id"],
        username: json["username"],
        lastname: json["lastname"],
        fullname: json["fullname"],
        email: json["email"],
        department: json["department"],
        firstaccess: json["firstaccess"],
        lastaccess: json["lastaccess"],
        auth: json["auth"],
        suspended: json["suspended"],
        confirmed: json["confirmed"],
        lang: json["lang"],
        theme: json["theme"],
        timezone: json["timezone"],
        mailformat: json["mailformat"],
        description: json["description"],
        descriptionformat: json["descriptionformat"],
        city: json["city"],
        country: json["country"],
        profileimageurlsmall: json["profileimageurlsmall"],
        profileimageurl: json["profileimageurl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "lastname": lastname,
        "fullname": fullname,
        "email": email,
        "department": department,
        "firstaccess": firstaccess,
        "lastaccess": lastaccess,
        "auth": auth,
        "suspended": suspended,
        "confirmed": confirmed,
        "lang": lang,
        "theme": theme,
        "timezone": timezone,
        "mailformat": mailformat,
        "description": description,
        "descriptionformat": descriptionformat,
        "city": city,
        "country": country,
        "profileimageurlsmall": profileimageurlsmall,
        "profileimageurl": profileimageurl,
      };
}
