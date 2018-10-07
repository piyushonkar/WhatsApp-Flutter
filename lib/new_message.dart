import 'package:flutter/material.dart';
import 'dart:convert';
import 'session.dart';
import 'dart:async';
import 'home_page.dart';
import 'conversation.dart';
import 'new_conversation.dart';
import 'main.dart';

class NewMessage extends StatefulWidget {
  NewMessage(this.uid1,this.uid2);
  final String uid1,uid2;
  static String tag = 'login-page';
  @override
  _PageState createState() => new _PageState(uid1,uid2);
}
    

class _PageState extends State<NewMessage> {
  Session one() => new Session();
    final String uid1,uid2;
  _PageState(this.uid1,this.uid2);
  BuildContext scaffoldContext ;

  void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);                                                              
  }
  
  @override
  Widget build(BuildContext context) {


    final message = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller : TextEditingController(),
      decoration: InputDecoration(
        hintText: 'Type Message',
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
            if(message.controller.text=="")
            {
                createSnackBar("Message field should not be empty");
            }
            else
            {
              Future<String> response1 =one().post("http://192.168.1.106:8080/Ass8/NewMessage?userid="+uid1+"&other_id="+uid2+"&msg="+message.controller.text,{});
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Conversation(uid1,uid2)),
            );
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Message', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: Text('New Message'),
          actions: <Widget>[
            IconButton(
              icon:new  Icon(Icons.home),
              onPressed: () {
                //Home Button
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(uid1)),
            );
              },
            ),
            IconButton(
              //New Conversation
              icon: new Icon(Icons.open_in_new),
              onPressed: () {
                print("Create New Conversation");
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewConversation(uid1)),
            );
              }
        ),
         IconButton(
           //Logout
              icon: new Icon(Icons.backspace),
              onPressed: () {
                Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
              }) ]
        ),
      body: new Builder(builder:(BuildContext context){
        scaffoldContext=context;
        return new Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            message,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      );
      }),
    )
    );

                                                                                                                     
}
}

