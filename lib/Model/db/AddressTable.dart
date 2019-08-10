import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/Database.dart';
class AddresssTable{
  AddresssTable._();

  static final AddresssTable db = AddresssTable._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await DBProvider.db.initDB();
    return _database;
  }

  newAddress(Address newAddress) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Address");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Address (id, cp, ciudad, municipio, estado, colonia, calle, num_exterior, num_interior)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [id, newAddress.cp, newAddress.ciudad, newAddress.municipio, newAddress.estado, newAddress.colonia, newAddress.calle, newAddress.num_exterior, newAddress.num_interior]);
    return raw;
  }

  blockOrUnblock(Address address) async {
    final db = await database;
    Address blocked = Address(
        id: address.id,
        cp: address.cp,
        ciudad: address.ciudad,
        municipio: address.municipio,
        estado: address.estado,
        colonia: address.colonia,
        calle: address.calle,
        num_exterior: address.num_exterior,
        num_interior: address.num_interior
    );
    var res = await db.update("Address", blocked.toMap(),
        where: "id = ?", whereArgs: [address.id]);
    return res;
  }

  updateAddress(Address newAddress) async {
    final db = await database;
    var res = await db.update("Address", newAddress.toMap(),
        where: "id = ?", whereArgs: [newAddress.id]);
    return res;
  }

  getAddress(int id) async {
    final db = await database;
    var res = await db.query("Address", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Address.fromMap(res.first) : null;
  }

  Future<List<Address>> getBlockedAddresss() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Address WHERE blocked=1");
    var res = await db.query("Address", where: "blocked = ? ", whereArgs: [1]);

    List<Address> list =
    res.isNotEmpty ? res.map((c) => Address.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Address>> getAllAddresss() async {
    final db = await database;
    var res = await db.query("Address");
    List<Address> list =
    res.isNotEmpty ? res.map((c) => Address.fromMap(c)).toList() : [];
    return list;
  }

  deleteAddress(int id) async {
    final db = await database;
    return db.delete("Address", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Address");
  }
}