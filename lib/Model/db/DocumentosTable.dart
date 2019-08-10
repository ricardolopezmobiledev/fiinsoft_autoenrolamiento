import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AddressTable.dart';

class DocumentoTable{
  DocumentoTable._();

  static final DocumentoTable db = DocumentoTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newDocumento(Documento newDocumento) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Documento");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Documento (id, nombre, id_persona, status, path)"
            " VALUES (?,?,?,?,?)",
        [id, newDocumento.nombre, newDocumento.id_persona, newDocumento.status, newDocumento.path]);
    return raw;
  }

  blockOrUnblock(Documento documento) async {
    final db = await database;
    Documento blocked = Documento(
        id: documento.id,
        nombre: documento.nombre,
        id_persona: documento.id_persona,
        status: documento.status,
        path: documento.path,
    );
    var res = await db.update("Documento", blocked.toMap(),
        where: "id = ?", whereArgs: [documento.id]);
    return res;
  }

  updateDocumento(Documento newDocumento) async {
    final db = await database;
    var res = await db.update("Documento", newDocumento.toMap(),
        where: "id = ?", whereArgs: [newDocumento.id]);
    return res;
  }

  getDocumento(int id) async {
    final db = await database;
    var res = await db.query("Documento", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Documento.fromMap(res.first) : null;
  }

  Future<List<Documento>> getBlockedDocumento() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Documento WHERE blocked=1");
    var res = await db.query("Documento", where: "blocked = ? ", whereArgs: [1]);

    List<Documento> list =
    res.isNotEmpty ? res.map((c) => Documento.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Documento>> getAllDocumento() async {
    final db = await database;
    var res = await db.query("Documento");
    List<Documento> list =
    res.isNotEmpty ? res.map((c) => Documento.fromMap(c)).toList() : [];
    return list;
  }

  deleteDocumento(int id) async {
    final db = await database;
    return db.delete("Documento", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Documento");
  }
}