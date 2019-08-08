import 'dart:convert';

Session sessionFromJson(String str) {
  final jsonData = json.decode(str);
  return Session.fromMap(jsonData);
}

String sessionToJson(Session data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Session {
  int id;
  int id_persona;
  String token;
  String email;
  String fullName;
  bool isLoggedIn;

  Session({
    this.id,
    this.id_persona,
    this.token,
    this.email,
    this.fullName,
    this.isLoggedIn,
  });

  factory Session.fromMap(Map<String, dynamic> json) => new Session(
    id: json["id"],
    id_persona: json["id_persona"],
    token: json["token"],
    email: json["email"],
    fullName: json["full_name"],
    isLoggedIn: json["is_logged_in"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "id_persona": id_persona,
    "token": token,
    "email": email,
    "full_name": fullName,
    "is_logged_in": isLoggedIn,
  };
}