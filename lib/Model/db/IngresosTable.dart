import 'package:fiinsoft_autoenrolamiento/Model/Objects/Ingreso.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class IngresosTable{
  IngresosTable._();

  static final IngresosTable db = IngresosTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newIngreso(Ingreso newIngreso) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Ingreso");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Ingreso (id, concepto, monto_mensual)"
            " VALUES (?,?,?)",
        [id, newIngreso.concepto, newIngreso.monto_mensual]);
    return raw;
  }

  blockOrUnblock(Ingreso ingreso) async {
    final db = await database;
    Ingreso blocked = Ingreso(
        id: ingreso.id,
        concepto: ingreso.concepto,
        monto_mensual: ingreso.monto_mensual,
    );
    var res = await db.update("Ingreso", blocked.toMap(),
        where: "id = ?", whereArgs: [ingreso.id]);
    return res;
  }

  updateIngreso(Ingreso newIngreso) async {
    final db = await database;
    var res = await db.update("Ingreso", newIngreso.toMap(),
        where: "id = ?", whereArgs: [newIngreso.id]);
    return res;
  }

  getIngreso(int id) async {
    final db = await database;
    var res = await db.query("Ingreso", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Ingreso.fromMap(res.first) : null;
  }

  Future<List<Ingreso>> getBlockedIngresos() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Ingreso WHERE blocked=1");
    var res = await db.query("Ingreso", where: "blocked = ? ", whereArgs: [1]);

    List<Ingreso> list =
    res.isNotEmpty ? res.map((c) => Ingreso.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Ingreso>> getAllIngresos() async {
    final db = await database;
    var res = await db.query("Ingreso");
    List<Ingreso> list =
    res.isNotEmpty ? res.map((c) => Ingreso.fromMap(c)).toList() : [];
    return list;
  }

  deleteIngreso(int id) async {
    final db = await database;
    return db.delete("Ingreso", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Ingreso");
  }
}