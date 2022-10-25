// To parse this JSON data, do
//
//     final tareaCalificacionResponse = tareaCalificacionResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class TareaCalificacionResponse {
  TareaCalificacionResponse({
    this.lastattempt,
    feedback,
    this.warnings,
  });

  Lastattempt? lastattempt;
  Feedback? feedback;
  List<dynamic>? warnings;

  TareaCalificacionResponse tareaCalificacionResponseFromJson(String str) =>
      TareaCalificacionResponse.fromJson(json.decode(str));

  String tareaCalificacionResponseToJson(TareaCalificacionResponse data) =>
      json.encode(data.toJson());

  factory TareaCalificacionResponse.fromJson(Map<String, dynamic> json) =>
      TareaCalificacionResponse(
        lastattempt: Lastattempt.fromJson(json["lastattempt"]),
        //verificar si el feedback es null o no
        feedback: json["feedback"] == null
            ? null
            : Feedback.fromJson(json["feedback"]),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "lastattempt": lastattempt!.toJson(),
        "feedback": feedback!.toJson(),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Feedback {
  Feedback({
    this.grade,
    this.gradefordisplay,
    this.gradeddate,
    this.plugins,
  });

  Grade? grade;
  String? gradefordisplay;
  int? gradeddate;
  List<Plugin>? plugins;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        grade: Grade.fromJson(json["grade"]),
        gradefordisplay: json["gradefordisplay"],
        gradeddate: json["gradeddate"],
        plugins:
            List<Plugin>.from(json["plugins"].map((x) => Plugin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "grade": grade!.toJson(),
        "gradefordisplay": gradefordisplay,
        "gradeddate": gradeddate,
        "plugins": List<dynamic>.from(plugins!.map((x) => x.toJson())),
      };
}

class Grade {
  Grade({
    this.id,
    this.assignment,
    this.userid,
    this.attemptnumber,
    this.timecreated,
    this.timemodified,
    this.grader,
    this.grade,
  });

  int? id;
  int? assignment;
  int? userid;
  int? attemptnumber;
  int? timecreated;
  int? timemodified;
  int? grader;
  String? grade;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        assignment: json["assignment"],
        userid: json["userid"],
        attemptnumber: json["attemptnumber"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        grader: json["grader"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment": assignment,
        "userid": userid,
        "attemptnumber": attemptnumber,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "grader": grader,
        "grade": grade,
      };
}

class Plugin {
  Plugin({
    this.type,
    this.name,
    this.fileareas,
    this.editorfields,
  });

  String? type;
  String? name;
  List<Filearea>? fileareas;
  List<Editorfield>? editorfields;

  factory Plugin.fromJson(Map<String, dynamic> json) => Plugin(
        type: json["type"],
        name: json["name"],
        fileareas: json["fileareas"] == null
            ? null
            : List<Filearea>.from(
                json["fileareas"].map((x) => Filearea.fromJson(x))),
        editorfields: json["editorfields"] == null
            ? null
            : List<Editorfield>.from(
                json["editorfields"].map((x) => Editorfield.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "fileareas": fileareas == null
            ? null
            : List<dynamic>.from(fileareas!.map((x) => x.toJson())),
        "editorfields": editorfields == null
            ? null
            : List<dynamic>.from(editorfields!.map((x) => x.toJson())),
      };
}

class Editorfield {
  Editorfield({
    this.name,
    this.description,
    this.text,
    this.format,
  });

  String? name;
  String? description;
  String? text;
  int? format;

  factory Editorfield.fromJson(Map<String, dynamic> json) => Editorfield(
        name: json["name"],
        description: json["description"],
        text: json["text"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "text": text,
        "format": format,
      };
}

class Filearea {
  Filearea({
    this.area,
    this.files,
  });

  String? area;
  List<FileElement>? files;

  factory Filearea.fromJson(Map<String, dynamic> json) => Filearea(
        area: json["area"],
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    this.filename,
    this.filepath,
    this.filesize,
    this.fileurl,
    this.timemodified,
    this.mimetype,
    this.isexternalfile,
  });

  String? filename;
  String? filepath;
  int? filesize;
  String? fileurl;
  int? timemodified;
  String? mimetype;
  bool? isexternalfile;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        filename: json["filename"],
        filepath: json["filepath"],
        filesize: json["filesize"],
        fileurl: json["fileurl"],
        timemodified: json["timemodified"],
        mimetype: json["mimetype"],
        isexternalfile: json["isexternalfile"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "filepath": filepath,
        "filesize": filesize,
        "fileurl": fileurl,
        "timemodified": timemodified,
        "mimetype": mimetype,
        "isexternalfile": isexternalfile,
      };
}

class Lastattempt {
  Lastattempt({
    this.submission,
    this.submissiongroupmemberswhoneedtosubmit,
    this.submissionsenabled,
    this.locked,
    this.graded,
    this.canedit,
    this.caneditowner,
    this.cansubmit,
    this.extensionduedate,
    this.blindmarking,
    this.gradingstatus,
    this.usergroups,
  });

  Submission? submission;
  List<dynamic>? submissiongroupmemberswhoneedtosubmit;
  bool? submissionsenabled;
  bool? locked;
  bool? graded;
  bool? canedit;
  bool? caneditowner;
  bool? cansubmit;
  int? extensionduedate;
  bool? blindmarking;
  String? gradingstatus;
  List<dynamic>? usergroups;

  factory Lastattempt.fromJson(Map<String, dynamic> json) => Lastattempt(
        submission: Submission.fromJson(json["submission"]),
        submissiongroupmemberswhoneedtosubmit: List<dynamic>.from(
            json["submissiongroupmemberswhoneedtosubmit"].map((x) => x)),
        submissionsenabled: json["submissionsenabled"],
        locked: json["locked"],
        graded: json["graded"],
        canedit: json["canedit"],
        caneditowner: json["caneditowner"],
        cansubmit: json["cansubmit"],
        extensionduedate: json["extensionduedate"],
        blindmarking: json["blindmarking"],
        gradingstatus: json["gradingstatus"],
        usergroups: List<dynamic>.from(json["usergroups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "submission": submission!.toJson(),
        "submissiongroupmemberswhoneedtosubmit": List<dynamic>.from(
            submissiongroupmemberswhoneedtosubmit!.map((x) => x)),
        "submissionsenabled": submissionsenabled,
        "locked": locked,
        "graded": graded,
        "canedit": canedit,
        "caneditowner": caneditowner,
        "cansubmit": cansubmit,
        "extensionduedate": extensionduedate,
        "blindmarking": blindmarking,
        "gradingstatus": gradingstatus,
        "usergroups": List<dynamic>.from(usergroups!.map((x) => x)),
      };
}

class Submission {
  Submission({
    this.id,
    this.userid,
    this.attemptnumber,
    this.timecreated,
    this.timemodified,
    this.status,
    this.groupid,
    this.assignment,
    this.latest,
    this.plugins,
  });

  int? id;
  int? userid;
  int? attemptnumber;
  int? timecreated;
  int? timemodified;
  String? status;
  int? groupid;
  int? assignment;
  int? latest;
  List<Plugin>? plugins;

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["id"],
        userid: json["userid"],
        attemptnumber: json["attemptnumber"],
        timecreated: json["timecreated"],
        timemodified: json["timemodified"],
        status: json["status"],
        groupid: json["groupid"],
        assignment: json["assignment"],
        latest: json["latest"],
        plugins:
            List<Plugin>.from(json["plugins"].map((x) => Plugin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "attemptnumber": attemptnumber,
        "timecreated": timecreated,
        "timemodified": timemodified,
        "status": status,
        "groupid": groupid,
        "assignment": assignment,
        "latest": latest,
        "plugins": List<dynamic>.from(plugins!.map((x) => x.toJson())),
      };
}
