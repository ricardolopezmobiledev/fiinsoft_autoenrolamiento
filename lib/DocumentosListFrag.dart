import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Model/Objects/Choise.dart';
import 'Model/Objects/Documento.dart';
import 'Model/Objects/Persona.dart';
import 'Model/db/DocumentosTable.dart';
import 'Model/db/PersonasTable.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;
import 'dialogs/DocumentView.dart';

class DocumentosForm extends StatefulWidget {
  const DocumentosForm({Key key}) : super(key: key);

  @override
  _DocumentosFormState createState() => _DocumentosFormState();
}

class _DocumentosFormState extends State<DocumentosForm> {

  List<Documento> documentos = new List();
  Persona persona;

  @override
  void initState(){
    super.initState();
    getDataFromDB();
  }

  void getDataFromDB() async{
    persona = await PersonaTable.db.getPersona(1);
    setState(() {
      documentos = persona.documentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
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
                        child: Text(documento.nombre),
                        flex: 5,
                      ),
                      Expanded(
                        child: Icon(Icons.camera_alt),
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
    );
  }

  void onTappedDocumento(Documento documento) async {
    if(documento.path == ''){
      switch (await takePhoto(context)) {
        case "take":
          var images = await ImagePicker.pickImage(source: ImageSource.camera);
          documento.path = images.path;
          await DocumentoTable.db.updateDocumento(documento);
          break;

        case "pick":
          var images = await ImagePicker.pickImage(source: ImageSource.gallery);
          documento.path = images.path;
          await DocumentoTable.db.updateDocumento(documento);
          break;
      }
    }else{
      switch (await UpdateOrViewPhoto(context)) {
        case "take":
          switch (await takePhoto(context)) {
            case "take":
              var images = await ImagePicker.pickImage(source: ImageSource.camera);
              documento.path = images.path;
              await DocumentoTable.db.updateDocumento(documento);
              break;

            case "pick":
              var images = await ImagePicker.pickImage(source: ImageSource.gallery);
              documento.path = images.path;
              await DocumentoTable.db.updateDocumento(documento);
              break;
          }
          break;
        case "view":
          globals.pathFile = await documento.path;
          showDialog(
            context: context,
            builder: (_) => DocumentView(),
          );
          break;
      }
    }
  }

  takePhoto(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            title: Text("Elegir Documento"),
            content: SizedBox(
              height: 110,
              child: Container(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Tomar foto"),
                            onTap: () => Navigator.pop(ctxt, "take"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Elegir de galeria"),
                            onTap: () => Navigator.pop(ctxt, "pick"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Cancelar"),
                            onTap: () => Navigator.pop(ctxt, "cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
  UpdateOrViewPhoto(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            title: Text("Actualizar"),
            content: SizedBox(
              height: 110,
              child: Container(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Ver Actual"),
                            onTap: () => Navigator.pop(ctxt, "view"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Tomar Nueva"),
                            onTap: () => Navigator.pop(ctxt, "take"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Cancelar"),
                            onTap: () => Navigator.pop(ctxt, "cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class DocumentosData extends StatelessWidget {
  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DocumentosForm(),
    );
  }
}