import 'dart:convert';

class UserUpdate {
  UserUpdate({
    this.email,
    this.phone1,
  });

  String? email;
  String? phone1;

  factory UserUpdate.fromRawJson(String str) =>
      UserUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserUpdate.fromJson(Map<String, dynamic> json) => UserUpdate(
        email: json["email"],
        phone1: json["phone1"],
      );

  Map<String, dynamic> toJson() => {
        'json': {
          "email": email,
          "phone1": phone1,
        }
      };

  // Map<dynamic,dynamic>toMap() => {'json': {"email": email, "phone1": phone1}},

  //    Map data = {
  //   'json': '{"email":"$email","phone1":"$phone1"}',
  // };
}
