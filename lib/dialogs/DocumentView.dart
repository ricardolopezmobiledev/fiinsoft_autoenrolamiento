import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;

class DocumentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DocumentViewState();
}

class DocumentViewState extends State<DocumentView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String path;
  AnimationController controller;
  Animation<double> scaleAnimation;
  
  @override
  void initState() {
    path = globals.pathFile;
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
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
              height: 450.0,

              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 0.0, right: 0.0),
                      child: Image.file(new File(path)),

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
                                    Navigator.pop(context);
                                  }
                                },
                              )),
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
