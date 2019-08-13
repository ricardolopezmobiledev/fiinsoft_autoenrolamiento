import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FiinsoftAEDB.db");
    return await openDatabase(path,
        version: 8,
        onOpen: (db) {},
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("CREATE TABLE DatosEconomicosUsuario ("
        "id INTEGER PRIMARY KEY,"
        "id_persona INTEGER,"
        "idInServer INTEGER,"
        "tipo_vivienda TEXT,"
        "valor_vivienda TEXT,"
        "habitantes INTEGER,"
        "menos_anio BIT,"
        "anios INTEGER,"
        "mas_una_propiedad BIT"
        ")");
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Session ("
        "id INTEGER PRIMARY KEY,"
        "id_persona INTEGER,"
        "token TEXT,"
        "email TEXT,"
        "full_name TEXT,"
        "is_logged_in BIT"
        ")");
    await db.execute("CREATE TABLE AppStatus ("
        "id INTEGER PRIMARY KEY,"
        "id_status INTEGER,"
        "name TEXT"
        ")");
    await db.execute("CREATE TABLE Persona ("
        "id INTEGER PRIMARY KEY,"
        "idInServer INTEGER,"
        "idAddress INTEGER,"
        "nombre TEXT,"
        "ap_paterno TEXT,"
        "ap_materno TEXT,"
        "email TEXT,"
        "escolaridad TEXT,"
        "gender TEXT,"
        "estado_civil TEXT,"
        "ocupacion TEXT,"
        "tipo_ocupacion TEXT,"
        "fecha_de_nacimiento TEXT,"
        "curp TEXT,"
        "rfc TEXT,"
        "is_collaborator BIT,"
        "has_dangerous_work BIT,"
        "has_experience BIT"
        ")");
    await db.execute("CREATE TABLE Address ("
        "id INTEGER PRIMARY KEY,"
        "cp TEXT,"
        "ciudad TEXT,"
        "municipio TEXT,"
        "estado TEXT,"
        "colonia TEXT,"
        "calle TEXT,"
        "num_exterior TEXT,"
        "num_interior TEXT"
        ")");
    await db.execute("CREATE TABLE Documento ("
        "id INTEGER PRIMARY KEY,"
        "nombre TEXT,"
        "id_persona INTEGER,"
        "status TEXT,"
        "path TEXT"
        ")");
    await db.execute("CREATE TABLE Phone ("
        "id INTEGER PRIMARY KEY,"
        "numero TEXT, "
        "id_persona INTEGER,"
        "tipo TEXT"
        ")");
    await db.execute("CREATE TABLE Trabajo ("
        "id INTEGER PRIMARY KEY,"
        "idInServer INTEGER,"
        "id_persona INTEGER,"
        "empresa TEXT,"
        "puesto TEXT,"
        "sueldo TEXT,"
        "menos_anio BIT,"
        "antiguedad INTEGER,"
        "phone INTEGER,"
        "address INTEGER"
        ")");
    await db.execute("CREATE TABLE Ingreso ("
        "id INTEGER PRIMARY KEY,"
        "concepto TEXT,"
        "monto_mensual TEXT"
        ")");

    await db.execute("CREATE TABLE Egreso ("
        "id INTEGER PRIMARY KEY,"
        "concepto TEXT,"
        "monto_mensual TEXT"
        ")");

    await db.execute("CREATE TABLE Vehiculo ("
        "id INTEGER PRIMARY KEY,"
        "marca TEXT,"
        "modelo TEXT,"
        "anio TEXT"
        ")");
    await db.execute("CREATE TABLE DatosEconomicosUsuario ("
        "id INTEGER PRIMARY KEY,"
        "idInServer INTEGER,"
        "tipo_vivienda TEXT,"
        "valor_vivienda TEXT,"
        "habitantes INTEGER,"
        "menos_anio BIT,"
        "anios INTEGER,"
        "mas_una_propiedad BIT"
        ")");
  }
}
