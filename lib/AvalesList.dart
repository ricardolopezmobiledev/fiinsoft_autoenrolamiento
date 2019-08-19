import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';
import 'AvalAddForm.dart';
import 'Model/Objects/Persona.dart';
import 'Model/db/PersonasTable.dart';
import 'Model/db/PhonesTable.dart';

class AvalList extends StatefulWidget {
  const AvalList({Key key}) : super(key: key);

  @override
  _AvalListState createState() => _AvalListState();
}

class _AvalListState extends State<AvalList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool _value1 = false;
  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);
  int _n = 0;
  List<Persona> avales = new List();

  void getFromDB() async {
    avales = await PersonaTable.db.getAllPersona();
    avales.removeAt(0);
    for (Persona persona in avales) {
      /*persona.phone = await PhonesTable.db.getPhone(persona.idPhone)*/;
    }
    setState(() {
      avales;
    });
  }

  @override
  void initState() {
    super.initState();
    getFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var aval = avales[index];

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
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: new Text(aval.nombre +
                                            ' ' +
                                            aval.ap_paterno +
                                            ' ' +
                                            aval.ap_materno)),
                                  ),
                                  flex: 3,
                                ),
                                /*Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child: Align(alignment: Alignment.centerLeft, child: new Text(aval.parentesco, style: TextStyle(fontSize: 13),)),
                                  ),
                                  flex: 3,
                                ),*/
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: new Text(
                                          aval.rfc,
                                          style: TextStyle(fontSize: 11),
                                        )),
                                  ),
                                  flex: 3,
                                ),
                              ],
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            child: Icon(Icons.highlight_off),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () => onTappedReferencia(aval),
              );
            },
            itemCount: avales.length,
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                splashColor: Colors.white.withAlpha(40),
                child: Text(
                  'Agregar aval',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0),
                ),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AvalData()));
                  avales = await PersonaTable.db.getAllPersona();
                  avales.removeAt(0);
                  setState(() {
                    avales;
                  });
                },
              ),
            ],
          ),
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

class ListaDeAvales extends StatelessWidget {
  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avales'),
        leading: IconButton(
          icon: Icon(Icons.looks_5),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: AvalList(),
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

void onTappedReferencia(Persona aval) {}
