// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<SearchResponse> searchResponseFromJson(String str) =>
    List<SearchResponse>.from(
        json.decode(str).map((x) => SearchResponse.fromJson(x)));

String searchResponseToJson(List<SearchResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResponse {
  SearchResponse({
    this.id,
    this.fullname,
    this.profileimageurl,
    this.profileimageurlsmall,
  });

  int? id;
  String? fullname;
  String? profileimageurl;
  String? profileimageurlsmall;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        id: json["id"],
        fullname: json["fullname"],
        profileimageurl: json["profileimageurl"],
        profileimageurlsmall: json["profileimageurlsmall"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "profileimageurl": profileimageurl,
        "profileimageurlsmall": profileimageurlsmall,
      };
}
