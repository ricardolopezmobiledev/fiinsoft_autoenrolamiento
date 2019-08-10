import 'dart:convert';

Address addressFromJson(String str) {
  final jsonData = json.decode(str);
  return Address.fromMap(jsonData);
}

String addressToJson(Address data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Address {
  int id;
  String cp;
  String ciudad;
  String municipio;
  String estado;
  String colonia;
  String calle;
  String num_exterior;
  String num_interior;

  Address({
    this.id,
    this.cp,
    this.ciudad,
    this.municipio,
    this.estado,
    this.colonia,
    this.calle,
    this.num_exterior,
    this.num_interior,
  });

  factory Address.fromMap(Map<String, dynamic> json) => new Address(
    id: json["id"],
    cp: json["cp"],
    ciudad: json["ciudad"],
    municipio: json["municipio"],
    estado: json["estado"],
    colonia: json["colonia"],
    calle: json["calle"],
    num_exterior: json["num_exterior"],
    num_interior: json["num_interior"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cp": cp,
    "ciudad": ciudad,
    "municipio": municipio,
    "estado": estado,
    "colonia": colonia,
    "calle": calle,
    "num_exterior": num_exterior,
    "num_interior": num_interior,
  };
}