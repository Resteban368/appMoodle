// To parse this JSON data, do
//
//     final discussion = discussionFromJson(jsonString);

import 'dart:convert';

class Discussion {
  Discussion({
    this.posts,
    this.forumid,
    this.courseid,
    this.ratinginfo,
    this.warnings,
  });

  List<Post>? posts;
  int? forumid;
  int? courseid;
  Ratinginfo? ratinginfo;
  List<dynamic>? warnings;

  factory Discussion.fromJson(String str) =>
      Discussion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Discussion.fromMap(Map<String, dynamic> json) => Discussion(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
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

class Post {
  Post({
    this.id,
    this.subject,
    this.replysubject,
    this.message,
    this.messageformat,
    this.author,
    this.discussionid,
    this.hasparent,
    this.parentid,
    this.timecreated,
    this.timemodified,
    this.unread,
    this.isdeleted,
    this.isprivatereply,
    this.haswordcount,
    this.wordcount,
    this.charcount,
    this.capabilities,
    this.urls,
    this.attachments,
    this.tags,
    this.html,
  });

  int? id;
  String? subject;
  String? replysubject;
  String? message;
  int? messageformat;
  Author? author;
  int? discussionid;
  bool? hasparent;
  int? parentid;
  int? timecreated;
  int? timemodified;
  dynamic unread;
  bool? isdeleted;
  bool? isprivatereply;
  bool? haswordcount;
  dynamic wordcount;
  dynamic charcount;
  Capabilities? capabilities;
  Map<String, String>? urls;
  List<dynamic>? attachments;
  List<dynamic>? tags;
  Html? html;

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"],
        subject: json["subject"],
        replysubject: json["replysubject"],
        message: json["message"],
        messageformat: json["messageformat"],
        author: Author.fromMap(json["author"]),
        discussionid: json["discussionid"],
        hasparent: json["hasparent"],
        parentid: json["parentid"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        unread: json["unread"],
        isdeleted: json["isdeleted"],
        isprivatereply: json["isprivatereply"],
        haswordcount: json["haswordcount"],
        wordcount: json["wordcount"],
        charcount: json["charcount"],
        capabilities: Capabilities.fromMap(json["capabilities"]),
        urls: Map.from(json["urls"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        html: Html.fromMap(json["html"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subject": subject,
        "replysubject": replysubject,
        "message": message,
        "messageformat": messageformat,
        "author": author!.toMap(),
        "discussionid": discussionid,
        "hasparent": hasparent,
        "parentid": parentid,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "unread": unread,
        "isdeleted": isdeleted,
        "isprivatereply": isprivatereply,
        "haswordcount": haswordcount,
        "wordcount": wordcount,
        "charcount": charcount,
        "capabilities": capabilities!.toMap(),
        "urls": Map.from(urls!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "html": html!.toMap(),
      };
}

class Author {
  Author({
    this.id,
    this.fullname,
    this.isdeleted,
    this.groups,
    this.urls,
  });

  int? id;
  String? fullname;
  bool? isdeleted;
  List<dynamic>? groups;
  Urls? urls;

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        id: json["id"],
        fullname: json["fullname"],
        isdeleted: json["isdeleted"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        urls: Urls.fromMap(json["urls"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "isdeleted": isdeleted,
        "groups": List<dynamic>.from(groups!.map((x) => x)),
        "urls": urls!.toMap(),
      };
}

class Urls {
  Urls({
    this.profile,
    this.profileimage,
  });

  String? profile;
  String? profileimage;

  factory Urls.fromJson(String str) => Urls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Urls.fromMap(Map<String, dynamic> json) => Urls(
        profile: json["profile"],
        profileimage: json["profileimage"],
      );

  Map<String, dynamic> toMap() => {
        "profile": profile,
        "profileimage": profileimage,
      };
}

class Capabilities {
  Capabilities({
    this.view,
    this.edit,
    this.delete,
    this.split,
    this.reply,
    this.selfenrol,
    this.capabilitiesExport,
    this.controlreadstatus,
    this.canreplyprivately,
  });

  bool? view;
  bool? edit;
  bool? delete;
  bool? split;
  bool? reply;
  bool? selfenrol;
  bool? capabilitiesExport;
  bool? controlreadstatus;
  bool? canreplyprivately;

  factory Capabilities.fromJson(String str) =>
      Capabilities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Capabilities.fromMap(Map<String, dynamic> json) => Capabilities(
        view: json["view"],
        edit: json["edit"],
        delete: json["delete"],
        split: json["split"],
        reply: json["reply"],
        selfenrol: json["selfenrol"],
        capabilitiesExport: json["export"],
        controlreadstatus: json["controlreadstatus"],
        canreplyprivately: json["canreplyprivately"],
      );

  Map<String, dynamic> toMap() => {
        "view": view,
        "edit": edit,
        "delete": delete,
        "split": split,
        "reply": reply,
        "selfenrol": selfenrol,
        "export": capabilitiesExport,
        "controlreadstatus": controlreadstatus,
        "canreplyprivately": canreplyprivately,
      };
}

class Html {
  Html({
    this.rating,
    this.taglist,
    this.authorsubheading,
  });

  dynamic rating;
  dynamic taglist;
  String? authorsubheading;

  factory Html.fromJson(String str) => Html.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Html.fromMap(Map<String, dynamic> json) => Html(
        rating: json["rating"],
        taglist: json["taglist"],
        authorsubheading: json["authorsubheading"],
      );

  Map<String, dynamic> toMap() => {
        "rating": rating,
        "taglist": taglist,
        "authorsubheading": authorsubheading,
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

  factory Ratinginfo.fromJson(String str) =>
      Ratinginfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
