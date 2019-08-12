import 'package:flutter/material.dart';
import 'Afilicacion.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PersonasTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/DocumentosTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AppStatusTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/AppStatus.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Persona.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Documento.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'package:camera/camera.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPersonDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPersonDialogState();
}

class RegisterPersonDialogState extends State<RegisterPersonDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nombre;
  String ap_paterno;
  String ap_materno;
  String fecha_nacimiento = "                                      ";
  String rfc;
  Persona persona;
  AnimationController controller;
  Animation<double> scaleAnimation;
  TextEditingController _controllerNombre;
  TextEditingController _controllerAP;
  TextEditingController _controllerAM;
  List<Documento> documentos = new List();
  BuildContext cntext;


  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);
  void _onChanged3(bool value) => setState(() => _value3 = value);
  DateTime selectedDate = DateTime.now();

  Future<void> _getPersonas() async {
    persona = await PersonaTable.db.getPersona(1);
    Documento ine_frontal = Documento(
        nombre: 'INE FRONTAL',
        id_persona: persona.id,
        status: 'Selected',
        path: ''
    );
    Documento ine_reverso = Documento(
        nombre: 'INE REVERSO',
        id_persona: persona.id,
        status: 'Selected',
        path: ''
    );
    Documento CC = Documento(
        nombre: 'CARTA DE AUTORIZACION',
        id_persona: persona.id,
        status: 'Selected',
        path: ''
    );

    persona.documentos.add(ine_frontal);
    persona.documentos.add(ine_reverso);
    persona.documentos.add(CC);
    documentos = persona.documentos;
    setState(() {
      _controllerNombre.text = persona.nombre.toUpperCase();
      _controllerAP.text = persona.ap_paterno.toUpperCase();
      _controllerAM.text = persona.ap_materno.toUpperCase();
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        int day = selectedDate.day;
        int month = selectedDate.month;
        int year = selectedDate.year;
        fecha_nacimiento = '$day/$month/$year';
      });
  }

  @override
  void initState() {
    super.initState();
    _controllerNombre = new TextEditingController();
    _controllerAP = new TextEditingController();
    _controllerAM = new TextEditingController();
    _getPersonas();
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
    cntext = context;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        inputFormatters: [
                          new UpperCaseTextFormatter(),
                        ],
                        controller: _controllerNombre,
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
                        inputFormatters: [
                          new UpperCaseTextFormatter(),
                        ],
                        controller: _controllerAP,
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
                        inputFormatters: [
                          new UpperCaseTextFormatter(),
                        ],
                        controller: _controllerAM,
                        decoration: const InputDecoration(
                          labelText: 'Apellido Materno',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Apellido Materno requerido';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: new Container(
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "Fecha de nacimiento",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        fecha_nacimiento,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        inputFormatters: [
                          new UpperCaseTextFormatter(),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'RFC',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'RFC requerido';
                          }else{
                            rfc = value;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: new Text(
                                'Tiene experiencia igual o mayor a 2 años'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: null,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: new Switch(
                                value: _value1, onChanged: _onChanged1),
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
                            child: new Text(
                                'Declara que no es colaborador y no tiene algún familiar en esta institución'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: null,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: new Switch(
                                value: _value2, onChanged: _onChanged2),
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
                            child: new Text(
                                'Declara que su ocupación no es Policía, Militar, Guardia de seguridad, Abogado, Stripper, Bombero, Operativo de energía eléctrica.'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: null,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: new Switch(
                                value: _value3, onChanged: _onChanged3),
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
                                    validateSaveSend();
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
      ),
    );
  }

  void validateSaveSend() async{
    /*persona = await PersonaTable.db.getPersona(1);*/
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      bool docs = true;
      for(int i = 0; i<persona.documentos.length; i++){
        if(persona.documentos[i].path == ''){
          docs = false;
          break;
        }
      }
      if(docs){
        Persona personaFinal = persona;
        personaFinal.fecha_de_nacimiento = fecha_nacimiento;
        personaFinal.rfc = rfc;
        personaFinal.isCollaborator = _value2;
        personaFinal.hasExperience = _value1;
        personaFinal.hasDangerousWork = _value3;
        await DocumentoTable.db.newDocumento(personaFinal.documentos[0]);
        await DocumentoTable.db.newDocumento(personaFinal.documentos[1]);
        await DocumentoTable.db.newDocumento(personaFinal.documentos[2]);
        await PersonaTable.db.updatePersona(personaFinal);
        AppStatus appStatus = await AppStatusTable.db.getAppStatus(1);
        appStatus.id_status = 2;
        appStatus.name = 'Consulta CC';
        await  AppStatusTable.db.updateAppStatus(appStatus);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ListViewEx()));
      }else{
        Toast.show("Todos los documentos son necesarios.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
  }

  void onTappedDocumento(Documento documento) async{
    switch(await takePhoto(context)){
      case "take":
        var images = await ImagePicker.pickImage(source: ImageSource.camera);
        documento.path = images.path;
        break;

      case "pick":
        var images = await ImagePicker.pickImage(source: ImageSource.gallery);
        documento.path = images.path;
        break;
    }
  }
}

takePhoto(BuildContext context){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctxt){
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
                          onTap: ()=> Navigator.pop(ctxt, "take"),
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
                          onTap: ()=> Navigator.pop(ctxt, "pick"),
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
                          onTap: ()=> Navigator.pop(ctxt, "cancel"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
  );
}

/*
const List<Documento> documentos = const <Documento>[
  const Documento(Nombre_Doc: 'INE FRONTAL', icono: Icon(Icons.camera_alt)),
  const Documento(Nombre_Doc: 'INE REVERSO', icono: Icon(Icons.file_upload)),
  const Documento(
      Nombre_Doc: 'CARTA AUTORIZACIÓN', icono: Icon(Icons.file_upload)),
];



class Documento {
  const Documento({this.Nombre_Doc, this.icono});

  final String Nombre_Doc;
  final Icon icono;
}
*/
