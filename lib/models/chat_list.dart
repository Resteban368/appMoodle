// To parse this JSON data, do
//
//     final chatListResponse = chatListResponseFromMap(jsonString);

import 'dart:convert';

class ChatListResponse {
  ChatListResponse({
    this.conversations,
  });

  List<Conversation>? conversations;

  factory ChatListResponse.fromJson(String str) =>
      ChatListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatListResponse.fromMap(Map<String, dynamic> json) =>
      ChatListResponse(
        conversations: List<Conversation>.from(
            json["conversations"].map((x) => Conversation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "conversations":
            List<dynamic>.from(conversations!.map((x) => x.toMap())),
      };
}

class Conversation {
  Conversation({
    this.id,
    this.name,
    this.subname,
    this.imageurl,
    this.type,
    this.membercount,
    this.ismuted,
    this.isfavourite,
    this.isread,
    this.unreadcount,
    this.members,
    this.messages,
    this.candeletemessagesforallusers,
  });

  int? id;
  String? name;
  dynamic subname;
  dynamic imageurl;
  int? type;
  int? membercount;
  bool? ismuted;
  bool? isfavourite;
  bool? isread;
  dynamic unreadcount;
  List<Member>? members;
  List<Message>? messages;
  bool? candeletemessagesforallusers;

  factory Conversation.fromJson(String str) =>
      Conversation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        name: json["name"],
        subname: json["subname"],
        imageurl: json["imageurl"],
        type: json["type"],
        membercount: json["membercount"],
        ismuted: json["ismuted"],
        isfavourite: json["isfavourite"],
        isread: json["isread"],
        unreadcount: json["unreadcount"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromMap(x))),
        messages:
            List<Message>.from(json["messages"].map((x) => Message.fromMap(x))),
        candeletemessagesforallusers: json["candeletemessagesforallusers"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "subname": subname,
        "imageurl": imageurl,
        "type": type,
        "membercount": membercount,
        "ismuted": ismuted,
        "isfavourite": isfavourite,
        "isread": isread,
        "unreadcount": unreadcount,
        "members": List<dynamic>.from(members!.map((x) => x.toMap())),
        "messages": List<dynamic>.from(messages!.map((x) => x.toMap())),
        "candeletemessagesforallusers": candeletemessagesforallusers,
      };
}

class Member {
  Member({
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
  bool? isonline;
  bool? showonlinestatus;
  bool? isblocked;
  bool? iscontact;
  bool? isdeleted;
  bool? canmessageevenifblocked;
  bool? canmessage;
  bool? requirescontact;
  List<dynamic>? contactrequests;

  factory Member.fromJson(String str) => Member.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Member.fromMap(Map<String, dynamic> json) => Member(
        id: json["id"],
        fullname: json["fullname"],
        profileurl: json["profileurl"],
        profileimageurl: json["profileimageurl"],
        profileimageurlsmall: json["profileimageurlsmall"],
        isonline: json["isonline"] == null ? null : json["isonline"],
        showonlinestatus: json["showonlinestatus"],
        isblocked: json["isblocked"],
        iscontact: json["iscontact"],
        isdeleted: json["isdeleted"],
        canmessageevenifblocked: json["canmessageevenifblocked"] == null
            ? null
            : json["canmessageevenifblocked"],
        canmessage: json["canmessage"] == null ? null : json["canmessage"],
        requirescontact:
            json["requirescontact"] == null ? null : json["requirescontact"],
        contactrequests:
            List<dynamic>.from(json["contactrequests"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "profileurl": profileurl,
        "profileimageurl": profileimageurl,
        "profileimageurlsmall": profileimageurlsmall,
        "isonline": isonline == null ? null : isonline,
        "showonlinestatus": showonlinestatus,
        "isblocked": isblocked,
        "iscontact": iscontact,
        "isdeleted": isdeleted,
        "canmessageevenifblocked":
            canmessageevenifblocked == null ? null : canmessageevenifblocked,
        "canmessage": canmessage == null ? null : canmessage,
        "requirescontact": requirescontact == null ? null : requirescontact,
        "contactrequests": List<dynamic>.from(contactrequests!.map((x) => x)),
      };
}

class Message {
  Message({
    this.id,
    this.useridfrom,
    this.text,
    this.timecreated,
  });

  int? id;
  int? useridfrom;
  String? text;
  int? timecreated;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        useridfrom: json["useridfrom"],
        text: json["text"],
        timecreated: json["timecreated"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "useridfrom": useridfrom,
        "text": text,
        "timecreated": timecreated,
      };
}
