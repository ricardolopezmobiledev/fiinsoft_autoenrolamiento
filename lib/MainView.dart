import 'package:fiinsoft_autoenrolamiento/Afilicacion.dart';
import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/RegisterForm.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AppStatusTable.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';

class MainView extends StatelessWidget {
  final forkey = GlobalKey<FormState>();
  var contextGlob;
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
                            contextGlob = context;
                            getAppStatus();
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

  void getAppStatus() async{
    print("tapraptaptap");
    var status  = await AppStatusTable.db.getAllAppStatus();
    if(status.length == 0)
      _showDialog(contextGlob);
    else if(status[0].id_status == 1){
      Navigator.push(
          contextGlob, MaterialPageRoute(builder: (context) => Seguimiento()));
    }
    else if(status[0].id_status == 2){
      Navigator.push(
          contextGlob, MaterialPageRoute(builder: (context) => ListViewEx()));
    }
  }
}
