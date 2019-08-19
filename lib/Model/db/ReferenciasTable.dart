import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Referencia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AddressTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PhonesTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';

import 'DocumentosTable.dart';

class ReferenciasTable {
  ReferenciasTable._();

  static final ReferenciasTable db = ReferenciasTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newReferencia(Referencia newReferencia) async {
    final db = await database;
    int address = await AddresssTable.db.newAddress(newReferencia.address);
    int phones = await PhonesTable.db.newPhone(newReferencia.phone);
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Referencia");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Referencia (id, idInServer, idAddress, idPhone,nombre, ap_paterno, ap_materno, parentesco, anios, menos_anio, same_address)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newReferencia.idInServer,
          address,
          phones,
          newReferencia.nombre,
          newReferencia.ap_paterno,
          newReferencia.ap_materno,
          newReferencia.parentesco,
          newReferencia.anios,
          newReferencia.menos_anio,
          newReferencia.same_address
        ]);
    return raw;
  }

  updateReferencia(Referencia newReferencia) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id) as id FROM Referencia");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawUpdate(
        "UPDATE Referencia "
        " SET  idInServer = ?,"
        "address  = ?,"
        "phones  = ?,"
        "nombre = ?,"
        "ap_paterno = ?,"
        "ap_materno = ?,"
        "parentesco = ?,"
        "anios = ?,"
        "menos_anio = ?,"
        "same_addres = ?"
        "WHERE id = ?",
        [
          newReferencia.idInServer,
          newReferencia.idAddress,
          newReferencia.idPhone,
          newReferencia.nombre,
          newReferencia.ap_paterno,
          newReferencia.ap_materno,
          newReferencia.parentesco,
          newReferencia.anios,
          newReferencia.menos_anio,
          newReferencia.same_address,
          id
        ]);
    return raw;
  }

  getReferencia(int id) async {
    final db = await database;
    var res = await db.query("Referencia", where: "id = ?", whereArgs: [id]);
    Referencia referencia =
        res.isNotEmpty ? Referencia.fromMap(res.first) : null;
    Address address = await AddresssTable.db.getAddress(1);
    Phone phones = await PhonesTable.db.getPhone(1);
    referencia.address = address;
    referencia.phone = phones;
    return referencia;
  }

  Future<List<Referencia>> getBlockedReferencia() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Referencia WHERE blocked=1");
    var res =
        await db.query("Referencia", where: "blocked = ? ", whereArgs: [1]);

    List<Referencia> list =
        res.isNotEmpty ? res.map((c) => Referencia.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Referencia>> getAllReferencia() async {
    final db = await database;
    var res = await db.query("Referencia");
    List<Referencia> list =
        res.isNotEmpty ? res.map((c) => Referencia.fromMap(c)).toList() : [];
    return list;
  }

  deleteReferencia(int id) async {
    final db = await database;
    return db.delete("Referencia", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Referencia");
  }
}
