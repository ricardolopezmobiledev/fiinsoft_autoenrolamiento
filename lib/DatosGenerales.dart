import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';
import 'Afilicacion.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

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
              labelText: 'Email',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email requerido';
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
              labelText: 'CURP',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CURP requerida';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Escolaridad',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Escolaridad requerida';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Teléfono',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Teléfono Requerido';
              }
            },
          ),
          SizedBox(
            width: 1000.0,
            height: 10.0,
            child: null,
          ),
          Text('Sexo'),
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
                  child: const Text('HOMRE', style: TextStyle(fontSize: 13)),
                ),
              ),
              SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {},
                    child: const Text('MUJER', style: TextStyle(fontSize: 13)),
                  )),
            ],
          ),
          SizedBox(
            width: 1000.0,
            height: 30.0,
            child: null,
          ),
          Text('Estado Civil'),
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
                  child: const Text('SOLTER@', style: TextStyle(fontSize: 13)),
                ),
              ),
              SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {},
                    child: const Text('VIUD@', style: TextStyle(fontSize: 13)),
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
                  child: const Text('CASAD@', style: TextStyle(fontSize: 13)),
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
                    child: const Text('DIVORSIAD@',
                        style: TextStyle(fontSize: 13)),
                  )),
            ],
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
          SizedBox(
            width: 1000.0,
            height: 30.0,
            child: null,
          ),
          Text('Estado Civil'),
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
                  child: const Text('TRABAJO', style: TextStyle(fontSize: 13)),
                ),
              ),
              SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {},
                    child: const Text('HOGAR', style: TextStyle(fontSize: 13)),
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
                  child: const Text('DESEMPLEADO', style: TextStyle(fontSize: 13)),
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
                    child: const Text('NEGOCIO PROPIO',
                        style: TextStyle(fontSize: 13)),
                  )),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ocupacion',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Ocupacion requerida';
              }
            },
          ),
          /*Row(
            children: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue)),
                onPressed: _submittable() ? _submit : null,
                child: const Text('GUARDAR', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),*/
        ],
      ),
    );
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

  Row add_radio_button(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.green,
          value: btnValue,
          groupValue: -1,
          onChanged: null,
        ),
        Text(title)
      ],
    );
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

class ContactData extends StatelessWidget {
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
        title: const Text('Datos Generales'),
        leading: IconButton(
          icon: Icon(Icons.looks_one),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RegisterForm(),
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
