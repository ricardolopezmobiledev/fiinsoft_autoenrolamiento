import 'package:flutter/material.dart';
import 'AfiliacionGeneralData.dart';
import 'AfiliacionLaboralData.dart';
import 'AfiliacionDatosEconomicos.dart';
import 'AfiliacionReferencias.dart';
import 'AfiliacionAvales.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PersonasTable.dart';

import 'Model/Objects/Persona.dart';

class ListViewEx extends StatefulWidget {
  const ListViewEx({Key key}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewEx> {
  Persona persona;

  @override
  void initState() {
    super.initState();
    getFromDb();
  }

  void getFromDb() async{
    persona = await PersonaTable.db.getPersona(1);
    persona = persona;
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
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  void onTapped(Seccion seccion) {
    if(seccion.name == 'Datos generales'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralData()));
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
                    child: Icon(seccion.number),
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
                    child: Icon(seccion.value),
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
}

class Seccion {
  const Seccion({this.name, this.number, this.value});

  final String name;
  final IconData number;
  final IconData value;
}

const List<Seccion> secciones = const <Seccion>[
  const Seccion(
      name: 'Datos generales',
      number: Icons.looks_one,
      value: Icons.highlight_off),
  const Seccion(
      name: 'Datos laborales',
      number: Icons.looks_two,
      value: Icons.highlight_off),
  const Seccion(
      name: 'Datos económicos',
      number: Icons.looks_3,
      value: Icons.highlight_off),
  const Seccion(
      name: 'Referencias', number: Icons.looks_4, value: Icons.highlight_off),
  const Seccion(
      name: 'Aval', number: Icons.looks_5, value: Icons.highlight_off),
];




