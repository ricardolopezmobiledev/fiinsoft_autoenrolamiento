import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'Model/Objects/Choise.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/RequestUtil.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;
import 'dart:convert';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Trabajo.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/TrabajosTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Phone.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';

import 'Model/db/AddressTable.dart';
import 'Model/db/PhonesTable.dart';

class DatosLaboralesForm extends StatefulWidget {
  const DatosLaboralesForm({Key key}) : super(key: key);

  @override
  _DatosLaboralesFormState createState() => _DatosLaboralesFormState();
}

class _DatosLaboralesFormState extends State<DatosLaboralesForm> {

  TextEditingController _controllerEmpresa;
  TextEditingController _controllerPuesto;
  TextEditingController _controllerSueldo;
  TextEditingController _controllerPhone;

  String strCodigoPostal;
  String strCiudad;
  String strMunicipio;
  String strEstado;
  String strColonia;
  String strCalle;
  String strNumeroExt;
  String strNumeroInt;

  TextEditingController _controllerCP;
  TextEditingController _controllerCiudad;
  TextEditingController _controllerColonia;
  TextEditingController _controllerCalle;
  TextEditingController _controllerExt;
  TextEditingController _controllerInt;
  TextEditingController _controllerMunicipio;
  TextEditingController phoneController;

  List _typePhones = ["Celular", "Fijo", "Trabajo"];
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
  String _selectedTypePhones;
  String _selectedTypeStates;
  List<DropdownMenuItem<String>> _dropDownMenuItemsPhones;
  List<DropdownMenuItem<String>> _dropDownMenuItemsStates;


