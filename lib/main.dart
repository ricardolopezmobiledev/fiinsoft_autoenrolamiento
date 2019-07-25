import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final forkey = GlobalKey<FormState>();
  String _email, _password;

  void _GetLoginAndChangeView() {
    print(_email);
    print(_password);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/splash.jpg"), fit: BoxFit.cover),
      ),
      child: new Container(
          child: Column(children: <Widget>[
        new Expanded(
          child: new Container(
            child: Row(
              children: [
                new Expanded(
                  child: new Container(
                    child: null,
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Image(
                      image: new AssetImage("assets/logo_splash.png")),
                  flex: 2,
                ),
                new Expanded(
                  child: new Container(
                    child: null,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          flex: 8,
        ),
        new Expanded(
          child: Form(
            key: forkey,
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Usuario"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Usuario vacio';
                        }
                      },
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Card(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "contraseña"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Contraseña vacia';
                        }
                      },
                      onSaved: (input) => _password = input,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: null,
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        if (forkey.currentState.validate()) {
                          forkey.currentState.save();
                          _GetLoginAndChangeView();
                        }
                      },
                      child: const Text('INGRESAR',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Card(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {},
                      child: const Text('CREA TU CUENTA, AFILIATE AQUÍ',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: null,
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 1,
        ),
      ])),
    );
  }
}

class MainView extends StatelessWidget {
  final forkey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/splash_main.jpg"), fit: BoxFit.cover),
      ),
      child: new Container(
          child: Column(children: <Widget>[
        new Expanded(
          child: new Container(
            child: Row(
              children: [
                new Expanded(
                  child: Column(children: [
                    new Expanded(
                      child: new Container(
                        child: new Image(
                            width: 150,
                            height: 150,
                            image: new AssetImage("assets/logo_splash.png")),
                      ),
                      flex: 5,
                    ),
                    new Expanded(
                      child: new Container(
                          child: new Material(
                        color: Colors.transparent,
                        child: Text(
                          'SERGIO ELIZONDO',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                      flex: 1,
                    ),
                    new Expanded(
                      child: new Container(
                          child: new Material(
                        color: Colors.transparent,
                        child: Text(
                          '1.0',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                      flex: 1,
                    ),
                  ]),
                  flex: 2,
                ),
              ],
            ),
          ),
          flex: 4,
        ),
        new Expanded(
          child: new Container(
            child: Column(children: <Widget>[
              new Expanded(
                child: new Container(
                  child: Row(
                    children: [
                      new Expanded(
                        child: new GestureDetector(
                          onTap: () {
                            print("tapraptaptap");
                          },
                          child: new Container(
                            margin:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    child: new Image(
                                        height: 100,
                                        width: 100,
                                        image: new AssetImage(
                                            "assets/tareas.png")),
                                  ),
                                  flex: 2,
                                ),
                                new Expanded(
                                  child: new Material(
                                    child: Text(
                                      'TAREAS',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      new Expanded(
                        child: new GestureDetector(
                          onTap: () {
                            print("tapraptaptap");
                            _showDialog(context);
                          },
                          child: new Container(
                            child: new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Container(
                                      child: new Image(
                                          height: 100,
                                          width: 100,
                                          image: new AssetImage(
                                              "assets/solicitudes.png")),
                                    ),
                                    flex: 2,
                                  ),
                                  new Expanded(
                                    child: new Material(
                                      child: Text(
                                        'SOLICITUDES',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                flex: 4,
              ),
              new Expanded(
                child: new Container(
                  child: new Container(
                    child: Row(
                      children: [
                        new Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    child: new Image(
                                        height: 100,
                                        width: 100,
                                        image: new AssetImage(
                                            "assets/estado_cuenta.png")),
                                  ),
                                  flex: 2,
                                ),
                                new Expanded(
                                  child: new Material(
                                    child: Text(
                                      'ESTADO DE CUENTA',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        new Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    child: new Image(
                                        height: 100,
                                        width: 100,
                                        image: new AssetImage(
                                            "assets/promociones.png")),
                                  ),
                                  flex: 2,
                                ),
                                new Expanded(
                                  child: new Material(
                                    child: Text(
                                      'PROMOCIONES',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 4,
              ),
            ]),
          ),
          flex: 6,
        ),
      ])),
    );
  }

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(
              "Aún no tiene solicitudes, ¿Desea crear una nueva solicitud?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("SI"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactData()));
              },
            ),
          ],
        );
      },
    );
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Guardar', icon: Icons.directions_car),
  const Choice(title: 'Salir', icon: Icons.directions_bike),
  const Choice(title: 'Guardar', icon: Icons.directions_car),
  const Choice(title: 'Salir', icon: Icons.directions_bike),
];

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
          /*const SizedBox(height: 16.0),*/
          /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),*/
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
    if(_formKey.currentState.validate()){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Seguimiento()));

    }
    print('Form submitted');
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

class Seguimiento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('Seguimiento'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: new Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new Container(
            color: Colors.blue,
            child: new Column(
              children: <Widget>[
                Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: new Image(
                                image: new AssetImage("assets/ic_profile.png")),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            child: new Column(
                              children: <Widget>[
                                Expanded(
                                  child: new Container(
                                    child: null,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      child: Text("SERGIO ELIZONDO GOMEZ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      child: Text("Justo ahora",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          flex: 4,
                        ),
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    color: Colors.blue,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: new Container(
                    color: Color(0xfff7f7f7),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                      child: new Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Image(
                                width: 40,
                                height: 40,
                                image:
                                    new AssetImage("assets/beginprocess.png")),
                            new Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: new Text('Iniciar proceso',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: new Container(
                    color: Color(0xfff7f7f7),
                    child: new Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Status:",
                                ),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            child: new Container(
                                child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 0,
                                        /*groupValue: _radioValue1,
                                            onChanged: _handleRadioValueChange1,*/
                                      ),
                                      new Text(
                                        'Frío',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                      new Radio(
                                        value: 1,
                                        /*groupValue: _radioValue1,
                                            onChanged: _handleRadioValueChange1,*/
                                      ),
                                      new Text(
                                        'Tibio',
                                        style: new TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      new Radio(
                                        value: 2,
                                        /*groupValue: _radioValue1,
                                            onChanged: _handleRadioValueChange1,*/
                                      ),
                                      new Text(
                                        'Caliente',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ])),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Divider(
                          height: 5.0,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Acciones realizadas",
                                ),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            child: null,
                          ),
                          flex: 10,
                        ),
                      ],
                    ),
                    color: Color(0xfff7f7f7),
                  ),
                  flex: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
