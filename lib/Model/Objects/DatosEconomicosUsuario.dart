import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';

DatosEconomicosUsuario datosEconomicosUsuarioFromJson(String str) {
  final jsonData = json.decode(str);
  return DatosEconomicosUsuario.fromMap(jsonData);
}

String datosEconomicosUsuarioToJson(DatosEconomicosUsuario data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class DatosEconomicosUsuario {
  int id;
  int idInServer;
  int id_persona;
  String tipo_vivienda;
  String valor_vivienda;
  int habitantes;
  bool menos_anio;
  int anios;
  bool mas_una_propiedad;

  DatosEconomicosUsuario(
      {this.id,
      this.idInServer,
      this.id_persona,
      this.tipo_vivienda,
      this.valor_vivienda,
      this.habitantes,
      this.menos_anio,
      this.anios,
      this.mas_una_propiedad});

  factory DatosEconomicosUsuario.fromMap(Map<String, dynamic> json) =>
      new DatosEconomicosUsuario(
        id: json["id"],
        idInServer: json["idInServer"],
        id_persona: json["id_persona"],
        tipo_vivienda: json["tipo_vivienda"],
        valor_vivienda: json["valor_vivienda"],
        habitantes: json["habitantes"],
        menos_anio: (json["menos_anio"] == 1) ? true:false,
        anios: json["anios"],
        mas_una_propiedad: (json["mas_una_propiedad"] == 1) ? true:false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idInServer": idInServer,
        "id_persona": id_persona,
        "tipo_vivienda": tipo_vivienda,
        "valor_vivienda": valor_vivienda,
        "habitantes": habitantes,
        "menos_anio": menos_anio,
        "anios": anios,
        "mas_una_propiedad": mas_una_propiedad,
      };
}
