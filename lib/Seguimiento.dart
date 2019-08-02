import 'package:flutter/material.dart';
import 'RegisterPersonDialog.dart';

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
                      child: new GestureDetector(
                        child: Container(
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => RegisterPersonDialog(),
                          );
                        },
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
