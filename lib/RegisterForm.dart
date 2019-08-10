import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'package:flutter/services.dart';
import 'Model/Objects/Choise.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Persona.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Address.dart';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/AppStatus.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/PersonasTable.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/AppStatusTable.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TextFormatt.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/RequestUtil.dart';
import 'package:fiinsoft_autoenrolamiento/globals.dart' as globals;
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'Model/Objects/Phone.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String strNombre;
  String strAPaterno;
  String strAMaterno;
  String strTelefono;
  String strTipo;
  String strProducto;
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
  TextEditingController _controllerMunicipio;
  TextEditingController phoneController;

  List _typeCredits = [
    "Crédito Individual",
    "Crédito Grupal",
    "Crédito de Vales"
  ];
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

  List<DropdownMenuItem<String>> _dropDownMenuItemsCredit;
  List<DropdownMenuItem<String>> _dropDownMenuItemsPhones;
  List<DropdownMenuItem<String>> _dropDownMenuItemsStates;
  String _selectedTypeCred;
  String _selectedTypePhones;
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

  @override
  void initState() {
    _dropDownMenuItemsCredit = buildAndGetDropDownMenuItems(_typeCredits);
    _selectedTypeCred = _dropDownMenuItemsCredit[0].value;
    _dropDownMenuItemsPhones = buildAndGetDropDownMenuItems(_typePhones);
    _selectedTypePhones = _dropDownMenuItemsPhones[0].value;
    _dropDownMenuItemsStates = buildAndGetDropDownMenuItems(_States);
    _selectedTypeStates = _dropDownMenuItemsStates[0].value;
    _controllerCP = new TextEditingController();
    _controllerCiudad = new TextEditingController();
    _controllerColonia = new TextEditingController();
    _controllerMunicipio = new TextEditingController();
    phoneController = new MaskedTextController(mask: '00-0000-0000');
    _controllerCP.addListener(Response);
    super.initState();

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
    void changedDropDownItem(String selectedTypeCred) {
      setState(() {
        _selectedTypeCred = selectedTypeCred;
      });
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

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Nombre(s)',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'El nombre es requerido';
              } else {
                strNombre = value;
              }
            },
          ),
          /*const SizedBox(height: 16.0),*/
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Apellido paterno',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Apellido paterno requerido';
              } else {
                strAPaterno = value;
              }
            },
          ),
          TextFormField(
            inputFormatters: [
              new UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Apellido materno',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Apellido materno requerido';
              } else {
                strAMaterno = value;
              }
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
          new Text("Tipo de crédito"),
          DropdownButton(
            isExpanded: true,
            value: _selectedTypeCred,
            items: _dropDownMenuItemsCredit,
            onChanged: changedDropDownItem,
          ),
          /*const SizedBox(height: 16.0),*/
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

  void _submit() async {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      Address address = Address(
        cp: strCodigoPostal,
        ciudad: strCiudad,
        municipio: strMunicipio,
        estado: strEstado,
        colonia: strColonia,
        calle: strCalle,
        num_exterior: strNumeroExt,
        num_interior: strNumeroInt,
      );
      Phone phones = Phone(
        numero: phoneController.text,
        id_persona: 1,
        tipo: _selectedTypePhones,
      );

      Persona persona = Persona(
        nombre: strNombre,
        ap_paterno: strAPaterno,
        ap_materno: strAMaterno,
        /*fecha_de_nacimiento: nombre,*/
        /*curp: nombre,
        rfc: nombre,*/
        address: address,
        phone: phones,
      );
      AppStatus appStatus = AppStatus(
        id_status: 1,
        name: "RegistroProspecto",
      );
      await PersonaTable.db.newPersona(persona);
      await AppStatusTable.db.newAppStatus(appStatus);
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

class ContactData extends StatelessWidget {
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
        title: const Text('Solicitud'),
        actions: <Widget>[
          // action button
          /*IconButton(
              icon: Icon(choices[0].icon),
              onPressed: () {
                _select(choices[0]);
              },
            ),
            // action button
            IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                _select(choices[1]);
              },
            ),*/
          // overflow menu
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RegisterForm(),
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
