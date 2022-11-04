// To parse this JSON data, do
//
//     final fecahResponse = fecahResponseFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class FecahResponse {
  FecahResponse({
    this.ok,
    this.fechaActual,
  });

  bool? ok;
  String? fechaActual;

  factory FecahResponse.fromJson(String str) =>
      FecahResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FecahResponse.fromMap(Map<String, dynamic> json) => FecahResponse(
        ok: json["ok"],
        fechaActual: json["fechaActual"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "fechaActual": fechaActual,
      };
}
