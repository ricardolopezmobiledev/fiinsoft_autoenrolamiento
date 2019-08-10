import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';

Persona personaFromJson(String str) {
  final jsonData = json.decode(str);
  return Persona.fromMap(jsonData);
}

String personaToJson(Persona data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Persona {
  int id;
  int idInServer;
  int idAddress;
  String nombre;
  String ap_paterno;
  String ap_materno;
  String fecha_de_nacimiento;
  String curp;
  String rfc;
  Address address;
  Phone phone;
  bool hasExperience;
  bool isCollaborator;
  bool hasDangerousWork;
  List<Documento> documentos = new List();

  Persona({
    this.id,
    this.idInServer,
    this.idAddress,
    this.nombre,
    this.ap_paterno,
    this.ap_materno,
    this.fecha_de_nacimiento,
    this.curp,
    this.rfc,
    this.address,
    this.phone,
  });

  factory Persona.fromMap(Map<String, dynamic> json) => new Persona(
    id: json["id"],
    idInServer: json["idInServer"],
    idAddress: json["idAddress"],
    nombre: json["nombre"],
    ap_paterno: json["ap_paterno"],
    ap_materno: json["ap_materno"],
    fecha_de_nacimiento: json["fecha_de_nacimiento"],
    curp: json["curp"],
    rfc: json["rfc"],
    address: json["address"],
    phone: json["phone"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idInServer": idInServer,
    "idAddress": idAddress,
    "nombre": nombre,
    "ap_paterno": ap_paterno,
    "ap_materno": ap_materno,
    "fecha_de_nacimiento": fecha_de_nacimiento,
    "curp": curp,
    "rfc": rfc,
    "address": address,
    "phone": phone,
  };
}