import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';

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
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Producto',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Producto Requerido';
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
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
        title: const Text('Solicitud'),
        actions: <Widget>[
          // action button
          /*IconButton(
              icon: Icon(choices[0].icon),
              onPressed: () {
                _select(choices[0]);
              },
            ),
            // action button
            IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                _select(choices[1]);
              },
            ),*/
          // overflow menu
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
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
