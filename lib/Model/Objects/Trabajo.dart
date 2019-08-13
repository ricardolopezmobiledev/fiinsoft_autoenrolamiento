import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';

Trabajo trabajoFromJson(String str) {
  final jsonData = json.decode(str);
  return Trabajo.fromMap(jsonData);
}

String trabajoToJson(Trabajo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Trabajo {
  int id;
  int idInServer;
  int id_persona;
  String empresa;
  String puesto;
  String sueldo;
  bool menos_anio;
  int antiguedad;
  Phone phone;
  Address address;
  int idAddress;
  int idPhone;

  Trabajo({
    this.id,
    this.idInServer,
    this.id_persona,
    this.empresa,
    this.puesto,
    this.sueldo,
    this.menos_anio,
    this.antiguedad,
    this.phone,
    this.address,
    this.idAddress,
    this.idPhone
  });

  factory Trabajo.fromMap(Map<String, dynamic> json) => new Trabajo(
    id: json["id"],
    idInServer: json["idInServer"],
    id_persona: json["id_persona"],
    empresa: json["empresa"],
    puesto: json["puesto"],
    sueldo: json["sueldo"],
    menos_anio: (json["menos_anio"]  == 1) ? true : false,
    antiguedad: json["antiguedad"],
    idAddress: json["address"],
    idPhone: json["phone"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idInServer": idInServer,
    "id_persona":id_persona,
    "empresa":empresa,
    "puesto":puesto,
    "sueldo":sueldo,
    "menos_anio":(menos_anio  == 1) ? true : false ,
    "antiguedad":antiguedad,
    "idAddress":phone,
    "idPhone":address
  };
}