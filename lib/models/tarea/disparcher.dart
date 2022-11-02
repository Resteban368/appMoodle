// To parse this JSON data, do
//
//     final fecahResponse = fecahResponseFromMap(jsonString);

import 'dart:convert';

class FecahResponse {
  FecahResponse({
    this.ok,
    this.results,
  });

  bool? ok;
  List<Disparcher>? results;

  factory FecahResponse.fromJson(String str) =>
      FecahResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FecahResponse.fromMap(Map<String, dynamic> json) => FecahResponse(
        ok: json["ok"],
        results: List<Disparcher>.from(
            json["results"].map((x) => Disparcher.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class Disparcher {
  Disparcher({
    this.id,
    this.tareas,
    this.src,
  });

  int? id;
  int? tareas;
  String? src;

  factory Disparcher.fromJson(String str) =>
      Disparcher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Disparcher.fromMap(Map<String, dynamic> json) => Disparcher(
        id: json["ID"],
        tareas: json["TAREAS"],
        src: json["SRC"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "TAREAS": tareas,
        "SRC": src,
      };
}
