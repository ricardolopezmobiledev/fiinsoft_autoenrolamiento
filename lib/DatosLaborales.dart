import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';

class DatosLaboralesForm extends StatefulWidget {
  const DatosLaboralesForm({Key key}) : super(key: key);

  @override
  _DatosLaboralesFormState createState() => _DatosLaboralesFormState();
}

class _DatosLaboralesFormState extends State<DatosLaboralesForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool _value1 = false;
  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);
  int _n = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Empresa',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El nombre de la empresa es requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Puesto',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El puesto es requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Sueldo',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El sueldo es requerido';
              }
            },
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
                child: Text('Antigüedad'),
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
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Teléfono',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El telefono es requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tipo teléfono',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El tipo de telefono es requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tipo teléfono',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El tipo de telefono es requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Codigo postal',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Codigo postal Requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cuidad',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Cuidad Requerida';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Municipio',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Municipio Requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Estado',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Estado Requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Colonia',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Colonia Requerida';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Numero Exterior',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Numero exterior';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Numero Interior',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Numero interior';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Calle',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Calle requerida';
              }
            },
          ),
          /*Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Guardar'),
              ),
            ],
          ),*/
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
        title: const Text('Datos Laborales'),
        leading: IconButton(
          icon: Icon(Icons.looks_two),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: DatosLaboralesForm(),
        ),
      ),
    );
  }
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
