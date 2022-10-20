// To parse this JSON data, do
//
//     final responseBanner = responseBannerFromMap(jsonString);

import 'dart:convert';

class ResponseBanner {
  ResponseBanner({
    this.ok,
    this.results,
  });

  bool? ok;
  List<Result>? results;

  factory ResponseBanner.fromJson(String str) =>
      ResponseBanner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseBanner.fromMap(Map<String, dynamic> json) => ResponseBanner(
        ok: json["ok"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.src,
    this.url,
  });

  int? id;
  String? src;
  String? url;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        src: json["src"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "src": src,
        "url": url,
      };
}
