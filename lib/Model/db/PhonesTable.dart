import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class PhonesTable{
  PhonesTable._();

  static final PhonesTable db = PhonesTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newPhone(Phone newPhone) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Phone");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Phone (id, numero, id_persona, tipo)"
            " VALUES (?,?,?,?)",
        [id, newPhone.numero, newPhone.id_persona, newPhone.tipo]);
    return raw;
  }

  blockOrUnblock(Phone phone) async {
    final db = await database;
    Phone blocked = Phone(
        id: phone.id,
        numero: phone.numero,
        id_persona: phone.id_persona,
        tipo: phone.tipo
    );
    var res = await db.update("Phone", blocked.toMap(),
        where: "id = ?", whereArgs: [phone.id]);
    return res;
  }

  updatePhone(Phone newPhone) async {
    final db = await database;
    var res = await db.update("Phone", newPhone.toMap(),
        where: "id = ?", whereArgs: [newPhone.id]);
    return res;
  }

  getPhone(int id) async {
    final db = await database;
    var res = await db.query("Phone", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Phone.fromMap(res.first) : null;
  }

  Future<List<Phone>> getBlockedPhones() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Phone WHERE blocked=1");
    var res = await db.query("Phone", where: "blocked = ? ", whereArgs: [1]);

    List<Phone> list =
    res.isNotEmpty ? res.map((c) => Phone.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Phone>> getAllPhones() async {
    final db = await database;
    var res = await db.query("Phone");
    List<Phone> list =
    res.isNotEmpty ? res.map((c) => Phone.fromMap(c)).toList() : [];
    return list;
  }

  deletePhone(int id) async {
    final db = await database;
    return db.delete("Phone", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Phone");
  }
}