  Trabajo trabajoData;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool _value1 = false;
  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);
  int _n = 0;

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(
      List typeCredits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String typeCredit in typeCredits) {
      items.add(
          new DropdownMenuItem(value: typeCredit, child: new Text(typeCredit)));
    }
    return items;
  }


  @override
  void initState(){
    super.initState();
    _controllerEmpresa = new TextEditingController();
    _controllerPuesto = new TextEditingController();
    _controllerSueldo = new TextEditingController();
    _controllerPhone = new TextEditingController();
    _controllerPhone = new MaskedTextController(mask: '00-0000-0000');
    _dropDownMenuItemsPhones = buildAndGetDropDownMenuItems(_typePhones);
    _selectedTypePhones = _dropDownMenuItemsPhones[0].value;
    _dropDownMenuItemsStates = buildAndGetDropDownMenuItems(_States);
    _selectedTypeStates = _dropDownMenuItemsStates[0].value;
    _controllerCP = new TextEditingController();
    _controllerCiudad = new TextEditingController();
    _controllerColonia = new TextEditingController();
    _controllerCalle = new TextEditingController();
    _controllerInt = new TextEditingController();
    _controllerExt = new TextEditingController();
    _controllerMunicipio = new TextEditingController();
    _controllerCP.addListener(Response);
    getDataFromDB();
  }

  void updateUser() async{
    Address address = Address(
      cp: _controllerCP.text,
      ciudad: _controllerCiudad.text,
      municipio: _controllerMunicipio.text,
      estado: _selectedTypeStates,
      colonia: _controllerColonia.text,
      calle: _controllerCalle.text,
      id: 2,
      num_exterior: _controllerExt.text,
      num_interior: _controllerInt.text,
    );
    Phone phones = Phone(
      numero: _controllerPhone.text,
      id: 2,
      id_persona: 1,
      tipo: _selectedTypePhones,
    );
    Trabajo trabajo = new Trabajo(
      id_persona: 1,
      id: 1,
      empresa: _controllerEmpresa.text,
      puesto: _controllerPuesto.text,
      sueldo: _controllerSueldo.text,
      menos_anio: _value2,
      antiguedad: _n,
      phone: phones,
      address: address,
    );
    Trabajo trabajoOk = await TrabajoTable.db.getTrabajo(1);
    if(trabajoOk == null){
      await TrabajoTable.db.newTrabajo(trabajo);
    }else{
      await TrabajoTable.db.updateTrabajo(trabajo);
    }
  }
  void getDataFromDB() async{
    trabajoData = await TrabajoTable.db.getTrabajo(1);
    trabajoData.address = await AddresssTable.db.getAddress(2);
    trabajoData.phone = await PhonesTable.db.getPhone(2);
    if(trabajoData != null){
      if(trabajoData.empresa != null) _controllerEmpresa.text = trabajoData.empresa;
      if(trabajoData.puesto != null) _controllerPuesto.text = trabajoData.puesto;
      if(trabajoData.sueldo != null) _controllerSueldo.text = trabajoData.sueldo;
      if(trabajoData.phone != null) _controllerPhone.text = trabajoData.phone.numero;
      if(trabajoData.address != null) _controllerCP.text = trabajoData.address.cp;
      if(trabajoData.address != null) _controllerCiudad.text = trabajoData.address.ciudad;
      if(trabajoData.address != null) _controllerMunicipio.text = trabajoData.address.municipio;
      if(trabajoData.address != null) _controllerColonia.text = trabajoData.address.colonia;
      if(trabajoData.address != null) _controllerCalle.text = trabajoData.address.calle;
      if(trabajoData.address != null) _controllerInt.text = trabajoData.address.num_interior;
      if(trabajoData.address != null) _controllerExt.text = trabajoData.address.num_exterior;
      setState(() {
        _value2 = trabajoData.menos_anio;
        _n = trabajoData.antiguedad;
        if(trabajoData.phone != null) _selectedTypePhones = trabajoData.phone.tipo;
        if(trabajoData.address != null) _selectedTypeStates = trabajoData.address.estado;
      });
    }
  }

  void changedDropDownItemPhone(String selectedTypeCred) {
    setState(() {
      _selectedTypePhones = selectedTypeCred;
    });
  }
  void changedDropDownState(String selectedTypeCred) {
    setState(() {
      _selectedTypeStates = selectedTypeCred;
    });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          updateUser();
          print('returnPressed');
//          Navigator.pop(context,'refresh');
          return true;
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _controllerEmpresa,
                decoration: const InputDecoration(
                  labelText: 'Empresa',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'El nombre de la empresa es requerido';
                  }
                },
              ),
              TextFormField(
                controller: _controllerPuesto,
                decoration: const InputDecoration(
                  labelText: 'Puesto',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'El puesto es requerido';
                  }
                },
              ),
              TextFormField(
                controller: _controllerSueldo,
                decoration: const InputDecoration(
                  labelText: 'Sueldo',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'El sueldo es requerido';
                  }
                },
              ),
              new SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                title: new Text('Menos de un año',
                    style: new TextStyle(color: Colors.black)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text('Antigüedad'),
                    flex: 1,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: FloatingActionButton(
                              heroTag: "btn1",
                              onPressed: minus,
                              child: new Icon(
                                  const IconData(0xe15b,
                                      fontFamily: 'MaterialIcons'),
                                  color: Colors.black),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: new Text('$_n',
                              textAlign: TextAlign.center,
                              style: new TextStyle(fontSize: 25.0)),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: add,
                              child: new Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
              TextFormField(
                controller: _controllerPhone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'El telefono es requerido';
                  }
                },
              ),
              const SizedBox(height: 25.0),
              Text("Tipo de teléfono"),
              DropdownButton(
                isExpanded: true,
                value: _selectedTypePhones,
                items: _dropDownMenuItemsPhones,
                onChanged: changedDropDownItemPhone,
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
                controller: _controllerCalle,
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
                controller: _controllerExt,
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
                controller: _controllerInt,
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
            ],
          ),
        )
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

class ContactLaboralData extends StatelessWidget {
  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Laborales'),
        leading: IconButton(
          icon: Icon(Icons.looks_two),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: DatosLaboralesForm(),
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
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}