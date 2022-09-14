// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.code,
    this.status,
    this.user,
  });

  int? code;
  String? status;
  UserClass? user;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        status: json["status"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "user": user!.toJson(),
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
    this.icq,
    this.skype,
    this.yahoo,
    this.aim,
    this.msn,
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
  String? imagealt;
  String? lastnamephonetic;
  String? firstnamephonetic;
  String? middlename;
  String? alternatename;
  dynamic moodlenetprofile;
  dynamic icq;
  String? skype;
  String? yahoo;
  String? aim;
  String? msn;

  factory UserClass.fromRawJson(String str) =>
      UserClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
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
        icq: json["icq"],
        skype: json["skype"],
        yahoo: json["yahoo"],
        aim: json["aim"],
        msn: json["msn"],
      );

  Map<String, dynamic> toJson() => {
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
        "icq": icq,
        "skype": skype,
        "yahoo": yahoo,
        "aim": aim,
        "msn": msn,
      };
}
