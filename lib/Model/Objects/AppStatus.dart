import 'dart:convert';

AppStatus appStatusFromJson(String str) {
  final jsonData = json.decode(str);
  return AppStatus.fromMap(jsonData);
}

String appStatusToJson(AppStatus data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class AppStatus {
  int id;
  int id_status;
  String name;

  AppStatus({
    this.id,
    this.id_status,
    this.name
  });

  factory AppStatus.fromMap(Map<String, dynamic> json) => new AppStatus(
    id: json["id"],
    id_status: json["id_status"],
    name: json["name"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "id_status": id_status,
    "name": name
  };
}