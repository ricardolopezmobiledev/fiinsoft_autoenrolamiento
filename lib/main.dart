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
      home: MyHomePage(title: 'Hola Mundo!'),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/splash.jpg"), fit: BoxFit.cover),
      ),
      child:  new Container(
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
                    child: new Image(image: new AssetImage("assets/logo_splash.png")),
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
                        child : TextFormField(
                          decoration: InputDecoration(
                              hintText: "Usuario"
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Usuario vacio';
                            }
                          },
                          onSaved: (input) => _email = input,
                        ),
                    ),
                    flex: 1,
                  ),new Expanded(
                    child: new Card(
                        child : TextFormField(
                          decoration: InputDecoration(
                              hintText: "contraseña"
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
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
                      child : null,
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
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          if (forkey.currentState.validate()) {
                            forkey.currentState.save();
                            _GetLoginAndChangeView();
                          }
                        },
                        child: const Text(
                            'INGRESAR',
                            style: TextStyle(fontSize: 13)
                        ),
                      ),
                    ),
                    flex: 1,
                  ),new Expanded(
                    child: new Card(
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {},
                        child: const Text(
                            'CREA TU CUENTA, AFILIATE AQUÍ',
                            style: TextStyle(fontSize: 13)
                        ),
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
                      child : null,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ])
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Regresar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
