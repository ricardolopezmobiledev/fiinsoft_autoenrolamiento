import 'dart:convert';

Egreso egresoFromJson(String str) {
  final jsonData = json.decode(str);
  return Egreso.fromMap(jsonData);
}

String egresoToJson(Egreso data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Egreso {
  int id;
  String concepto;
  String monto_mensual;

  Egreso({
    this.id,
    this.concepto,
    this.monto_mensual,
  });

  factory Egreso.fromMap(Map<String, dynamic> json) => new Egreso(
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