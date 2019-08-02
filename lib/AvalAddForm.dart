import 'package:flutter/material.dart';
import 'Model/Objects/Choise.dart';

class AvalAddForm extends StatefulWidget {
  const AvalAddForm({Key key}) : super(key: key);

  @override
  _AvalAddFormState createState() => _AvalAddFormState();
}

class _AvalAddFormState extends State<AvalAddForm> {
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
              labelText: 'Fecha de nacimiento',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Fecha de nacimiento requerida';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'RFC',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'RFC requerido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'CURP',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CURP requerido';
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
                child: new Text('Declara que NO es colaborador de la institución o tienes algún familiar en esta institución.'),
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
          SizedBox(
            height: 150,
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
                              child: Text(documento.Nombre_Doc),
                              flex: 5,
                            ),

                            Expanded(
                              child: documento.icono,
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

const List<Documento> documentos = const <Documento>[
  const Documento(Nombre_Doc: 'INE FRONTAL', icono: Icon(Icons.camera_alt)),
  const Documento(Nombre_Doc: 'INE REVERSO', icono: Icon(Icons.file_upload)),
  const Documento(Nombre_Doc: 'CARTA AUTORIZACIÓN', icono: Icon(Icons.file_upload)),
];

void onTappedDocumento(Documento documento) {}

class Documento {
  const Documento({this.Nombre_Doc, this.icono});

  final String Nombre_Doc;
  final Icon icono;
}

class AvalData extends StatelessWidget {
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
        title: const Text('Aval'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: AvalAddForm(),
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
