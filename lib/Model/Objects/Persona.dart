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
  int idPhone;
  String nombre;
  String ap_paterno;
  String ap_materno;
  String email;
  String escolaridad;
  String gender;
  String estado_civil;
  String ocupacion;
  String tipo_ocupacion;
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
    this.idPhone,
    this.nombre,
    this.ap_paterno,
    this.ap_materno,
    this.email,
    this.escolaridad,
    this.gender,
    this.estado_civil,
    this.ocupacion,
    this.tipo_ocupacion,
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
    idPhone: json["idPhone"],
    nombre: json["nombre"],
    ap_paterno: json["ap_paterno"],
    ap_materno: json["ap_materno"],
    email: json["email"],
    escolaridad: json["escolaridad"],
    gender: json["gender"],
    estado_civil: json["estado_civil"],
    ocupacion: json["ocupacion"],
    tipo_ocupacion: json["tipo_ocupacion"],
    fecha_de_nacimiento: json["fecha_de_nacimiento"],
    curp: json["curp"],
    rfc: json["rfc"],
    address: json["address"],
    phone: json["phone"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idInServer": idInServer,
    "idPhone": idPhone,
    "nombre": nombre,
    "ap_paterno": ap_paterno,
    "ap_materno": ap_materno,
    "email": email,
    "escolaridad": escolaridad,
    "gender": gender,
    "estado_civil": estado_civil,
    "ocupacion": ocupacion,
    "tipo_ocupacion": tipo_ocupacion,
    "fecha_de_nacimiento": fecha_de_nacimiento,
    "curp": curp,
    "rfc": rfc,
    "address": address,
    "phone": phone,
  };
}