import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';
import 'AgregarVehiculoDialog.dart';
import 'AgregarEgresoDialog.dart';
import 'AgregarIngresoDialog.dart';
import 'Model/Objects/Egreso.dart';
import 'Model/Objects/Ingreso.dart';
import 'Model/Objects/Vehiculo.dart';
import 'Model/db/EgresosTable.dart';
import 'Model/db/IngresosTable.dart';
import 'Model/db/VehiculosTable.dart';
import 'Model/db/DatosEconomicosUsuariosTable.dart';
import 'Model/Objects/DatosEconomicosUsuario.dart';


class ContactLaboralData extends StatefulWidget {
  const ContactLaboralData({Key key}) : super(key: key);

  @override
  _ContactLaboralData createState() => _ContactLaboralData();
}

class _ContactLaboralData extends  State<ContactLaboralData>  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool _value1 = false;
  bool _value2 = false;

  TextEditingController valueProp;

  Color propiaInside = Colors.blue;
  Color propiaText = Colors.white;

  Color rentaInside = Colors.white;
  Color rentaText = Colors.blue;

  Color hipotecaInside = Colors.white;
  Color hipotecaText = Colors.blue;

  Color familiarInside = Colors.white;
  Color familiarText = Colors.blue;

  int propertitypeVal = 1;
  void _onChanged2(bool value) => setState(() => _value2 = value);
  void _onChanged1(bool value) => setState(() => _value1 = value);
  int _n = 0;
  int _n1 = 0;

  Choice _selectedChoice = choices[0];
  List<Ingreso> ingresos = new List();
  List<Egreso> egresos = new List();
  List<Vehiculo> vehiculos = new List();
  void _select(Choice choice) {}

  @override
  void initState(){
    super.initState();
    valueProp = new TextEditingController();
    getDataFromDB();
  }

  void getDataFromDB() async{
    List<DatosEconomicosUsuario> economicosUsuario = await DatosEconomicosUsuarioTable.db.getAllDatosEconomicosUsuario();
    if(economicosUsuario.length != 0){
      setState(() {
        if(economicosUsuario[0].tipo_vivienda == 'PROPIA') clicbutton(1);
        else if(economicosUsuario[0].tipo_vivienda == 'RENTA') clicbutton(2);
        else if(economicosUsuario[0].tipo_vivienda == 'HIPOTECA') clicbutton(3);
        else clicbutton(4);
        valueProp.text = economicosUsuario[0].valor_vivienda;
        _n = economicosUsuario[0].habitantes;
        _value2 = economicosUsuario[0].menos_anio;
        _n1 = economicosUsuario[0].anios;
        _value1 = economicosUsuario[0].mas_una_propiedad;
      });
    }
    var d = await EgresosTable.db.getAllEgresos();
    var e = await IngresosTable.db.getAllIngresos();
    var f = await VehiculosTable.db.getAllVehiculos();
    setState(() {
      egresos = d;
      ingresos = e;
      vehiculos = f;
    });
  }

  void dialogVehi()async{
    await showDialog(
      context: context,
      builder: (_) => AgregarVehiculoDialog(),
    );
    getDataFromDB();
  }

  void dialogIng()async{
    await showDialog(
      context: context,
      builder: (_) => AgregarIngresoDialog(),
    );
    getDataFromDB();
  }

  void dialogEg()async{
    await showDialog(
      context: context,
      builder: (_) => AgregarEgresoDialog(),
    );
    getDataFromDB();
  }

  void updateUser() async{
    List<DatosEconomicosUsuario> economicosUsuario = await DatosEconomicosUsuarioTable.db.getAllDatosEconomicosUsuario();
    String tipoProp = '';
    if(propertitypeVal == 1) tipoProp = 'PROPIA';
    else if(propertitypeVal == 2) tipoProp = 'RENTA';
    else if(propertitypeVal == 3) tipoProp = 'HIPOTECA';
    else tipoProp = 'FAMILIAR';
    DatosEconomicosUsuario newDatosEconomicosUsuario = new DatosEconomicosUsuario(
        tipo_vivienda: tipoProp,
        id: 1,
        valor_vivienda: valueProp.text,
        habitantes: _n,
        menos_anio: _value2,
        anios: _n1,
        mas_una_propiedad: _value1
    );
    if(economicosUsuario.length == 0)await DatosEconomicosUsuarioTable.db.newDatosEconomicosUsuario(newDatosEconomicosUsuario);
    else await DatosEconomicosUsuarioTable.db.updateDatosEconomicosUsuario(newDatosEconomicosUsuario);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      updateUser();
      print('returnPressed');
//          Navigator.pop(context,'refresh');
      return true;
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Datos Economicos'),
          leading: IconButton(
            icon: Icon(Icons.looks_3),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Tipo de vivienda'),
                      SizedBox(
                        width: 1000.0,
                        height: 10.0,
                        child: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 140.0,
                            height: 40.0,
                            child: new RaisedButton(
                              textColor: propiaText,
                              color: propiaInside,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blue)),
                              onPressed: () {clicbutton(1);},
                              child: const Text('PROPIA', style: TextStyle(fontSize: 13)),
                            ),
                          ),
                          SizedBox(
                              width: 140.0,
                              height: 40.0,
                              child: new RaisedButton(
                                textColor: rentaText,
                                color: rentaInside,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.blue)),
                                onPressed: () {clicbutton(2);},
                                child: const Text('RENTA', style: TextStyle(fontSize: 13)),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 1000.0,
                        height: 10.0,
                        child: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 140.0,
                            height: 40.0,
                            child: new RaisedButton(
                              textColor: hipotecaText,
                              color: hipotecaInside,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blue)),
                              onPressed: () {clicbutton(3);},
                              child: const Text('HIPOTECA', style: TextStyle(fontSize: 13)),
                            ),
                          ),
                          SizedBox(
                              width: 140.0,
                              height: 40.0,
                              child: new RaisedButton(
                                textColor: familiarText,
                                color: familiarInside,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.blue)),
                                onPressed: () {clicbutton(4);},
                                child:
                                const Text('FAMILIAR', style: TextStyle(fontSize: 13)),
                              )),
                        ],
                      ),
                      TextFormField(
                        controller: valueProp,
                        decoration: const InputDecoration(
                          labelText: 'Valor de la propiedad',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'El valor de la propiedad es requerido';
                          }
                        },
                      ),
                      SizedBox(
                        width: 1000.0,
                        height: 10.0,
                        child: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text('Habitantes'),
                            flex: 1,
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: FloatingActionButton(
                                      heroTag: "btn1",
                                      onPressed: minus,
                                      child: new Icon(
                                          const IconData(0xe15b,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.black),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text('$_n',
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(fontSize: 25.0)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: FloatingActionButton(
                                      heroTag: "btn2",
                                      onPressed: add,
                                      child: new Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      new SwitchListTile(
                        value: _value2,
                        onChanged: _onChanged2,
                        title: new Text('Menos de un año',
                            style: new TextStyle(color: Colors.black)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text('Años de habitarla'),
                            flex: 1,
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: FloatingActionButton(
                                      heroTag: "btn3",
                                      onPressed: minus2,
                                      child: new Icon(
                                          const IconData(0xe15b,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.black),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text('$_n1',
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(fontSize: 25.0)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: FloatingActionButton(
                                      heroTag: "btn4",
                                      onPressed: add2,
                                      child: new Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      new SwitchListTile(
                        value: _value1,
                        onChanged: _onChanged1,
                        title: new Text('¿Tiene mas de una propiedad?',
                            style: new TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Card(
                  child: SizedBox(
                    height: 270,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),child: Text('Vehiculos'),),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Text('Agregar Vehiculos'),
                              ),
                              SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: FloatingActionButton(
                                  heroTag: "btn5",
                                  onPressed: (){
                                    dialogVehi();
                                  },
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 5, 16.0, 8.0),
                          child: SizedBox(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                var vehiculo = vehiculos[index];

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
                                              child: Text(vehiculo.marca),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                vehiculo.modelo,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                vehiculo.anio,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Icon(Icons.highlight_off),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => onTappedVehiculo(vehiculo),
                                );
                              },
                              itemCount: vehiculos.length,
                            ),
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Card(
                  child: SizedBox(
                    height: 270,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),child: Text('Ingresos'),),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Text('Agregar Ingresos'),
                              ),
                              SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: FloatingActionButton(
                                  heroTag: "btn6",
                                  onPressed: (){
                                    dialogIng();
                                  },
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 5, 16.0, 8.0),
                          child: SizedBox(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                var ingreso = ingresos[index];

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
                                              child: Text(ingreso.concepto),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                ingreso.monto_mensual,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Icon(Icons.highlight_off),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => onTappedIngresos(ingreso),
                                );
                              },
                              itemCount: ingresos.length,
                            ),
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Card(
                  child: SizedBox(
                    height: 270,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),child: Text('Egresos'),),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Text('Agregar Egresos'),
                              ),
                              SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: FloatingActionButton(
                                  heroTag: "btn7",
                                  onPressed: (){
                                    dialogEg();
                                  },
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 5, 16.0, 8.0),
                          child: SizedBox(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                var egreso = egresos[index];

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
                                              child: Text(egreso.concepto),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                egreso.monto_mensual,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Icon(Icons.highlight_off),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => onTappedEgresos(egreso),
                                );
                              },
                              itemCount: egresos.length,
                            ),
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void clicbutton(int button){
    propertitypeVal = button;
    setState(() {
      if(button == 1){
        propiaInside = Colors.blue;
        propiaText = Colors.white;
        rentaInside = Colors.white;
        rentaText = Colors.blue;
        hipotecaInside = Colors.white;
        hipotecaText = Colors.blue;
        familiarInside = Colors.white;
        familiarText = Colors.blue;
      }else if(button == 2){
        propiaInside = Colors.white;
        propiaText = Colors.blue;
        rentaInside = Colors.blue;
        rentaText = Colors.white;
        hipotecaInside = Colors.white;
        hipotecaText = Colors.blue;
        familiarInside = Colors.white;
        familiarText = Colors.blue;
      }else if(button == 3){
        propiaInside = Colors.white;
        propiaText = Colors.blue;
        rentaInside = Colors.white;
        rentaText = Colors.blue;
        hipotecaInside = Colors.blue;
        hipotecaText = Colors.white;
        familiarInside = Colors.white;
        familiarText = Colors.blue;
      }else if(button == 4){
        propiaInside = Colors.white;
        propiaText = Colors.blue;
        rentaInside = Colors.white;
        rentaText = Colors.blue;
        hipotecaInside = Colors.white;
        hipotecaText = Colors.blue;
        familiarInside = Colors.blue;
        familiarText = Colors.white;
      }
    });
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  void add2() {
    setState(() {
      _n1++;
    });
  }

  void minus2() {
    setState(() {
      if (_n1 != 0) _n1--;
    });
  }
}

void onTappedVehiculo(Vehiculo vehiculo) {}

void onTappedIngresos(Ingreso ingreso) {}

void onTappedEgresos(Egreso ingreso) {}




class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
