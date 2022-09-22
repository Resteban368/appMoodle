// To parse this JSON data, do
//
//     final postNotificaciones = postNotificacionesFromMap(jsonString);

import 'dart:convert';

PostNotificaciones postNotificacionesFromMap(String str) =>
    PostNotificaciones.fromMap(json.decode(str));

String postNotificacionesToMap(PostNotificaciones data) =>
    json.encode(data.toMap());

class PostNotificaciones {
  PostNotificaciones({
    this.id,
    this.useridfrom,
    this.useridto,
    this.subject,
    this.shortenedsubject,
    this.text,
    this.fullmessage,
    this.fullmessageformat,
    this.fullmessagehtml,
    this.smallmessage,
    this.contexturl,
    this.contexturlname,
    this.timecreated,
    this.timecreatedpretty,
    this.timeread,
    this.read,
    this.deleted,
    this.iconurl,
    this.component,
    this.eventtype,
    this.customdata,
  });

  int? id;
  int? useridfrom;
  int? useridto;
  String? subject;
  String? shortenedsubject;
  String? text;
  String? fullmessage;
  int? fullmessageformat;
  String? fullmessagehtml;
  String? smallmessage;
  String? contexturl;
  String? contexturlname;
  int? timecreated;
  String? timecreatedpretty;
  int? timeread;
  bool? read;
  bool? deleted;
  String? iconurl;
  String? component;
  String? eventtype;
  String? customdata;

  factory PostNotificaciones.fromMap(Map<String, dynamic> json) =>
      PostNotificaciones(
        id: json["id"],
        useridfrom: json["useridfrom"],
        useridto: json["useridto"],
        subject: json["subject"],
        shortenedsubject: json["shortenedsubject"],
        text: json["text"],
        fullmessage: json["fullmessage"],
        fullmessageformat: json["fullmessageformat"],
        fullmessagehtml: json["fullmessagehtml"],
        smallmessage: json["smallmessage"],
        contexturl: json["contexturl"],
        contexturlname: json["contexturlname"],
        timecreated: json["timecreated"],
        timecreatedpretty: json["timecreatedpretty"],
        timeread: json["timeread"],
        read: json["read"],
        deleted: json["deleted"],
        iconurl: json["iconurl"],
        component: json["component"],
        eventtype: json["eventtype"],
        customdata: json["customdata"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "useridfrom": useridfrom,
        "useridto": useridto,
        "subject": subject,
        "shortenedsubject": shortenedsubject,
        "text": text,
        "fullmessage": fullmessage,
        "fullmessageformat": fullmessageformat,
        "fullmessagehtml": fullmessagehtml,
        "smallmessage": smallmessage,
        "contexturl": contexturl,
        "contexturlname": contexturlname,
        "timecreated": timecreated,
        "timecreatedpretty": timecreatedpretty,
        "timeread": timeread,
        "read": read,
        "deleted": deleted,
        "iconurl": iconurl,
        "component": component,
        "eventtype": eventtype,
        "customdata": customdata,
      };
}
