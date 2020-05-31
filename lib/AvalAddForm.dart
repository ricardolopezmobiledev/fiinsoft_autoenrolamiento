import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'Model/Objects/Address.dart';
import 'Model/Objects/Choise.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Utils/RequestUtil.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;

import 'Model/Objects/Documento.dart';
import 'Model/Objects/Persona.dart';
import 'Model/db/DocumentosTable.dart';
import 'Model/db/PersonasTable.dart';

class AvalAddForm extends StatefulWidget {
  const AvalAddForm({Key key}) : super(key: key);

  @override
  _AvalAddFormState createState() => _AvalAddFormState();
}

class _AvalAddFormState extends State<AvalAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  int _n = 0;
  bool _value1 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);
  TextEditingController _controllerNombre;
  TextEditingController _controllerAP;
  TextEditingController _controllerAM;
  TextEditingController _controllerRFC;
  TextEditingController _controllerCURP;
  TextEditingController _controllerCP;
  TextEditingController _controllerCiudad;
  TextEditingController _controllerColonia;
  TextEditingController _controllerMunicipio;

  List<Documento> documentos = new List();

  List _States = [
    "AGUASCALIENTES",
    "BAJA CALIFORNIA NORTE",
    "BAJA CALIFORNIA SORTE",
    "CAMPECHE",
    "Ciudad de México",
    "CHIHUAHUA",
    "CHIAPAS",
    "COAHUILA",
    "COLIMA",
    "DURANGO",
    "GUERRERO",
    "GUANAJUATO",
    "HIDALGO",
    "JALISCO",
    "MÉXICO",
    "MICHOACÁN",
    "MORELOS",
    "NAYARIT",
    "NUEVO LEÓN",
    "OAXACA",
    "PUEBLA",
    "QUERÉTARO",
    "QUINTANA ROO",
    "SINALOA",
    "SLP",
    "SONORA",
    "TABASCO",
    "TAMAULIPAS",
    "TLAXCALA",
    "VERACRUZ",
    "YUCATAN",
    "ZACATECAS"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItemsStates;
  String _selectedTypeStates;

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(
      List typeCredits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String typeCredit in typeCredits) {
      items.add(
          new DropdownMenuItem(value: typeCredit, child: new Text(typeCredit)));
    }
    return items;
  }

  DateTime selectedDate = DateTime.now();
  String fecha_nacimiento = "                                      ";
  String strCodigoPostal;
  String strCiudad;
  String strMunicipio;
  String strEstado;
  String strColonia;
  String strCalle;
  String strNumeroExt;
  String strNumeroInt;

  @override
  void initState() {
    super.initState();
    Documento ine_frontal = Documento(
        nombre: 'INE FRONTAL',
        status: 'Selected',
        path: ''
    );
    Documento ine_reverso = Documento(
        nombre: 'INE REVERSO',
        status: 'Selected',
        path: ''
    );
    Documento CC = Documento(
        nombre: 'CARTA DE AUTORIZACION',
        status: 'Selected',
        path: ''
    );

    documentos.add(ine_frontal);
    documentos.add(ine_reverso);
    documentos.add(CC);
    _dropDownMenuItemsStates = buildAndGetDropDownMenuItems(_States);
    _selectedTypeStates = _dropDownMenuItemsStates[0].value;
    _controllerNombre = new TextEditingController();
    _controllerAP = new TextEditingController();
    _controllerAM = new TextEditingController();
    _controllerRFC = new TextEditingController();
    _controllerCURP = new TextEditingController();
    _controllerCP = new TextEditingController();
    _controllerCiudad = new TextEditingController();
    _controllerColonia = new TextEditingController();
    _controllerMunicipio = new TextEditingController();
    _controllerCP.addListener(Response);
  }

  void Response() async{
    if(_controllerCP.text.length == 5){
      await RequestUtil().getResponseFromService('https://www.fiinsoft.mx/Finsoft.WebAPI.Originacion.Test/fiinsoftapi/Asentamientos/GetList', {'cp': _controllerCP.text});
      String response = globals.temporalPath;
      var jsonResponse = json.decode(response);
      var jsonDataArray = jsonResponse['Data'];
      var jsonData = jsonDataArray[0];
      String colonia = jsonData['asentamiento'];
      String estado = jsonData['entidad_federativa'];
      String cd = jsonData['ciudad'];
      if(cd == '“”') cd = 'especifique';
      String municipio = jsonData['municipio'];
      setState(() {
        _controllerCiudad.text = cd;
        _controllerColonia.text = colonia;
        _controllerMunicipio.text = municipio;
        /*_selectedTypeStates = estado;*/
        _selectedTypeStates = estado;
      });
    }
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
  Widget build(BuildContext context) {

    void changedDropDownState(String selectedTypeCred) {
      setState(() {
        _selectedTypeStates = selectedTypeCred;
      });
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            controller: _controllerRFC,
            decoration: const InputDecoration(
              labelText: 'RFC',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'RFC requerido';
              }
            },
          ),
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            controller: _controllerCURP,
            decoration: const InputDecoration(
              labelText: 'CURP',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CURP requerido';
              }
            },
          ),
          SizedBox(
            width: 1000.0,
            height: 10.0,
            child: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Text('Declara que NO es colaborador de la institución o tienes algún familiar en esta institución.'),
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
            width: 1000.0,
            height: 10.0,
            child: null,
          ),
          SizedBox(
            height: 150,
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
          TextFormField(
            maxLength: 5,
            controller: _controllerCP,
            inputFormatters: [
              new UpperCaseTextFormatter()
            ],
            decoration: const InputDecoration(
              labelText: 'Código postal',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Código postal requerido';
              } else {
                strCodigoPostal = value;
              }
            },
          ),
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            controller: _controllerCiudad,
            decoration: const InputDecoration(
              labelText: 'Cuidad',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Cuidad requerida';
              } else {
                strCiudad = value;
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            controller: _controllerMunicipio,
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Municipio',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Municipio requerido';
              } else {
                strMunicipio = value;
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          const SizedBox(height: 16.0),
          Text("Estado"),
          DropdownButton(
            isExpanded: true,
            value: _selectedTypeStates,
            items: _dropDownMenuItemsStates,
            onChanged: changedDropDownState,
          ),
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            controller: _controllerColonia,
            decoration: const InputDecoration(
              labelText: 'Colonia',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Colonia requerida';
              } else {
                strColonia = value;
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Calle',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Calle requerida';
              } else {
                strCalle = value;
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Numero exterior',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Numero Exterior requerido';
              } else {
                strNumeroExt = value;
              }
            },
          ),
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Numero interior',
            ),
            onSaved: (String value) {
              strNumeroInt = value;
            },
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async{
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      bool docs = true;
      for(int i = 0; i<documentos.length; i++){
        if(documentos[i].path == ''){
          docs = false;
          break;
        }
      }
      if(docs){
        Address newAddress = new Address(
          cp: strCodigoPostal,
          ciudad: strCiudad,
          municipio: strMunicipio,
          estado: _selectedTypeStates,
          colonia: strColonia,
          calle: strCalle,
          num_exterior: strNumeroExt,
          num_interior: strNumeroInt,
        );
        Persona newPersona = new Persona(
            nombre: _controllerNombre.text,
            ap_paterno: _controllerAP.text,
            ap_materno: _controllerAM.text,
            fecha_de_nacimiento: fecha_nacimiento,
            rfc: _controllerRFC.text,
            curp: _controllerCURP.text,
            address: newAddress
        );
        int id_presona = await PersonaTable.db.newPersona(newPersona);
        for(Documento documento in documentos){
          documento.id_persona = id_presona;
          await DocumentoTable.db.newDocumento(documento);
        }
        Navigator.pop(context);
      }else Toast.show("Todos los documentos son necesarios.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
    print('Form submitted');
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
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

}





class AvalData extends StatelessWidget {
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
        title: const Text('Aval'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: AvalAddForm(),
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
