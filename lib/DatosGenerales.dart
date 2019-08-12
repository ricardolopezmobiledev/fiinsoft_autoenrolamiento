import 'package:flutter/material.dart';
import 'package:fiinsoft_autoenrolamiento/Seguimiento.dart';
import 'Model/Objects/Choise.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'Model/Objects/Documento.dart';
import 'Model/Objects/Persona.dart';
import 'Model/Objects/Players.dart';
import 'Model/db/PersonasTable.dart';
import 'Model/db/DocumentosTable.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  Persona persona;

  TextEditingController _controllerNombre;
  TextEditingController _controllerAP;
  TextEditingController _controllerAM;
  TextEditingController _controllerBithdate;
  TextEditingController _controllerPhone;
  TextEditingController _controllerCP;
  TextEditingController _controllerCiudad;
  TextEditingController _controllerMun;
  TextEditingController _controllerEst;
  TextEditingController _controllerCol;
  TextEditingController _controllerNumExt;
  TextEditingController _controllerNumInt;
  TextEditingController _controllerCalle;

  TextEditingController _controllerEmail;
  TextEditingController _controllerCurp;

  Color hombreInside = Colors.blue;
  Color hombreText = Colors.white;

  Color mujerInside = Colors.white;
  Color mujerText = Colors.blue;

  Color viudoInside = Colors.blue;
  Color viudoText = Colors.white;

  Color solteroInside = Colors.white;
  Color solteroText = Colors.blue;

  Color casadoInside = Colors.white;
  Color casadoText = Colors.blue;

  Color divorciadoInside = Colors.white;
  Color divorciadoText = Colors.blue;


  Color trabajoInside = Colors.blue;
  Color trabajoText = Colors.white;

  Color hogarInside = Colors.white;
  Color hogarText = Colors.blue;

  Color desempleadoInside = Colors.white;
  Color desempleadoText = Colors.blue;

  Color negociopropioInside = Colors.white;
  Color negociopropioText = Colors.blue;


  int gendedrVal = 1;
  int civilStateVal = 2;
  int occupationTypeVal = 1;
  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Players>> key = new GlobalKey();

  List<DropdownMenuItem<String>> _dropDownMenuItemsEscolaridad;
  String _selectedEscolaridad;

  /*_AutoCompleteState();*/

  void _loadData() async {
    await PlayersViewModel.loadPlayers();
  }

  List _escolaridades = [
  "Posgrado",
  "Licenciatura",
  "Superior Tecnico",
  "Medio Superior",
  "Secundaria",
  "Primaria",
  "Leer y escribir"
  ];

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
    _dropDownMenuItemsEscolaridad = buildAndGetDropDownMenuItems(_escolaridades);
    _selectedEscolaridad = _dropDownMenuItemsEscolaridad[0].value;
    _loadData();
    _controllerNombre = new TextEditingController();
    _controllerAP = new TextEditingController();
    _controllerAM = new TextEditingController();
    _controllerBithdate = new TextEditingController();
    _controllerPhone = new TextEditingController();
    _controllerCP = new TextEditingController();
    _controllerCiudad = new TextEditingController();
    _controllerMun = new TextEditingController();
    _controllerEst = new TextEditingController();
    _controllerCol= new TextEditingController();
    _controllerCol = new TextEditingController();
    _controllerNumExt = new TextEditingController();
    _controllerNumInt = new TextEditingController();
    _controllerCalle = new TextEditingController();
    _controllerEmail = new TextEditingController();
    _controllerCurp = new TextEditingController();
    getDataFromDB();
  }

  void updateUser() async{
    Persona personaUpdate = persona;


    String gender;
    if(gendedrVal == 1) gender = 'HOMBRE';
    else if(gendedrVal == 2) gender = 'MUJER';

    String occupationType;
    if(occupationTypeVal == 1) occupationType = 'TRABAJO';
    else if(occupationTypeVal == 2) occupationType = 'HOGAR';
    else if(occupationTypeVal == 3) occupationType = 'DESEMPLEO';
    else if(occupationTypeVal == 4) occupationType = 'NEGOCIO PROPIO';

    String civilStatus;
    if(civilStateVal == 1) civilStatus = 'SOLTERO';
    else if(civilStateVal == 2) civilStatus = 'VIUDO';
    else if(civilStateVal == 3) civilStatus = 'CASADO';
    else if(civilStateVal == 4) civilStatus = 'DIVORSIADO';


    personaUpdate.email = _controllerEmail.text;
    personaUpdate.curp = _controllerCurp.text;
    personaUpdate.escolaridad = _selectedEscolaridad;
    personaUpdate.gender = gender;
    personaUpdate.tipo_ocupacion = occupationType;
    personaUpdate.ocupacion = searchTextField.textField.controller.text;
    personaUpdate.estado_civil = civilStatus;
    await PersonaTable.db.updatePersona(personaUpdate);
  }

  void getDataFromDB() async{
    persona = await PersonaTable.db.getPersona(1);
    if(persona.documentos.length != 5){
      Documento compDom = Documento(
          nombre: 'COMPROBANTE DE DOMICILIO',
          id_persona: persona.id,
          status: 'Selected',
          path: ''
      );
      Documento compIngr = Documento(
          nombre: 'COMPROBANTE DE INGRESOS',
          id_persona: persona.id,
          status: 'Selected',
          path: ''
      );
      await DocumentoTable.db.newDocumento(compDom);
      await DocumentoTable.db.newDocumento(compIngr);
    }

    setState(() {
      if(persona.email != null) _controllerEmail.text = persona.email;
      if(persona.curp != null) _controllerCurp.text = persona.curp;
      if(persona.escolaridad != null) _selectedEscolaridad = persona.escolaridad;
      if(persona.ocupacion != null) searchTextField.textField.controller.text = persona.ocupacion;
      if(persona.ocupacion != null) searchTextField.textField.controller.text = persona.ocupacion;
      if(persona.gender != null){
        if(persona.gender == 'HOMBRE') clicbuttonGender(1);
        if(persona.gender == 'MUJER') clicbuttonGender(2);
      }

      if(persona.tipo_ocupacion != null){
        if(persona.tipo_ocupacion == 'TRABAJO') clicbuttonOcupation(1);
        if(persona.tipo_ocupacion == 'HOGAR') clicbuttonOcupation(2);
        if(persona.tipo_ocupacion == 'DESEMPLEO') clicbuttonOcupation(3);
        if(persona.tipo_ocupacion == 'NEGOCIO PROPIO') clicbuttonOcupation(4);
      }

      if(persona.estado_civil != null){
        if(persona.estado_civil == 'SOLTERO') clicbutton(1);
        if(persona.estado_civil == 'VIUDO') clicbutton(2);
        if(persona.estado_civil == 'CASADO') clicbutton(3);
        if(persona.estado_civil == 'DIVORSIADO') clicbutton(4);
      }

      _controllerNombre.text = persona.nombre;
      _controllerAP.text = persona.ap_paterno;
      _controllerAM.text = persona.ap_materno;
      _controllerBithdate.text = persona.fecha_de_nacimiento;
      _controllerPhone.text = persona.phone.numero;
      _controllerCP.text = persona.address.cp;
      _controllerCiudad.text = persona.address.ciudad;
      _controllerMun.text = persona.address.municipio;
      _controllerEst.text = persona.address.estado;
      _controllerCol.text = persona.address.colonia;
      _controllerNumExt.text = persona.address.num_exterior;
      _controllerNumInt.text = persona.address.num_interior;
      _controllerCalle.text = persona.address.calle;
    });
  }

  @override
  Widget build(BuildContext context) {
    void changedDropDownItem(String selectedEscolaridad) {
      setState(() {
        _selectedEscolaridad = selectedEscolaridad;
      });
    }
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
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
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
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller:_controllerAP,
                decoration: const InputDecoration(
                  labelText: 'Apellido paterno',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Apellido paterno requerido';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller:_controllerAM,
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
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Email requerido';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerBithdate,
                decoration: const InputDecoration(
                  labelText: 'Fecha de nacimiento',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Fecha de nacimiento requerida';
                  }
                },
              ),
              TextFormField(
                controller: _controllerCurp,
                decoration: const InputDecoration(
                  labelText: 'CURP',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'CURP requerida';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              new Text("Escolaridad"),
              DropdownButton(
                isExpanded: true,
                value: _selectedEscolaridad,
                items: _dropDownMenuItemsEscolaridad,
                onChanged: changedDropDownItem,
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerPhone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Teléfono Requerido';
                  }
                },
              ),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Text('Sexo'),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140.0,
                    height: 40.0,
                    child: new RaisedButton(
                      textColor: hombreText,
                      color: hombreInside,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        clicbuttonGender(1);
                      },
                      child: const Text('HOMRE', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                      width: 140.0,
                      height: 40.0,
                      child: new RaisedButton(
                        textColor: mujerText,
                        color: mujerInside,
                        onPressed: () {
                          clicbuttonGender(2);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue)),
                        child: const Text('MUJER', style: TextStyle(fontSize: 13)),
                      )),
                ],
              ),
              SizedBox(
                width: 1000.0,
                height: 30.0,
                child: null,
              ),
              Text('Estado Civil'),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140.0,
                    height: 40.0,
                    child: new RaisedButton(
                      textColor: solteroText,
                      color: solteroInside,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        clicbutton(1);
                      },
                      child: const Text('SOLTER@', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                      width: 140.0,
                      height: 40.0,
                      child: new RaisedButton(
                        textColor: viudoText,
                        color: viudoInside,
                        onPressed: () {
                          clicbutton(2);
                        },
                        child: const Text('VIUD@', style: TextStyle(fontSize: 13)),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue)),
                      )),
                ],
              ),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140.0,
                    height: 40.0,
                    child: new RaisedButton(
                      textColor: casadoText,
                      color: casadoInside,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        clicbutton(3);
                      },
                      child: const Text('CASAD@', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                      width: 140.0,
                      height: 40.0,
                      child: new RaisedButton(
                        textColor: divorciadoText,
                        color: divorciadoInside,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {
                          clicbutton(4);
                        },
                        child: const Text('DIVORSIAD@',
                            style: TextStyle(fontSize: 13)),
                      )),
                ],
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerCP,
                decoration: const InputDecoration(
                  labelText: 'Codigo postal',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Codigo postal Requerido';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerCiudad,
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Ciudad Requerida';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerMun,
                decoration: const InputDecoration(
                  labelText: 'Municipio',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Municipio Requerido';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerEst,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Estado Requerido';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerCol,
                decoration: const InputDecoration(
                  labelText: 'Colonia',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Colonia Requerida';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerNumExt,
                decoration: const InputDecoration(
                  labelText: 'Numero Exterior',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Numero exterior';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerNumInt,
                decoration: const InputDecoration(
                  labelText: 'Numero Interior',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Numero interior';
                  }
                },
              ),
              TextFormField(
                focusNode: new AlwaysDisabledFocusNode(),
                style: TextStyle(color: Colors.grey),
                controller: _controllerCalle,
                decoration: const InputDecoration(
                  labelText: 'Calle',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Calle requerida';
                  }
                },
              ),
              SizedBox(
                width: 1000.0,
                height: 30.0,
                child: null,
              ),
              Text('Ocupacion'),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              searchTextField = AutoCompleteTextField<Players>(
                  style: new TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: new InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: 'Buscar ocupación',
                      hintStyle: TextStyle(color: Colors.black)),
                  itemSubmitted: (item) {
                    setState(() => searchTextField.textField.controller.text =
                        item.autocompleteterm);
                  },
                  clearOnSubmit: false,
                  key: key,
                  suggestions: PlayersViewModel.players,
                  itemBuilder: (context, item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.autocompleteterm,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        Text(
                          item.country,
                        )
                      ],
                    );
                  },
                  itemSorter: (a, b) {
                    return a.autocompleteterm.compareTo(b.autocompleteterm);
                  },
                  itemFilter: (item, query) {
                    return item.autocompleteterm
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  }),
              SizedBox(
                width: 1000.0,
                height: 25.0,
                child: null,
              ),
              Text('Tipo ocupacion'),
              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140.0,
                    height: 40.0,
                    child: new RaisedButton(
                      textColor: trabajoText,
                      color: trabajoInside,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        clicbuttonOcupation(1);
                      },
                      child: const Text('TRABAJO', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                      width: 140.0,
                      height: 40.0,
                      child: new RaisedButton(
                        textColor: hogarText,
                        color: hogarInside,
                        onPressed: () {
                          clicbuttonOcupation(2);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue)),
                        child: const Text('HOGAR', style: TextStyle(fontSize: 13)),
                      )),
                ],
              ),

              SizedBox(
                width: 1000.0,
                height: 10.0,
                child: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140.0,
                    height: 40.0,
                    child: new RaisedButton(
                      textColor: desempleadoText,
                      color: desempleadoInside,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        clicbuttonOcupation(3);
                      },
                      child: const Text('DESEMPLEADO', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                      width: 140.0,
                      height: 40.0,
                      child: new RaisedButton(
                        textColor: negociopropioText,
                        color: negociopropioInside,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {clicbuttonOcupation(4);},
                        child: const Text('NEGOCIO PROPIO',
                            style: TextStyle(fontSize: 13)),
                      )),
                ],
              ),
              /*Row(
            children: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue)),
                onPressed: _submittable() ? _submit : null,
                child: const Text('GUARDAR', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),*/
            ],
          ),
        )
    );

  }

  void clicbutton(int button){
    civilStateVal = button;
    setState(() {
      if(button == 1){
        solteroInside = Colors.blue;
        solteroText = Colors.white;
        viudoInside = Colors.white;
        viudoText = Colors.blue;
        casadoInside = Colors.white;
        casadoText = Colors.blue;
        divorciadoInside = Colors.white;
        divorciadoText = Colors.blue;
      }else if(button == 2){
        solteroInside = Colors.white;
        solteroText = Colors.blue;
        viudoInside = Colors.blue;
        viudoText = Colors.white;
        casadoInside = Colors.white;
        casadoText = Colors.blue;
        divorciadoInside = Colors.white;
        divorciadoText = Colors.blue;
      }else if(button == 3){
        solteroInside = Colors.white;
        solteroText = Colors.blue;
        viudoInside = Colors.white;
        viudoText = Colors.blue;
        casadoInside = Colors.blue;
        casadoText = Colors.white;
        divorciadoInside = Colors.white;
        divorciadoText = Colors.blue;
      }else if(button == 4){
        solteroInside = Colors.white;
        solteroText = Colors.blue;
        viudoInside = Colors.white;
        viudoText = Colors.blue;
        casadoInside = Colors.white;
        casadoText = Colors.blue;
        divorciadoInside = Colors.blue;
        divorciadoText = Colors.white;
      }
    });
  }


  void clicbuttonOcupation(int button){
    occupationTypeVal = button;
    setState(() {
      if(button == 1){
        trabajoInside = Colors.blue;
        trabajoText = Colors.white;
        hogarInside = Colors.white;
        hogarText = Colors.blue;
        desempleadoInside = Colors.white;
        desempleadoText = Colors.blue;
        negociopropioInside = Colors.white;
        negociopropioText = Colors.blue;
      }else if(button == 2){
        trabajoInside = Colors.white;
        trabajoText = Colors.blue;
        hogarInside = Colors.blue;
        hogarText = Colors.white;
        desempleadoInside = Colors.white;
        desempleadoText = Colors.blue;
        negociopropioInside = Colors.white;
        negociopropioText = Colors.blue;
      }else if(button == 3){
        trabajoInside = Colors.white;
        trabajoText = Colors.blue;
        hogarInside = Colors.white;
        hogarText = Colors.blue;
        desempleadoInside = Colors.blue;
        desempleadoText = Colors.white;
        negociopropioInside = Colors.white;
        negociopropioText = Colors.blue;
      }else if(button == 4){
        trabajoInside = Colors.white;
        trabajoText = Colors.blue;
        hogarInside = Colors.white;
        hogarText = Colors.blue;
        desempleadoInside = Colors.white;
        desempleadoText = Colors.blue;
        negociopropioInside = Colors.blue;
        negociopropioText = Colors.white;
      }
    });
  }

  void clicbuttonGender(int button){
    gendedrVal = button;
    setState(() {
      if(button == 1){
        hombreInside = Colors.blue;
        hombreText = Colors.white;
        mujerInside = Colors.white;
        mujerText = Colors.blue;
      }else if(button == 2){
        hombreInside = Colors.white;
        hombreText = Colors.blue;
        mujerInside = Colors.blue;
        mujerText = Colors.white;
      }
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

  Row add_radio_button(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.green,
          value: btnValue,
          groupValue: -1,
          onChanged: null,
        ),
        Text(title)
      ],
    );
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
        title: const Text('Datos Generales'),
        leading: IconButton(
          icon: Icon(Icons.looks_one),
          onPressed: () => Navigator.pop(context, false),
        ),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}