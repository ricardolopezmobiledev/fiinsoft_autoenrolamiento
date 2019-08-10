import 'dart:async';
import 'package:fiinsoft_autoenrolamiento/Utils/RequestUtil.dart';
import 'package:fiinsoft_autoenrolamiento/Model/db/SessionsTable.dart';


class AuthService {
  
  RequestUtil httpRequest = new RequestUtil();
  // Login
  Future<bool> login() async {
    bool result;
    var sess  = await SessionsTable.db.getAllSessions();
    if(sess.length != 0){
      result = true;
    }
    else{
      result = false;
    }
    return result;
  }



  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(
        new Duration(
            seconds: 1
        )
    );
  }


}