import 'package:flutter/material.dart';
import 'Afilicacion.dart';

class RegisterPersonDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPersonDialogState();
}

class RegisterPersonDialogState extends State<RegisterPersonDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  bool _value1 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textstyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    final InputDecoration decoration = InputDecoration(
      border: OutlineInputBorder(),
    );
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: 550.0,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre(s)',
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'El nombre requerido';
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Apellido Paterno',
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Apellido paterno requerido';
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Apellido Materno',
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Apellido Materno requerido';
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Fecha de nacimiento',
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Fecha de necimiento requerida';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: new Text('Tiene experiencia igual o mayor a 2 años'),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: new Text('Declara que no es colaborador y no tiene algún familiar en esta institución'),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: new Text('Declara que su ocupación no es Policía, Militar, Guardia de seguridad, Abogado, Stripper, Bombero, Operativo de energía eléctrica.'),
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
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                splashColor: Colors.white.withAlpha(40),
                                child: Text(
                                  'Aceptar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewEx()));
                                  });
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

