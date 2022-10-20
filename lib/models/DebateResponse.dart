// ignore_for_file: file_names

import 'dart:convert';

class DebateResponse {
  DebateResponse({
    this.discussions,
    this.warnings,
  });

  List<DiscussionResponse>? discussions;
  List<dynamic>? warnings;

  factory DebateResponse.fromJson(String str) =>
      DebateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DebateResponse.fromMap(Map<String, dynamic> json) => DebateResponse(
        discussions: List<DiscussionResponse>.from(
            json["discussions"].map((x) => DiscussionResponse.fromMap(x))),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "discussions": List<dynamic>.from(discussions!.map((x) => x.toMap())),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class DiscussionResponse {
  DiscussionResponse({
    this.id,
    this.name,
    this.groupid,
    this.timemodified,
    this.usermodified,
    this.timestart,
    this.timeend,
    this.discussion,
    this.parent,
    this.userid,
    this.created,
    this.modified,
    this.mailed,
    this.subject,
    this.message,
    this.messageformat,
    this.messagetrust,
    this.attachment,
    this.totalscore,
    this.mailnow,
    this.userfullname,
    this.usermodifiedfullname,
    this.userpictureurl,
    this.usermodifiedpictureurl,
    this.numreplies,
    this.numunread,
    this.pinned,
    this.locked,
    this.starred,
    this.canreply,
    this.canlock,
    this.canfavourite,
  });

  int? id;
  String? name;
  int? groupid;
  int? timemodified;
  int? usermodified;
  int? timestart;
  int? timeend;
  int? discussion;
  int? parent;
  int? userid;
  int? created;
  int? modified;
  int? mailed;
  String? subject;
  String? message;
  int? messageformat;
  int? messagetrust;
  bool? attachment;
  int? totalscore;
  int? mailnow;
  String? userfullname;
  String? usermodifiedfullname;
  String? userpictureurl;
  String? usermodifiedpictureurl;
  int? numreplies;
  int? numunread;
  bool? pinned;
  bool? locked;
  bool? starred;
  bool? canreply;
  bool? canlock;
  bool? canfavourite;

  factory DiscussionResponse.fromJson(String str) =>
      DiscussionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscussionResponse.fromMap(Map<String, dynamic> json) =>
      DiscussionResponse(
        id: json["id"],
        name: json["name"],
        groupid: json["groupid"],
        timemodified: json["timemodified"],
        usermodified: json["usermodified"],
        timestart: json["timestart"],
        timeend: json["timeend"],
        discussion: json["discussion"],
        parent: json["parent"],
        userid: json["userid"],
        created: json["created"],
        modified: json["modified"],
        mailed: json["mailed"],
        subject: json["subject"],
        message: json["message"],
        messageformat: json["messageformat"],
        messagetrust: json["messagetrust"],
        attachment: json["attachment"],
        totalscore: json["totalscore"],
        mailnow: json["mailnow"],
        userfullname: json["userfullname"],
        usermodifiedfullname: json["usermodifiedfullname"],
        userpictureurl: json["userpictureurl"],
        usermodifiedpictureurl: json["usermodifiedpictureurl"],
        numreplies: json["numreplies"],
        numunread: json["numunread"],
        pinned: json["pinned"],
        locked: json["locked"],
        starred: json["starred"],
        canreply: json["canreply"],
        canlock: json["canlock"],
        canfavourite: json["canfavourite"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "groupid": groupid,
        "timemodified": timemodified,
        "usermodified": usermodified,
        "timestart": timestart,
        "timeend": timeend,
        "discussion": discussion,
        "parent": parent,
        "userid": userid,
        "created": created,
        "modified": modified,
        "mailed": mailed,
        "subject": subject,
        "message": message,
        "messageformat": messageformat,
        "messagetrust": messagetrust,
        "attachment": attachment,
        "totalscore": totalscore,
        "mailnow": mailnow,
        "userfullname": userfullname,
        "usermodifiedfullname": usermodifiedfullname,
        "userpictureurl": userpictureurl,
        "usermodifiedpictureurl": usermodifiedpictureurl,
        "numreplies": numreplies,
        "numunread": numunread,
        "pinned": pinned,
        "locked": locked,
        "starred": starred,
        "canreply": canreply,
        "canlock": canlock,
        "canfavourite": canfavourite,
      };
}
