import 'package:fiinsoft_autoenrolamiento/Model/Objects/DatosEconomicosUsuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AddressTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PhonesTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';

class DatosEconomicosUsuarioTable {
  DatosEconomicosUsuarioTable._();

  static final DatosEconomicosUsuarioTable db = DatosEconomicosUsuarioTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newDatosEconomicosUsuario(
      DatosEconomicosUsuario newDatosEconomicosUsuario) async {
    final db = await database;
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM DatosEconomicosUsuario");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into DatosEconomicosUsuario (id, idInServer, id_persona, tipo_vivienda, valor_vivienda, habitantes, menos_anio, anios, mas_una_propiedad)"
        " VALUES (?,?,?,?,?,?,?,?,?)",
        [
          id,
          newDatosEconomicosUsuario.idInServer,
          newDatosEconomicosUsuario.id_persona,
          newDatosEconomicosUsuario.tipo_vivienda,
          newDatosEconomicosUsuario.valor_vivienda,
          newDatosEconomicosUsuario.habitantes,
          newDatosEconomicosUsuario.menos_anio,
          newDatosEconomicosUsuario.anios,
          newDatosEconomicosUsuario.mas_una_propiedad,
        ]);
    return raw;
  }

  blockOrUnblock(DatosEconomicosUsuario datosEconomicosUsuario) async {
    final db = await database;
    DatosEconomicosUsuario blocked = DatosEconomicosUsuario(
      id: datosEconomicosUsuario.id,
      idInServer: datosEconomicosUsuario.idInServer,
      id_persona: datosEconomicosUsuario.id_persona,
      tipo_vivienda: datosEconomicosUsuario.tipo_vivienda,
      valor_vivienda: datosEconomicosUsuario.valor_vivienda,
      habitantes: datosEconomicosUsuario.habitantes,
      menos_anio: datosEconomicosUsuario.menos_anio,
      anios: datosEconomicosUsuario.anios,
      mas_una_propiedad: datosEconomicosUsuario.mas_una_propiedad,
    );
    var res = await db.update("DatosEconomicosUsuario", blocked.toMap(),
        where: "id = ?", whereArgs: [datosEconomicosUsuario.id]);
    return res;
  }

  updateDatosEconomicosUsuario(
      DatosEconomicosUsuario newDatosEconomicosUsuario) async {
    final db = await database;
    //get the biggest id in the table

    //insert to the table using the new id
    var raw = await db.rawUpdate(
        "UPDATE DatosEconomicosUsuario "
        "SET idInServer = ?,"
        "id_persona = ?,"
        "tipo_vivienda = ?,"
        "valor_vivienda = ?,"
        "habitantes = ?,"
        "menos_anio = ?,"
        "anios = ?,"
        "mas_una_propiedad = ?"
        "WHERE id = ?",
        [
          newDatosEconomicosUsuario.idInServer,
          newDatosEconomicosUsuario.id_persona,
          newDatosEconomicosUsuario.tipo_vivienda,
          newDatosEconomicosUsuario.valor_vivienda,
          newDatosEconomicosUsuario.habitantes,
          newDatosEconomicosUsuario.menos_anio,
          newDatosEconomicosUsuario.anios,
          newDatosEconomicosUsuario.mas_una_propiedad,
          newDatosEconomicosUsuario.id
        ]);
    return raw;
  }

  getDatosEconomicosUsuario(int id) async {
    final db = await database;
    var res = await db
        .query("DatosEconomicosUsuario", where: "id = ?", whereArgs: [id]);
    DatosEconomicosUsuario datosEconomicosUsuario =
        res.isNotEmpty ? DatosEconomicosUsuario.fromMap(res.first) : null;
    return datosEconomicosUsuario;
  }

  Future<List<DatosEconomicosUsuario>>
      getBlockedDatosEconomicosUsuario() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM DatosEconomicosUsuario WHERE blocked=1");
    var res = await db
        .query("DatosEconomicosUsuario", where: "blocked = ? ", whereArgs: [1]);

    List<DatosEconomicosUsuario> list = res.isNotEmpty
        ? res.map((c) => DatosEconomicosUsuario.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<List<DatosEconomicosUsuario>> getAllDatosEconomicosUsuario() async {
    final db = await database;
    var res = await db.query("DatosEconomicosUsuario");
    List<DatosEconomicosUsuario> list = res.isNotEmpty
        ? res.map((c) => DatosEconomicosUsuario.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteDatosEconomicosUsuario(int id) async {
    final db = await database;
    return db
        .delete("DatosEconomicosUsuario", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from DatosEconomicosUsuario");
  }
}
