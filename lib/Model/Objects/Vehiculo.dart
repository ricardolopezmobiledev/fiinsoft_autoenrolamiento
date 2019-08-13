import 'dart:convert';

Vehiculo vehiculoFromJson(String str) {
  final jsonData = json.decode(str);
  return Vehiculo.fromMap(jsonData);
}

String vehiculoToJson(Vehiculo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Vehiculo {
  int id;
  String marca;
  String modelo;
  String anio;

  Vehiculo({
    this.id,
    this.marca,
    this.modelo,
    this.anio,
  });

  factory Vehiculo.fromMap(Map<String, dynamic> json) => new Vehiculo(
    id: json["id"],
    marca: json["marca"],
    modelo: json["modelo"],
    anio: json["anio"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "marca": marca,
    "modelo": modelo,
    "anio": anio,
  };
}