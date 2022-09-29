// To parse this JSON data, do
//
//     final solicitudesResponse = solicitudesResponseFromJson(jsonString);

import 'dart:convert';

List<SolicitudesResponse> solicitudesResponseFromJson(String str) =>
    List<SolicitudesResponse>.from(
        json.decode(str).map((x) => SolicitudesResponse.fromJson(x)));

String solicitudesResponseToJson(List<SolicitudesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SolicitudesResponse {
  SolicitudesResponse({
    this.id,
    this.fullname,
    this.profileurl,
    this.profileimageurl,
    this.profileimageurlsmall,
    this.isonline,
    this.showonlinestatus,
    this.isblocked,
    this.iscontact,
    this.isdeleted,
    this.canmessageevenifblocked,
    this.canmessage,
    this.requirescontact,
    this.contactrequests,
  });

  int? id;
  String? fullname;
  String? profileurl;
  String? profileimageurl;
  String? profileimageurlsmall;
  dynamic isonline;
  bool? showonlinestatus;
  bool? isblocked;
  bool? iscontact;
  bool? isdeleted;
  dynamic canmessageevenifblocked;
  dynamic canmessage;
  dynamic requirescontact;
  List<dynamic>? contactrequests;

  factory SolicitudesResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesResponse(
        id: json["id"],
        fullname: json["fullname"],
        profileurl: json["profileurl"],
        profileimageurl: json["profileimageurl"],
        profileimageurlsmall: json["profileimageurlsmall"],
        isonline: json["isonline"],
        showonlinestatus: json["showonlinestatus"],
        isblocked: json["isblocked"],
        iscontact: json["iscontact"],
        isdeleted: json["isdeleted"],
        canmessageevenifblocked: json["canmessageevenifblocked"],
        canmessage: json["canmessage"],
        requirescontact: json["requirescontact"],
        contactrequests:
            List<dynamic>.from(json["contactrequests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "profileurl": profileurl,
        "profileimageurl": profileimageurl,
        "profileimageurlsmall": profileimageurlsmall,
        "isonline": isonline,
        "showonlinestatus": showonlinestatus,
        "isblocked": isblocked,
        "iscontact": iscontact,
        "isdeleted": isdeleted,
        "canmessageevenifblocked": canmessageevenifblocked,
        "canmessage": canmessage,
        "requirescontact": requirescontact,
        "contactrequests": List<dynamic>.from(contactrequests!.map((x) => x)),
      };
}
