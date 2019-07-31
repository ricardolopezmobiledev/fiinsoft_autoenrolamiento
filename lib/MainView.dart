import 'package:flutter/material.dart';
import 'RegisterForm.dart';

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
                Navigator.push(context,
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
