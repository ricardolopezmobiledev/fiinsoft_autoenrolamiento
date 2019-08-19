import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AfiliacionGeneralData.dart';
import 'AfiliacionLaboralData.dart';
import 'AfiliacionDatosEconomicos.dart';
import 'AfiliacionReferencias.dart';
import 'AfiliacionAvales.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PersonasTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/TrabajosTable.dart';
import 'package:fiinsoft_autoenrolamiento/presentation/my_flutter_app_icons.dart';
import 'Model/Objects/DatosEconomicosUsuario.dart';
import 'Model/Objects/Documento.dart';
import 'Model/Objects/Persona.dart';
import 'package:fiinsoft_autoenrolamiento/dialogs/DocumentView.dart';
import 'Model/Objects/Referencia.dart';
import 'Model/Objects/Trabajo.dart';
import 'Model/db/DatosEconomicosUsuariosTable.dart';
import 'Model/db/DocumentosTable.dart';
import 'Model/db/ReferenciasTable.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;

class ListViewEx extends StatefulWidget {
  const ListViewEx({Key key}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewEx> {
  Persona persona;
  List<Documento> documentos = new List();
  List<Seccion> secciones = new List();

  @override
  void initState() {
    super.initState();
    getFromDb();
  }

  void onResume() async {
    List<Referencia> referencia = await ReferenciasTable.db.getAllReferencia();
    List<Persona> avales = await PersonaTable.db.getAllPersona();
    avales.removeAt(0);
    persona = await PersonaTable.db.getPersona(1);
    Trabajo trabajo = await TrabajoTable.db.getTrabajo(1);
    DatosEconomicosUsuario economic = await DatosEconomicosUsuarioTable.db.getDatosEconomicosUsuario(1);


    if (persona.gender == null ||
        persona.gender == '' ||
        persona.ocupacion == null ||
        persona.ocupacion == '') {
      Seccion se = secciones[0];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    } else {
      Seccion se = secciones[0];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }

    if (trabajo == null || trabajo.empresa == null ||
        trabajo.empresa == '' ||
        trabajo.puesto == null ||
        trabajo.puesto == '' ||
        trabajo.sueldo == null ||
        trabajo.sueldo == '' ||
        trabajo.antiguedad == 0 ||
        trabajo.phone.numero == null ||
        trabajo.phone.numero == '' ||
        trabajo.address.cp == null ||
        trabajo.address.cp == '' ||
        trabajo.address.ciudad == null ||
        trabajo.address.ciudad == '' ||
        trabajo.address.municipio == null ||
        trabajo.address.municipio == '' ||
        trabajo.address.estado == null ||
        trabajo.address.estado == '' ||
        trabajo.address.colonia == null ||
        trabajo.address.colonia == '' ||
        trabajo.address.calle == null ||
        trabajo.address.calle == '' ||
        trabajo.address.num_exterior == null ||
        trabajo.address.num_exterior == '') {
      Seccion se = secciones[1];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    } else {
      Seccion se = secciones[1];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }


    if (economic == null || economic.valor_vivienda == null ||
        economic.habitantes == 0 ||
        economic.anios == 0) {
      Seccion se = secciones[2];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    } else {
      Seccion se = secciones[2];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }

    if (referencia == null || referencia.length == 0) {
      Seccion se = secciones[3];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    } else {
      Seccion se = secciones[3];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }


    if (avales == null || avales.length == 0) {
      Seccion se = secciones[4];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    } else {
      Seccion se = secciones[4];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }

    setState(() {});
  }

  void getFromDb() async {
    persona = await PersonaTable.db.getPersona(1);
    Trabajo trabajo = await TrabajoTable.db.getTrabajo(1);
    DatosEconomicosUsuario economic =
        await DatosEconomicosUsuarioTable.db.getDatosEconomicosUsuario(1);
    List<Referencia> referencia = await ReferenciasTable.db.getAllReferencia();
    List<Persona> avales = await PersonaTable.db.getAllPersona();
    avales.removeAt(0);
    setState(() {
      documentos = persona.documentos;
      IconData iconGenerales;
      Color colorGenerales;
      print(persona.ocupacion);
      if (persona.gender == null ||
          persona.gender == '' ||
          persona.ocupacion == null ||
          persona.ocupacion == '') {
        iconGenerales = MyFlutterApp.cancel_circled;
        colorGenerales = Colors.red;
      } else {
        iconGenerales = MyFlutterApp.ok_circle;
        colorGenerales = Colors.green;
      }

      IconData iconLaborales;
      Color colorLaborales;
      if (trabajo == null || trabajo.empresa == null ||
          trabajo.empresa == '' ||
          trabajo.puesto == null ||
          trabajo.puesto == '' ||
          trabajo.sueldo == null ||
          trabajo.sueldo == '' ||
          trabajo.antiguedad == 0 ||
          trabajo.phone.numero == null ||
          trabajo.phone.numero == '' ||
          trabajo.address.cp == null ||
          trabajo.address.cp == '' ||
          trabajo.address.ciudad == null ||
          trabajo.address.ciudad == '' ||
          trabajo.address.municipio == null ||
          trabajo.address.municipio == '' ||
          trabajo.address.estado == null ||
          trabajo.address.estado == '' ||
          trabajo.address.colonia == null ||
          trabajo.address.colonia == '' ||
          trabajo.address.calle == null ||
          trabajo.address.calle == '' ||
          trabajo.address.num_exterior == null ||
          trabajo.address.num_exterior == '') {
        iconLaborales = MyFlutterApp.cancel_circled;
        colorLaborales = Colors.red;
      } else {
        iconLaborales = MyFlutterApp.ok_circle;
        colorLaborales = Colors.green;
      }

      IconData iconEconomic;
      Color colorEconomic;

      if (economic == null || economic.valor_vivienda == null ||
          economic.habitantes == 0 ||
          economic.anios == 0) {
        iconEconomic = MyFlutterApp.cancel_circled;
        colorEconomic = Colors.red;
      } else {
        iconEconomic = MyFlutterApp.ok_circle;
        colorEconomic = Colors.green;
      }

      IconData iconReferencias;
      Color colorReferencias;

      if (referencia == null || referencia.length == 0) {
        iconReferencias = MyFlutterApp.cancel_circled;
        colorReferencias = Colors.red;
      } else {
        iconReferencias = MyFlutterApp.ok_circle;
        colorReferencias = Colors.green;
      }

      IconData iconAvales;
      Color colorAvales;

      if (avales == null || avales.length == 0) {
        iconAvales = MyFlutterApp.cancel_circled;
        colorAvales = Colors.red;
      } else {
        iconAvales = MyFlutterApp.ok_circle;
        colorAvales = Colors.green;
      }

      secciones.add(Seccion(
          name: 'Datos generales',
          number: Icons.looks_one,
          value: iconGenerales,
          color: colorGenerales));

      secciones.add(Seccion(
          name: 'Datos laborales',
          number: Icons.looks_two,
          value: iconLaborales,
          color: colorLaborales));
      secciones.add(Seccion(
          name: 'Datos económicos',
          number: Icons.looks_3,
          value: iconEconomic,
          color: colorEconomic));
      secciones.add(Seccion(
          name: 'Referencias',
          number: Icons.looks_4,
          value: iconReferencias,
          color: colorReferencias));
      secciones.add(Seccion(
          name: 'Aval',
          number: Icons.looks_5,
          value: iconAvales,
          color: colorAvales));
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Solicitud',
              ),
              Tab(
                text: 'Digitalización',
              ),
              Tab(
                text: 'Notas',
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text('Afiliación'),
        ),
        body: TabBarView(
          children: [
            SeccionsTab(),
            DocsList(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  void onTappedDocumento(Documento documento) async {
    if(documento.path == ''){
      switch (await takePhoto(context)) {
        case "take":
          var images = await ImagePicker.pickImage(source: ImageSource.camera);
          documento.path = images.path;
          await DocumentoTable.db.updateDocumento(documento);
          break;

        case "pick":
          var images = await ImagePicker.pickImage(source: ImageSource.gallery);
          documento.path = images.path;
          await DocumentoTable.db.updateDocumento(documento);
          break;
      }
    }else{
      switch (await UpdateOrViewPhoto(context)) {
        case "take":
          switch (await takePhoto(context)) {
            case "take":
              var images = await ImagePicker.pickImage(source: ImageSource.camera);
              documento.path = images.path;
              await DocumentoTable.db.updateDocumento(documento);
              break;

            case "pick":
              var images = await ImagePicker.pickImage(source: ImageSource.gallery);
              documento.path = images.path;
              await DocumentoTable.db.updateDocumento(documento);
              break;
          }
          break;
        case "view":
          globals.pathFile = await documento.path;
          showDialog(
            context: context,
            builder: (_) => DocumentView(),
          );
          break;
      }
    }
  }

  takePhoto(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            title: Text("Elegir Documento"),
            content: SizedBox(
              height: 110,
              child: Container(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Tomar foto"),
                            onTap: () => Navigator.pop(ctxt, "take"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Elegir de galeria"),
                            onTap: () => Navigator.pop(ctxt, "pick"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Cancelar"),
                            onTap: () => Navigator.pop(ctxt, "cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
  UpdateOrViewPhoto(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            title: Text("Actualizar"),
            content: SizedBox(
              height: 110,
              child: Container(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Ver Actual"),
                            onTap: () => Navigator.pop(ctxt, "view"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Tomar Nueva"),
                            onTap: () => Navigator.pop(ctxt, "take"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Cancelar"),
                            onTap: () => Navigator.pop(ctxt, "cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onTapped(Seccion seccion) async {
    if (seccion.name == 'Datos generales') {
      bool refresh = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => GeneralData()));
      onResume();
    } else if (seccion.name == 'Datos laborales') {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => LaboralData()));
      onResume();
    } else if (seccion.name == 'Datos económicos') {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => EconomicData()));
      onResume();
    } else if (seccion.name == 'Referencias') {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => References()));
      onResume();
    } else if (seccion.name == 'Aval') {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => Avales()));
      onResume();
    }
  }

  Widget SeccionsTab() {
    return new Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var seccion = secciones[index];

          return GestureDetector(
            child: new Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: new IconTheme(
                      data: new IconThemeData(color: Colors.blue),
                      child: new Icon(seccion.number),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      seccion.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: new IconTheme(
                      data: new IconThemeData(color: seccion.color),
                      child: new Icon(seccion.value),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Icon(Icons.keyboard_arrow_right),
                    flex: 1,
                  ),
                ],
              ),
            ),
            onTap: () => onTapped(seccion),
          );
        },
        itemCount: secciones.length,
      ),
    );
  }

  Widget DocsList() {
    return new Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var documento = documentos[index];

          return GestureDetector(
            child: new Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(documento.nombre),
                        flex: 5,
                      ),
                      Expanded(
                        child: Icon(Icons.camera_alt),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () => onTappedDocumento(documento),
          );
        },
        itemCount: documentos.length,
      ),
    );
  }
}

class Seccion {
  Seccion({this.name, this.number, this.value, this.color});

  String name;
  IconData number;
  IconData value;
  Color color;
}
