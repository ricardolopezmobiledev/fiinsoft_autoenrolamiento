import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Persona.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AddressTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PhonesTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';

import 'DocumentosTable.dart';

class PersonaTable {
  PersonaTable._();

  static final PersonaTable db = PersonaTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newPersona(Persona newPersona) async {
    final db = await database;
    int address = await AddresssTable.db.newAddress(newPersona.address);
    int phones;
    if(newPersona.phone != null){
       phones = await PhonesTable.db.newPhone(newPersona.phone);
    }
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Persona");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Persona (id, idInServer, idAddress, idPhone, nombre, ap_paterno, ap_materno, fecha_de_nacimiento, curp, rfc)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newPersona.idInServer,
          address,
          phones,
          newPersona.nombre,
          newPersona.ap_paterno,
          newPersona.ap_materno,
          newPersona.fecha_de_nacimiento,
          newPersona.curp,
          newPersona.rfc
        ]);
    return raw;
  }

  blockOrUnblock(Persona persona) async {
    final db = await database;
    Persona blocked = Persona(
        id: persona.id,
        idInServer: persona.idInServer,
        idAddress: persona.idAddress,
        idPhone: persona.idPhone,
        nombre: persona.nombre,
        ap_paterno: persona.ap_paterno,
        ap_materno: persona.ap_materno,
        fecha_de_nacimiento: persona.fecha_de_nacimiento,
        curp: persona.curp,
        rfc: persona.rfc);
    var res = await db.update("Persona", blocked.toMap(),
        where: "id = ?", whereArgs: [persona.id]);
    return res;
  }

  updatePersona(Persona newPersona) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id) as id FROM Persona");
    int id = newPersona.id;
    //insert to the table using the new id
    var raw = await db.rawUpdate(
        "UPDATE Persona "
        "SET idInServer = ?,"
        "idAddress = ?,"
        "idPhone = ?,"
        "nombre = ?,"
        "ap_paterno = ?,"
        "ap_materno = ?,"
        "email = ?,"
        "escolaridad = ?,"
        "gender = ?,"
        "estado_civil = ?,"
        "ocupacion = ?,"
        "tipo_ocupacion = ?,"
        "fecha_de_nacimiento = ?,"
        "curp = ?,"
        "rfc = ? "
        "WHERE id = ?",
        [
          newPersona.idInServer,
          newPersona.idAddress,
          newPersona.idPhone,
          newPersona.nombre,
          newPersona.ap_paterno,
          newPersona.ap_materno,
          newPersona.email,
          newPersona.escolaridad,
          newPersona.gender,
          newPersona.estado_civil,
          newPersona.ocupacion,
          newPersona.tipo_ocupacion,
          newPersona.fecha_de_nacimiento,
          newPersona.curp,
          newPersona.rfc,
          id
        ]);
    return raw;
  }

  getPersona(int id) async {
    final db = await database;
    var res = await db.query("Persona", where: "id = ?", whereArgs: [id]);
    Persona persona = res.isNotEmpty ? Persona.fromMap(res.first) : null;
    Address address = await AddresssTable.db.getAddress(persona.idAddress);
    List<Documento> documentos = await DocumentoTable.db.getAllDocumento();
    List<Documento> documentosList = new List();
    for (Documento documento in documentos) {
      if (documento.id_persona == persona.id) {
        documentosList.add(documento);
      }
    }
    Phone phones = await PhonesTable.db.getPhone(persona.idPhone);
    persona.documentos = documentosList;
    persona.address = address;
    persona.phone = phones;
    return persona;
  }

  Future<List<Persona>> getBlockedPersona() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Persona WHERE blocked=1");
    var res = await db.query("Persona", where: "blocked = ? ", whereArgs: [1]);

    List<Persona> list =
        res.isNotEmpty ? res.map((c) => Persona.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Persona>> getAllPersona() async {
    final db = await database;
    var res = await db.query("Persona");
    List<Persona> list =
        res.isNotEmpty ? res.map((c) => Persona.fromMap(c)).toList() : [];
    return list;
  }

  deletePersona(int id) async {
    final db = await database;
    return db.delete("Persona", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Persona");
  }
}
