import 'package:fiinsoft_autoenrolamiento/Model/Objects/Session.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class SessionsTable{
  SessionsTable._();

  static final SessionsTable db = SessionsTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newSession(Session newSession) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Session");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Session (id, id_persona, token, email, full_name, is_logged_in)"
            " VALUES (?,?,?,?,?,?)",
        [id, newSession.id_persona, newSession.token, newSession.email, newSession.fullName, newSession.isLoggedIn]);
    return raw;
  }

  blockOrUnblock(Session session) async {
    final db = await database;
    Session blocked = Session(
        id: session.id,
        id_persona: session.id_persona,
        token: session.token,
        email: session.email,
        fullName: session.fullName,
        isLoggedIn: !session.isLoggedIn);
    var res = await db.update("Session", blocked.toMap(),
        where: "id = ?", whereArgs: [session.id]);
    return res;
  }

  updateSession(Session newSession) async {
    final db = await database;
    var res = await db.update("Session", newSession.toMap(),
        where: "id = ?", whereArgs: [newSession.id]);
    return res;
  }

  getSession(int id) async {
    final db = await database;
    var res = await db.query("Session", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Session.fromMap(res.first) : null;
  }

  Future<List<Session>> getBlockedSessions() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Session WHERE blocked=1");
    var res = await db.query("Session", where: "blocked = ? ", whereArgs: [1]);

    List<Session> list =
    res.isNotEmpty ? res.map((c) => Session.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Session>> getAllSessions() async {
    final db = await database;
    var res = await db.query("Session");
    List<Session> list =
    res.isNotEmpty ? res.map((c) => Session.fromMap(c)).toList() : [];
    return list;
  }

  deleteSession(int id) async {
    final db = await database;
    return db.delete("Session", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Session");
  }
}