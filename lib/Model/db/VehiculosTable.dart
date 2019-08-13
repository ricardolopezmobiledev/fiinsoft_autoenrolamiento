import 'package:fiinsoft_autoenrolamiento/Model/Objects/Vehiculo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class VehiculosTable{
  VehiculosTable._();

  static final VehiculosTable db = VehiculosTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newVehiculo(Vehiculo newVehiculo) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Vehiculo");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Vehiculo (id, marca, modelo, anio)"
            " VALUES (?,?,?,?)",
        [id, newVehiculo.marca, newVehiculo.modelo, newVehiculo.anio]);
    return raw;
  }

  blockOrUnblock(Vehiculo vehiculo) async {
    final db = await database;
    Vehiculo blocked = Vehiculo(
        id: vehiculo.id,
        marca: vehiculo.marca,
        modelo: vehiculo.modelo,
        anio: vehiculo.anio
    );
    var res = await db.update("Vehiculo", blocked.toMap(),
        where: "id = ?", whereArgs: [vehiculo.id]);
    return res;
  }

  updateVehiculo(Vehiculo newVehiculo) async {
    final db = await database;
    var res = await db.update("Vehiculo", newVehiculo.toMap(),
        where: "id = ?", whereArgs: [newVehiculo.id]);
    return res;
  }

  getVehiculo(int id) async {
    final db = await database;
    var res = await db.query("Vehiculo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Vehiculo.fromMap(res.first) : null;
  }

  Future<List<Vehiculo>> getBlockedVehiculos() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Vehiculo WHERE blocked=1");
    var res = await db.query("Vehiculo", where: "blocked = ? ", whereArgs: [1]);

    List<Vehiculo> list =
    res.isNotEmpty ? res.map((c) => Vehiculo.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Vehiculo>> getAllVehiculos() async {
    final db = await database;
    var res = await db.query("Vehiculo");
    List<Vehiculo> list =
    res.isNotEmpty ? res.map((c) => Vehiculo.fromMap(c)).toList() : [];
    return list;
  }

  deleteVehiculo(int id) async {
    final db = await database;
    return db.delete("Vehiculo", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Vehiculo");
  }
}