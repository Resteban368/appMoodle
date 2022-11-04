// To parse this JSON data, do
//
//     final chatNew = chatNewFromMap(jsonString);

import 'dart:convert';

class ChatNew {
  ChatNew({
    this.msgid,
    this.clientmsgid,
    this.text,
    this.timecreated,
    this.conversationid,
    this.useridfrom,
    this.candeletemessagesforallusers,
  });

  int? msgid;
  String? clientmsgid;
  String? text;
  int? timecreated;
  int? conversationid;
  int? useridfrom;
  bool? candeletemessagesforallusers;

  factory ChatNew.fromJson(String str) => ChatNew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatNew.fromMap(Map<String, dynamic> json) => ChatNew(
        msgid: json["msgid"],
        clientmsgid: json["clientmsgid"],
        text: json["text"],
        timecreated: json["timecreated"],
        conversationid: json["conversationid"],
        useridfrom: json["useridfrom"],
        candeletemessagesforallusers: json["candeletemessagesforallusers"],
      );

  Map<String, dynamic> toMap() => {
        "msgid": msgid,
        "clientmsgid": clientmsgid,
        "text": text,
        "timecreated": timecreated,
        "conversationid": conversationid,
        "useridfrom": useridfrom,
        "candeletemessagesforallusers": candeletemessagesforallusers,
      };
}
