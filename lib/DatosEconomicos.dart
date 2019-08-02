import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';
import 'AgregarVehiculoDialog.dart';
import 'AgregarEgresoDialog.dart';
import 'AgregarIngresoDialog.dart';

class DatosEconomicosForm extends StatefulWidget {
  const DatosEconomicosForm({Key key}) : super(key: key);

  @override
  _DatosEconomicosFormState createState() => _DatosEconomicosFormState();
}

class _DatosEconomicosFormState extends State<DatosEconomicosForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool _value1 = false;
  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);
  void _onChanged1(bool value) => setState(() => _value1 = value);
  int _n = 0;
  int _n1 = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  textColor: Colors.blue,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () {},
                  child: const Text('PROPIA', style: TextStyle(fontSize: 13)),
                ),
              ),
              SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {},
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
                  textColor: Colors.blue,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () {},
                  child: const Text('HIPOTECA', style: TextStyle(fontSize: 13)),
                ),
              ),
              SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: new RaisedButton(
                    textColor: Colors.blue,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () {},
                    child:
                        const Text('FAMILIAR', style: TextStyle(fontSize: 13)),
                  )),
            ],
          ),
          TextFormField(
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
    );
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

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Seguimiento()));
    }
    print('Form submitted');
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

class ContactLaboralData extends StatelessWidget {
  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: DatosEconomicosForm(),
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
                                  showDialog(
                                    context: context,
                                    builder: (_) => AgregarVehiculoDialog(),
                                  );
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
                                  showDialog(
                                    context: context,
                                    builder: (_) => AgregarIngresoDialog(),
                                  );
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
                                  showDialog(
                                    context: context,
                                    builder: (_) => AgregarEgresoDialog(),
                                  );
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
    );
  }
}

const List<Vehiculo> vehiculos = const <Vehiculo>[
  const Vehiculo(marca: 'VW', modelo: 'BORA', anio: '2006'),
  const Vehiculo(marca: 'Chevrolet', modelo: 'Chevy', anio: '2000'),
  const Vehiculo(marca: 'Nissan', modelo: 'Tsuru', anio: '2005'),
];

void onTappedVehiculo(Vehiculo vehiculo) {}

class Vehiculo {
  const Vehiculo({this.marca, this.modelo, this.anio});

  final String marca;
  final String modelo;
  final String anio;
}

const List<Ingresos> ingresos = const <Ingresos>[
  const Ingresos(concepto: 'Trabajo', monto_mensual: '2,000.00'),
  const Ingresos(concepto: 'Otros', monto_mensual: '2,000.00'),
  const Ingresos(concepto: 'Ventas', monto_mensual: '2,000.00'),
];

void onTappedIngresos(Ingresos ingreso) {}

class Ingresos {
  const Ingresos({this.concepto, this.monto_mensual});

  final String concepto;
  final String monto_mensual;
}

const List<Egresos> egresos = const <Egresos>[
  const Egresos(concepto: 'Egresos', monto_mensual: '2,000.00'),
  const Egresos(concepto: 'Tarjetas', monto_mensual: '2,000.00'),
  const Egresos(concepto: 'Deudas', monto_mensual: '2,000.00'),
  const Egresos(concepto: 'Alimentación', monto_mensual: '2,000.00'),
];

void onTappedEgresos(Egresos ingreso) {}

class Egresos {
  const Egresos({this.concepto, this.monto_mensual});

  final String concepto;
  final String monto_mensual;
}

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
