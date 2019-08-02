import 'package:flutter/material.dart';
import 'Model/Objects/Choise.dart';

class ReferencesAddForm extends StatefulWidget {
  const ReferencesAddForm({Key key}) : super(key: key);

  @override
  _ReferencesAddFormState createState() => _ReferencesAddFormState();
}

class _ReferencesAddFormState extends State<ReferencesAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  int _n = 0;
  bool _value1 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nombre(s)',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El nombre es requerido';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Apellido paterno',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Apellido paterno requerido';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Apellido materno',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Apellido materno requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Parentesco',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Parentesco requerido';
              }
            },
          ),
          SizedBox(
            width: 1000.0,
            height: 10.0,
            child: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Text('Menos de un año'),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: null,
                ),
              ),
              Expanded(
                flex: 1,
                child: new Switch(value: _value1, onChanged: _onChanged1),
              ),
            ],
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
                child: Text('Años de conocerlo'),
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
          SizedBox(
            width: 1000.0,
            height: 10.0,
            child: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Text('Misma dirección que el titular'),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: null,
                ),
              ),
              Expanded(
                flex: 1,
                child: new Switch(value: _value1, onChanged: _onChanged1),
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Código postal',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Código postal requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cuidad',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Cuidad requerida';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Municipio',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Municipio requerido';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Estado',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Estado requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Colonia',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Colonia requerida';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
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
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Numero exterior',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Numero Exterior requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Numero interior',
            ),
          ),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Teléfono',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Teléfono requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tipo',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Tipo requerido';
              }
            },
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {}
    print('Form submitted');
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
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
}

class ReferenceData extends StatelessWidget {
  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    /*setState(() {
      _selectedChoice = choice;
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referencia'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: ReferencesAddForm(),
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
