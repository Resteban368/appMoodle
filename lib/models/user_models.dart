// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    this.ok,
    this.results,
  });

  bool? ok;
  List<UserClass>? results;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        ok: json["ok"],
        results: List<UserClass>.from(
            json["results"].map((x) => UserClass.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class UserClass {
  UserClass({
    this.id,
    this.auth,
    this.confirmed,
    this.policyagreed,
    this.deleted,
    this.suspended,
    this.mnethostid,
    this.username,
    this.password,
    this.idnumber,
    this.firstname,
    this.lastname,
    this.email,
    this.emailstop,
    this.phone1,
    this.phone2,
    this.institution,
    this.department,
    this.address,
    this.city,
    this.country,
    this.lang,
    this.calendartype,
    this.theme,
    this.timezone,
    this.firstaccess,
    this.lastaccess,
    this.lastlogin,
    this.currentlogin,
    this.lastip,
    this.secret,
    this.picture,
    this.description,
    this.descriptionformat,
    this.mailformat,
    this.maildigest,
    this.maildisplay,
    this.autosubscribe,
    this.trackforums,
    this.timecreated,
    this.timemodified,
    this.trustbitmask,
    this.imagealt,
    this.lastnamephonetic,
    this.firstnamephonetic,
    this.middlename,
    this.alternatename,
    this.moodlenetprofile,
  });

  int? id;
  String? auth;
  int? confirmed;
  int? policyagreed;
  int? deleted;
  int? suspended;
  int? mnethostid;
  String? username;
  String? password;
  String? idnumber;
  String? firstname;
  String? lastname;
  String? email;
  int? emailstop;
  String? phone1;
  String? phone2;
  String? institution;
  String? department;
  String? address;
  String? city;
  String? country;
  String? lang;
  String? calendartype;
  String? theme;
  String? timezone;
  int? firstaccess;
  int? lastaccess;
  int? lastlogin;
  int? currentlogin;
  String? lastip;
  String? secret;
  int? picture;
  String? description;
  int? descriptionformat;
  int? mailformat;
  int? maildigest;
  int? maildisplay;
  int? autosubscribe;
  int? trackforums;
  int? timecreated;
  int? timemodified;
  int? trustbitmask;
  String? alternatename;
  String? imagealt;
  String? lastnamephonetic;
  String? firstnamephonetic;
  String? middlename;
  dynamic moodlenetprofile;

  factory UserClass.fromJson(String str) => UserClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        auth: json["auth"],
        confirmed: json["confirmed"],
        policyagreed: json["policyagreed"],
        deleted: json["deleted"],
        suspended: json["suspended"],
        mnethostid: json["mnethostid"],
        username: json["username"],
        password: json["password"],
        idnumber: json["idnumber"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        emailstop: json["emailstop"],
        phone1: json["phone1"],
        phone2: json["phone2"],
        institution: json["institution"],
        department: json["department"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        lang: json["lang"],
        calendartype: json["calendartype"],
        theme: json["theme"],
        timezone: json["timezone"],
        firstaccess: json["firstaccess"],
        lastaccess: json["lastaccess"],
        lastlogin: json["lastlogin"],
        currentlogin: json["currentlogin"],
        lastip: json["lastip"],
        secret: json["secret"],
        picture: json["picture"],
        description: json["description"],
        descriptionformat: json["descriptionformat"],
        mailformat: json["mailformat"],
        maildigest: json["maildigest"],
        maildisplay: json["maildisplay"],
        autosubscribe: json["autosubscribe"],
        trackforums: json["trackforums"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        trustbitmask: json["trustbitmask"],
        imagealt: json["imagealt"],
        lastnamephonetic: json["lastnamephonetic"],
        firstnamephonetic: json["firstnamephonetic"],
        middlename: json["middlename"],
        alternatename: json["alternatename"],
        moodlenetprofile: json["moodlenetprofile"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "auth": auth,
        "confirmed": confirmed,
        "policyagreed": policyagreed,
        "deleted": deleted,
        "suspended": suspended,
        "mnethostid": mnethostid,
        "username": username,
        "password": password,
        "idnumber": idnumber,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "emailstop": emailstop,
        "phone1": phone1,
        "phone2": phone2,
        "institution": institution,
        "department": department,
        "address": address,
        "city": city,
        "country": country,
        "lang": lang,
        "calendartype": calendartype,
        "theme": theme,
        "timezone": timezone,
        "firstaccess": firstaccess,
        "lastaccess": lastaccess,
        "lastlogin": lastlogin,
        "currentlogin": currentlogin,
        "lastip": lastip,
        "secret": secret,
        "picture": picture,
        "description": description,
        "descriptionformat": descriptionformat,
        "mailformat": mailformat,
        "maildigest": maildigest,
        "maildisplay": maildisplay,
        "autosubscribe": autosubscribe,
        "trackforums": trackforums,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "trustbitmask": trustbitmask,
        "imagealt": imagealt,
        "lastnamephonetic": lastnamephonetic,
        "firstnamephonetic": firstnamephonetic,
        "middlename": middlename,
        "alternatename": alternatename,
        "moodlenetprofile": moodlenetprofile,
      };
}
