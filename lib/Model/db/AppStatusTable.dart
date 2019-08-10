import 'package:fiinsoft_autoenrolamiento/Model/Objects/AppStatus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class AppStatusTable{
  AppStatusTable._();

  static final AppStatusTable db = AppStatusTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newAppStatus(AppStatus newAppStatus) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM AppStatus");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into AppStatus (id, id_status, name)"
            " VALUES (?,?,?)",
        [id, newAppStatus.id_status, newAppStatus.name]);
    return raw;
  }

  blockOrUnblock(AppStatus appStatus) async {
    final db = await database;
    AppStatus blocked = AppStatus(
        id: appStatus.id,
        id_status: appStatus.id_status,
        name: appStatus.name);
    var res = await db.update("AppStatus", blocked.toMap(),
        where: "id = ?", whereArgs: [appStatus.id]);
    return res;
  }

  updateAppStatus(AppStatus newAppStatus) async {
    final db = await database;
    var res = await db.update("AppStatus", newAppStatus.toMap(),
        where: "id = ?", whereArgs: [newAppStatus.id]);
    return res;
  }

  getAppStatus(int id) async {
    final db = await database;
    var res = await db.query("AppStatus", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? AppStatus.fromMap(res.first) : null;
  }

  Future<List<AppStatus>> getBlockedAppStatus() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM AppStatus WHERE blocked=1");
    var res = await db.query("AppStatus", where: "blocked = ? ", whereArgs: [1]);

    List<AppStatus> list =
    res.isNotEmpty ? res.map((c) => AppStatus.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<AppStatus>> getAllAppStatus() async {
    final db = await database;
    var res = await db.query("AppStatus");
    List<AppStatus> list =
    res.isNotEmpty ? res.map((c) => AppStatus.fromMap(c)).toList() : [];
    return list;
  }

  deleteAppStatus(int id) async {
    final db = await database;
    return db.delete("AppStatus", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from AppStatus");
  }
}