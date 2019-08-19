import 'package:flutter/material.dart';
import 'Model/Objects/Address.dart';
import 'Model/Objects/Choise.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/RequestUtil.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;
import 'dart:convert';

import 'Model/Objects/Phone.dart';
import 'Model/Objects/Referencia.dart';
import 'Model/db/ReferenciasTable.dart';

class ReferencesAddForm extends StatefulWidget {
  const ReferencesAddForm({Key key}) : super(key: key);

  @override
  _ReferencesAddFormState createState() => _ReferencesAddFormState();
}

class _ReferencesAddFormState extends State<ReferencesAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  int _n = 0;
  bool _value1 = false;
  bool _value2 = false;
  List<DropdownMenuItem<String>> _dropDownMenuItemsStates;
  List<DropdownMenuItem<String>> _dropDownMenuItemsPhones;

  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);

  TextEditingController _controllerCP;
  TextEditingController _controllerCiudad;
  TextEditingController _controllerColonia;
  TextEditingController _controllerMunicipio;
  TextEditingController phoneController;
  String _selectedTypeStates;
  String _selectedTypePhones;

  String strCodigoPostal;
  String strCiudad;
  String strMunicipio;
  String strEstado;
  String strColonia;
  String strCalle;
  String strNumeroExt;
  String strNumeroInt;
  String strTelefono;

  TextEditingController _controllerNombre;
  TextEditingController _controllerApellidoP;
  TextEditingController _controllerApellidoM;
  TextEditingController _controllerParentesco;

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

  List _typePhones = ["Celular", "Fijo", "Trabajo"];

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(
      List typeCredits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String typeCredit in typeCredits) {
      items.add(
          new DropdownMenuItem(value: typeCredit, child: new Text(typeCredit)));
    }
    return items;
  }

  void updateUser() async {
    Address address = Address(
      cp: strCodigoPostal,
      ciudad: strCiudad,
      municipio: strMunicipio,
      estado: _selectedTypeStates,
      colonia: strColonia,
      calle: strCalle,
      num_exterior: strNumeroExt,
      num_interior: strNumeroInt,
    );
    Phone phones = Phone(
      numero: phoneController.text,
      tipo: _selectedTypePhones,
    );
    Referencia referencia = new Referencia(
      nombre: _controllerNombre.text,
      ap_paterno: _controllerApellidoP.text,
      ap_materno: _controllerApellidoM.text,
      parentesco: _controllerParentesco.text,
      address: address,
      phone: phones,
      menos_anio: _value1,
      same_address: _value2,
      anios: _n,
    );
    await ReferenciasTable.db.newReferencia(referencia);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dropDownMenuItemsStates = buildAndGetDropDownMenuItems(_States);
    _selectedTypeStates = _dropDownMenuItemsStates[0].value;
    _dropDownMenuItemsPhones = buildAndGetDropDownMenuItems(_typePhones);
    _selectedTypePhones = _dropDownMenuItemsPhones[0].value;
    _controllerCP = new TextEditingController();
    _controllerCiudad = new TextEditingController();
    _controllerColonia = new TextEditingController();
    _controllerMunicipio = new TextEditingController();
    _controllerNombre = new TextEditingController();
    _controllerApellidoP = new TextEditingController();
    _controllerApellidoM = new TextEditingController();
    _controllerParentesco = new TextEditingController();
    phoneController = new MaskedTextController(mask: '00-0000-0000');
    _controllerCP.addListener(Response);
  }

  void Response() async {
    if (_controllerCP.text.length == 5) {
      await RequestUtil().getResponseFromService(
          'https://www.fiinsoft.mx/Finsoft.WebAPI.Originacion.Test/fiinsoftapi/Asentamientos/GetList',
          {'cp': _controllerCP.text});
      String response = globals.temporalPath;
      var jsonResponse = json.decode(response);
      var jsonDataArray = jsonResponse['Data'];
      var jsonData = jsonDataArray[0];
      String colonia = jsonData['asentamiento'];
      String estado = jsonData['entidad_federativa'];
      String cd = jsonData['ciudad'];
      if (cd == '“”') cd = 'especifique';
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
    void changedDropDownState(String selectedTypeCred) {
      setState(() {
        _selectedTypeStates = selectedTypeCred;
      });
    }

    void changedDropDownItemPhone(String selectedTypeCred) {
      setState(() {
        _selectedTypePhones = selectedTypeCred;
      });
    }

    return WillPopScope(
      onWillPop: () async {
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
              controller: _controllerNombre,
              decoration: const InputDecoration(
                labelText: 'Nombre(s)',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'El nombre es requerido';
                }
              },
            ),
            /*const SizedBox(height: 16.0),*/
            TextFormField(
              controller: _controllerApellidoP,
              decoration: const InputDecoration(
                labelText: 'Apellido paterno',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Apellido paterno requerido';
                }
              },
            ),
            /*const SizedBox(height: 16.0),*/
            TextFormField(
              controller: _controllerApellidoM,
              decoration: const InputDecoration(
                labelText: 'Apellido materno',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Apellido materno requerido';
                }
              },
            ),
            TextFormField(
              controller: _controllerParentesco,
              decoration: const InputDecoration(
                labelText: 'Parentesco',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Parentesco requerido';
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
                  child: new Text('Menos de un año'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text('Años de conocerlo'),
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
                  child: new Text('Misma dirección que el titular'),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: null,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Switch(value: _value2, onChanged: _onChanged2),
                ),
              ],
            ),
            TextFormField(
              maxLength: 5,
              controller: _controllerCP,
              inputFormatters: [new UpperCaseTextFormatter()],
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
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Teléfono requerido';
                } else {
                  strTelefono = value;
                }
              },
            ),
            const SizedBox(height: 16.0),
            Text("Tipo de teléfono"),
            DropdownButton(
              isExpanded: true,
              value: _selectedTypePhones,
              items: _dropDownMenuItemsPhones,
              onChanged: changedDropDownItemPhone,
            ),
            const SizedBox(height: 16.0),
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
      ),
    );
    ;
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      updateUser();
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
}

class ReferenceData extends StatelessWidget {
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
        title: const Text('Referencia'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: ReferencesAddForm(),
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
