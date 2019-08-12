import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AfiliacionGeneralData.dart';
import 'AfiliacionLaboralData.dart';
import 'AfiliacionDatosEconomicos.dart';
import 'AfiliacionReferencias.dart';
import 'AfiliacionAvales.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PersonasTable.dart';
import 'package:fiinsoft_autoenrolamiento/presentation/my_flutter_app_icons.dart';
import 'Model/Objects/Documento.dart';
import 'Model/Objects/Persona.dart';
import 'package:flutter/services.dart';

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


  void onResume(){
    if(persona.gender == null && persona.ocupacion == null){
      Seccion se = secciones[0];
      se.value = MyFlutterApp.cancel_circled;
      se.color = Colors.red;
    }else{
      Seccion se = secciones[0];
      se.value = MyFlutterApp.ok_circle;
      se.color = Colors.green;
    }
  }

  void getFromDb() async{
    persona = await PersonaTable.db.getPersona(1);
    setState(() {
      documentos = persona.documentos;
      IconData iconGenerales;
      Color colorGenerales;
      if(persona.gender == null && persona.ocupacion == null){
        iconGenerales = MyFlutterApp.cancel_circled;
        colorGenerales = Colors.red;
      }else{
        iconGenerales = MyFlutterApp.ok_circle;
        colorGenerales = Colors.green;
      }

      secciones.add(Seccion(
          name: 'Datos generales',
          number: Icons.looks_one,
          value: iconGenerales,
          color: colorGenerales));

      secciones.add(Seccion(
          name: 'Datos laborales',
          number: Icons.looks_two,
          value: MyFlutterApp.cancel_circled,
          color: Colors.red));
      secciones.add(Seccion(
          name: 'Datos económicos',
          number: Icons.looks_3,
          value: MyFlutterApp.cancel_circled,
          color: Colors.red));
      secciones.add(Seccion(
          name: 'Referencias', number: Icons.looks_4, value: MyFlutterApp.cancel_circled,
          color: Colors.red));
      secciones.add(Seccion(
          name: 'Aval', number: Icons.looks_5, value: MyFlutterApp.cancel_circled,
          color: Colors.red));
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

  void onTappedDocumento(Documento documento) async{
    switch(await takePhoto(context)){
      case "take":
        var images = await ImagePicker.pickImage(source: ImageSource.camera);
        documento.path = images.path;
        break;

      case "pick":
        var images = await ImagePicker.pickImage(source: ImageSource.gallery);
        documento.path = images.path;
        break;
    }
  }

  takePhoto(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt){
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
                            onTap: ()=> Navigator.pop(ctxt, "take"),
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
                            onTap: ()=> Navigator.pop(ctxt, "pick"),
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
                            onTap: ()=> Navigator.pop(ctxt, "cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void onTapped(Seccion seccion) async{
    if(seccion.name == 'Datos generales'){
      bool refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralData()));
      onResume();
    }else if(seccion.name == 'Datos laborales'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LaboralData()));
    }else if(seccion.name == 'Datos económicos'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EconomicData()));
    }else if(seccion.name == 'Referencias'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => References()));
    }else if(seccion.name == 'Aval'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Avales()));
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
                      data: new IconThemeData(
                          color: Colors.blue),
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
                      data: new IconThemeData(
                          color: seccion.color),
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





