import 'dart:convert';

Documento documentoFromJson(String str) {
  final jsonData = json.decode(str);
  return Documento.fromMap(jsonData);
}

String documentoToJson(Documento data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Documento {
  int id;
  String nombre;
  int id_persona;
  String status;
  String path;

  Documento({
    this.id,
    this.nombre,
    this.id_persona,
    this.status,
    this.path,
  });

  factory Documento.fromMap(Map<String, dynamic> json) => new Documento(
    id: json["id"],
    nombre: json["nombre"],
    id_persona: json["id_persona"],
    status: json["status"],
    path: json["path"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "id_persona": id_persona,
    "status": status,
    "path": path,
  };

}