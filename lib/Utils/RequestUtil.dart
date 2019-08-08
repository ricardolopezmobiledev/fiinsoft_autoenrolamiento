import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:fiinsoft_autoenrolamiento/Model/Objects/Session.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/SessionsTable.dart';

class RequestUtil{

  /*postReq() async {
    String url =
        'https://www.fiinsoft.mx/Finsoft.WebAPI.Security/fiinsoftapi/Account/GetUsuario';
    Map map = {
      'Usuario': 'sergio@grupogarsa.com','Contrasenia': 'eli05BP!','Aplicacion': 'Originacion'
    };

    print(await apiRequest(url, map));
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
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
    List<String> jsonRolesNames = new List();
    for(int i = 0; i<jsonRoles.length; i++){
      if(jsonRoles[i]['NombreRol'] == 'R01 - MOB - Promotor'){
        Session session = Session(id_persona: 1,token: finalToken, email: 'sergio@grupogarsa.com', fullName: 'SERGIO ELIZONDO', isLoggedIn: true);
        await SessionsTable.db.newSession(session);
      }
    }
    print(jsonResponseData);

    httpClient.close();
    return reply;
  }*/
}
