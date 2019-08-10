import 'dart:convert';

Phone phoneromJson(String str) {
  final jsonData = json.decode(str);
  return Phone.fromMap(jsonData);
}

String phoneoJson(Phone data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Phone {
  int id;
  String numero;
  int id_persona;
  String tipo;

  Phone({
    this.id,
    this.numero,
    this.id_persona,
    this.tipo
  });

  factory Phone.fromMap(Map<String, dynamic> json) => new Phone(
    id: json["id"],
    numero: json["numero"],
    id_persona: json["id_persona"],
    tipo: json["tipo"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "numero": numero,
    "id_persona": id_persona,
    "tipo": tipo
  };
}