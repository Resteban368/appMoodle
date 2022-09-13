// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'dart:convert';

class InfoSiteUser {
  InfoSiteUser({
    this.sitename,
    this.username,
    this.firstname,
    this.lastname,
    this.fullname,
    this.lang,
    this.userid,
    this.siteurl,
    this.userpictureurl,
    this.downloadfiles,
    this.uploadfiles,
    this.release,
    this.version,
    this.mobilecssurl,
    this.usercanmanageownfiles,
    this.userquota,
    this.usermaxuploadfilesize,
    this.userhomepage,
    this.userprivateaccesskey,
    this.siteid,
    this.sitecalendartype,
    this.usercalendartype,
    this.userissiteadmin,
    this.theme,
  });

  String? sitename;
  String? username;
  String? firstname;
  String? lastname;
  String? fullname;
  String? lang;
  int? userid;
  String? siteurl;
  String? userpictureurl;
  int? downloadfiles;
  int? uploadfiles;
  String? release;
  String? version;
  String? mobilecssurl;
  bool? usercanmanageownfiles;
  int? userquota;
  int? usermaxuploadfilesize;
  int? userhomepage;
  String? userprivateaccesskey;
  int? siteid;
  String? sitecalendartype;
  String? usercalendartype;
  bool? userissiteadmin;
  String? theme;

  factory InfoSiteUser.fromJson(String str) =>
      InfoSiteUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoSiteUser.fromMap(Map<String, dynamic> json) => InfoSiteUser(
        sitename: json["sitename"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        fullname: json["fullname"],
        lang: json["lang"],
        userid: json["userid"],
        siteurl: json["siteurl"],
        userpictureurl: json["userpictureurl"],
        downloadfiles: json["downloadfiles"],
        uploadfiles: json["uploadfiles"],
        release: json["release"],
        version: json["version"],
        mobilecssurl: json["mobilecssurl"],
        usercanmanageownfiles: json["usercanmanageownfiles"],
        userquota: json["userquota"],
        usermaxuploadfilesize: json["usermaxuploadfilesize"],
        userhomepage: json["userhomepage"],
        userprivateaccesskey: json["userprivateaccesskey"],
        siteid: json["siteid"],
        sitecalendartype: json["sitecalendartype"],
        usercalendartype: json["usercalendartype"],
        userissiteadmin: json["userissiteadmin"],
        theme: json["theme"],
      );

  Map<String, dynamic> toMap() => {
        "sitename": sitename,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "fullname": fullname,
        "lang": lang,
        "userid": userid,
        "siteurl": siteurl,
        "userpictureurl": userpictureurl,
        "downloadfiles": downloadfiles,
        "uploadfiles": uploadfiles,
        "release": release,
        "version": version,
        "mobilecssurl": mobilecssurl,
        "usercanmanageownfiles": usercanmanageownfiles,
        "userquota": userquota,
        "usermaxuploadfilesize": usermaxuploadfilesize,
        "userhomepage": userhomepage,
        "userprivateaccesskey": userprivateaccesskey,
        "siteid": siteid,
        "sitecalendartype": sitecalendartype,
        "usercalendartype": usercalendartype,
        "userissiteadmin": userissiteadmin,
        "theme": theme,
      };
}
