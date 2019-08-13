import 'package:fiinsoft_autoenrolamiento/Model/Objects/Egreso.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class EgresosTable{
  EgresosTable._();

  static final EgresosTable db = EgresosTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newEgreso(Egreso newEgreso) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Egreso");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Egreso (id, concepto ,monto_mensual)"
            " VALUES (?,?,?)",
        [id, newEgreso.concepto, newEgreso.monto_mensual]);
    return raw;
  }

  blockOrUnblock(Egreso egreso) async {
    final db = await database;
    Egreso blocked = Egreso(
      id: egreso.id,
      concepto: egreso.concepto,
      monto_mensual: egreso.monto_mensual,
    );
    var res = await db.update("Egreso", blocked.toMap(),
        where: "id = ?", whereArgs: [egreso.id]);
    return res;
  }

  updateEgreso(Egreso newEgreso) async {
    final db = await database;
    var res = await db.update("Egreso", newEgreso.toMap(),
        where: "id = ?", whereArgs: [newEgreso.id]);
    return res;
  }

  getEgreso(int id) async {
    final db = await database;
    var res = await db.query("Egreso", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Egreso.fromMap(res.first) : null;
  }

  Future<List<Egreso>> getBlockedEgresos() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Egreso WHERE blocked=1");
    var res = await db.query("Egreso", where: "blocked = ? ", whereArgs: [1]);

    List<Egreso> list =
    res.isNotEmpty ? res.map((c) => Egreso.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Egreso>> getAllEgresos() async {
    final db = await database;
    var res = await db.query("Egreso");
    List<Egreso> list =
    res.isNotEmpty ? res.map((c) => Egreso.fromMap(c)).toList() : [];
    return list;
  }

  deleteEgreso(int id) async {
    final db = await database;
    return db.delete("Egreso", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Egreso");
  }
}