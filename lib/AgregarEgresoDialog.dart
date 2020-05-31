import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'Model/Objects/Egreso.dart';
import 'Model/db/EgresosTable.dart';

class AgregarEgresoDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AgregarEgresoDialogState();
}

class AgregarEgresoDialogState extends State<AgregarEgresoDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  String concepto, monto;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Form(child: Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 290.0,

              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            inputFormatters: [
                              new UpperCaseTextFormatter(),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Concepto',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'El concepto es requerida';
                              }else concepto = value;
                            },
                          ),
                          TextFormField(
                            inputFormatters: [
                              new UpperCaseTextFormatter(),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Monnto mensual',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'El monto es requerido';
                              }else monto = value;
                            },
                          ),
                        ],
                      ),

                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Row(
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
                                onPressed: () async{
                                  _formKey.currentState.validate();
                                  if (_formKey.currentState.validate()) {
                                    if(concepto != null && monto != null ){
                                      Egreso newEgreso = new Egreso(
                                        concepto: concepto,
                                        monto_mensual: monto,
                                      );
                                      await EgresosTable.db.newEgreso(newEgreso);
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                            child:  ButtonTheme(
                                height: 35.0,
                                minWidth: 110.0,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    'Cancelar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ))
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              )),
        ),
      ),
    ),key: _formKey,);
  }
}