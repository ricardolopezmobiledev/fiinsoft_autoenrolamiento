import 'dart:convert';

Ingreso ingresoFromJson(String str) {
  final jsonData = json.decode(str);
  return Ingreso.fromMap(jsonData);
}

String ingresoToJson(Ingreso data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Ingreso {
  int id;
  String concepto;
  String monto_mensual;

  Ingreso({
    this.id,
    this.concepto,
    this.monto_mensual,
  });

  factory Ingreso.fromMap(Map<String, dynamic> json) => new Ingreso(
    id: json["id"],
    concepto: json["concepto"],
    monto_mensual: json["monto_mensual"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "concepto": concepto,
    "monto_mensual": monto_mensual,
  };
}