import 'package:flutter/material.dart';
import 'MainView.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Session.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/SessionsTable.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final forkey = GlobalKey<FormState>();
  String _email, _password, _token, _idUser;

  void _GetLoginAndChangeView() {
    /*print(_email);
    print(_password);*/
    postReq();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/splash.jpg"), fit: BoxFit.cover),
      ),
      child: new Container(
          child: Column(children: <Widget>[
        new Expanded(
          child: new Container(
            child: Row(
              children: [
                new Expanded(
                  child: new Container(
                    child: null,
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Image(
                      image: new AssetImage("assets/logo_splash.png")),
                  flex: 2,
                ),
                new Expanded(
                  child: new Container(
                    child: null,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          flex: 8,
        ),
        new Expanded(
          child: Form(
            key: forkey,
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Usuario"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Usuario vacio';
                        }
                      },
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Card(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "contraseña"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Contraseña vacia';
                        }
                      },
                      onSaved: (input) => _password = input,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: null,
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        if (forkey.currentState.validate()) {
                          forkey.currentState.save();
                          _GetLoginAndChangeView();
                        }
                      },
                      child: const Text('INGRESAR',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Card(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {},
                      child: const Text('CREA TU CUENTA, AFILIATE AQUÍ',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        new Expanded(
          child: new Container(
            child: Column(
              children: [
                new Expanded(
                  child: new Card(
                    child: null,
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 1,
        ),
      ])),
    );
  }

  postReq() async {
    String url =
        'https://www.fiinsoft.mx/Finsoft.WebAPI.Security/fiinsoftapi/Account/GetUsuario';
    Map map = {
      'Usuario': _email,
      'Contrasenia': _password,
      'Aplicacion': 'Originacion'
    };

    print(await apiRequest(url, map));
    getUserData(_token, _idUser);
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    var sfd = json.encode(jsonMap);
    var listok = utf8.encode(sfd);
    request.add(listok);
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    var data = json.decode(reply);
    String token = data['Data'];
    String finalToken = token;
    List<String> splitenToken = token.split('.');
    token = splitenToken[1];
    var bytesInLatin1_decoded = Base64Codec().decode(token);
    var initialValue = Latin1Codec().decode(bytesInLatin1_decoded);
    var jsonResponse = json.decode(initialValue);
    var jsonResponseData = json.decode(jsonResponse['data']);
    var jsonRoles = jsonResponseData['Roles'];
    var usuarioidBase = jsonResponseData['UsuarioId'];
    for (int i = 0; i < jsonRoles.length; i++) {
      if (jsonRoles[i]['NombreRol'] == 'R01 - MOB - Promotor') {
        _idUser = usuarioidBase;
        _token = finalToken;
      }
    }
    print(jsonResponseData);

    httpClient.close();
    return reply;
  }

  void getUserData(String token_str, String idUser) {
    var url =
        "https://www.fiinsoft.mx/Finsoft.WebAPI.Originacion.Test/fiinsoftapi/UsuariosPersonas/Get";
    var client = new http.Client();
    var request = new http.Request('POST', Uri.parse(url));
    var body = {'id_usuario': 'aaaacb0a-b93b-4ed3-bdc5-d9da4185d311'};
//  request.headers[HttpHeaders.CONTENT_TYPE] = 'application/json; charset=utf-8';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token_str';
    request.bodyFields = body;
    var future = client
        .send(request)
        .then((response) => response.stream
            .bytesToString()
            .then((value) => ininSession(token_str,value.toString())))
        .catchError((error) => print(error.toString()));
  }

  void ininSession(String token_str, String response) async {
    var jsonResponse = json.decode(response);
    var data = jsonResponse['Data'];
    var nombre = data['nomPersona'];
    var id_persona = data['id_persona'];
    Session session = Session(
        id_persona: id_persona,
        token: token_str,
        email: _email,
        fullName: nombre,
        isLoggedIn: true);
    await SessionsTable.db.newSession(session);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainView()),
    );
  }
}
