// To parse this JSON data, do
//
//     final notificacion = notificacionFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:campus_virtual/models/PostNotificaciones.dart';

class NotificacionResponse {
  NotificacionResponse({
    this.notifications,
    this.unreadcount,
  });

  List<PostNotificaciones>? notifications;
  int? unreadcount;

  factory NotificacionResponse.fromJson(String str) =>
      NotificacionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificacionResponse.fromMap(Map<String, dynamic> json) =>
      NotificacionResponse(
        notifications: List<PostNotificaciones>.from(
            json["notifications"].map((x) => PostNotificaciones.fromMap(x))),
        unreadcount: json["unreadcount"],
      );

  Map<String, dynamic> toMap() => {
        "notifications":
            List<PostNotificaciones>.from(notifications!.map((x) => x.toMap())),
        "unreadcount": unreadcount,
      };
}
