import 'package:flutter/material.dart';
import 'dart:convert';
import 'session.dart';
import 'dart:async';
import 'home_page.dart';
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}
    

class _LoginPageState extends State<LoginPage> {
  Session one() => new Session();
  BuildContext scaffoldContext ;
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
      ),
    );

    final userid = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller : TextEditingController(),
      decoration: InputDecoration(
        hintText: 'UserID',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller : TextEditingController(),
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
      
    
          onPressed: () {
            if(userid.controller.text=="")
            {
                createSnackBar("User ID field should not be empty");
            }
            else
            {
            Future<String> response1 = one().login(userid.controller.text, password.controller.text);
            response1.then((status) {
              dynamic x=json.decode(status);
            if(x["status"]==true)
            {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(userid.controller.text)),
            );
            }
            else
            {
              createSnackBar("Login Failed");
            }
            });
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: new Builder(builder:(BuildContext context){
        scaffoldContext=context;
        return new Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            userid,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      );
      }),
    );
  }
  void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);                                                              
  }                                                                                                                   
}

