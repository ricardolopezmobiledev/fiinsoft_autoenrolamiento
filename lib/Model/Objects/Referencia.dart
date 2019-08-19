import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';

Referencia referenciaFromJson(String str) {
  final jsonData = json.decode(str);
  return Referencia.fromMap(jsonData);
}

String referenciaToJson(Referencia data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Referencia {
  int id;
  int idInServer;
  int idAddress;
  int idPhone;
  String nombre;
  String ap_paterno;
  String ap_materno;
  String parentesco;
  Address address;
  Phone phone;
  int anios;
  bool menos_anio;
  bool same_address;

  Referencia({
    this.id,
    this.idInServer,
    this.idAddress,
    this.idPhone,
    this.nombre,
    this.ap_paterno,
    this.ap_materno,
    this.parentesco,
    this.address,
    this.phone,
    this.anios,
    this.menos_anio,
    this.same_address,
  });

  factory Referencia.fromMap(Map<String, dynamic> json) => new Referencia(
    id: json["id"],
    idInServer: json["idInServer"],
    idAddress: json["idAddress"],
    idPhone: json["idPhone"],
    nombre: json["nombre"],
    ap_paterno: json["ap_paterno"],
    ap_materno: json["ap_materno"],
    parentesco: json["parentesco"],
    anios: json["anios"],
    menos_anio: (json["menos_anio"] == 1) ? true:false,
    same_address: (json["same_address"] == 1) ? true:false,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idInServer": idInServer,
    "idAddress": idAddress,
    "idPhone": idPhone,
    "nombre": nombre,
    "ap_paterno": ap_paterno,
    "ap_materno": ap_materno,
    "parentesco": parentesco,
    "anios": anios,
    "menos_anio": menos_anio,
    "same_address": same_address,
  };
}
