import 'package:fiinsoft_autoenrolamiento/Model/Objects/Trabajo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AddressTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PhonesTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';


class TrabajoTable {
  TrabajoTable._();

  static final TrabajoTable db = TrabajoTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newTrabajo(Trabajo newTrabajo) async {
    final db = await database;
    int address = await AddresssTable.db.newAddress(newTrabajo.address);
    int phones = await PhonesTable.db.newPhone(newTrabajo.phone);
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Trabajo");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Trabajo (id, idInServer, id_persona, empresa, puesto, sueldo, menos_anio, antiguedad, phone, address)"
            " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newTrabajo.idInServer,
          newTrabajo.id_persona,
          newTrabajo.empresa,
          newTrabajo.puesto,
          newTrabajo.sueldo,
          newTrabajo.menos_anio,
          newTrabajo.antiguedad,
          phones,
          address
        ]);
    return raw;
  }

  blockOrUnblock(Trabajo trabajo) async {
    final db = await database;
    Trabajo blocked = Trabajo(
        id: trabajo.id,
        idInServer: trabajo.idInServer,
        id_persona: trabajo.id_persona,
        empresa: trabajo.empresa,
        puesto: trabajo.puesto,
        sueldo: trabajo.sueldo,
        menos_anio: trabajo.menos_anio,
        antiguedad: trabajo.antiguedad,
        phone: trabajo.phone,
        address: trabajo.address,
    );
    var res = await db.update("Trabajo", blocked.toMap(),
        where: "id = ?", whereArgs: [trabajo.id]);
    return res;
  }

  updateTrabajo(Trabajo newTrabajo) async {
    final db = await database;
    //get the biggest id in the table
    await PhonesTable.db.updatePhone(newTrabajo.phone);
    await AddresssTable.db.updateAddress(newTrabajo.address);

    //insert to the table using the new id
    var raw = await db.rawUpdate(
        "UPDATE Trabajo "
        "SET idInServer = ?,"
        "id_persona  = ?,"
        "empresa  = ?,"
        "puesto  = ?,"
        "sueldo  = ?,"
        "menos_anio  = ?,"
        "antiguedad  = ?,"
        "phone  = ?,"
        "address  = ?"
        "WHERE id = ?",
        [
          newTrabajo.idInServer,
          newTrabajo.id_persona,
          newTrabajo.empresa,
          newTrabajo.puesto,
          newTrabajo.sueldo,
          newTrabajo.menos_anio,
          newTrabajo.antiguedad,
          newTrabajo.phone.id,
          newTrabajo.address.id,
          newTrabajo.id
        ]);
    return raw;
  }

  getTrabajo(int id) async {
    final db = await database;
    var res = await db.query("Trabajo", where: "id = ?", whereArgs: [id]);
    Trabajo trabajo = res.isNotEmpty ? Trabajo.fromMap(res.first) : null;
    if(trabajo != null){
      Address address = await AddresssTable.db.getAddress(trabajo.idAddress);
      Phone phones = await PhonesTable.db.getPhone(trabajo.idPhone);
      trabajo.address = address;
      trabajo.phone = phones;
    }
    return trabajo;
  }

  Future<List<Trabajo>> getBlockedTrabajo() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Trabajo WHERE blocked=1");
    var res = await db.query("Trabajo", where: "blocked = ? ", whereArgs: [1]);

    List<Trabajo> list =
    res.isNotEmpty ? res.map((c) => Trabajo.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Trabajo>> getAllTrabajo() async {
    final db = await database;
    var res = await db.query("Trabajo");
    List<Trabajo> list =
    res.isNotEmpty ? res.map((c) => Trabajo.fromMap(c)).toList() : [];
    return list;
  }

  deleteTrabajo(int id) async {
    final db = await database;
    return db.delete("Trabajo", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Trabajo");
  }
}
