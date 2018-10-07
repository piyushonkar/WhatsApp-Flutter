import 'package:flutter/material.dart';
import 'session.dart';
import 'main.dart';
import 'home_page.dart';
import 'dart:convert';
import 'dart:async';
import 'conversation.dart';

class NewConversation extends StatefulWidget {
  NewConversation(this.uid);
  final String uid;
  @override
  _NewConversationState createState() => new _NewConversationState(uid);
}
    

class _NewConversationState extends State<NewConversation> {
  final String uid;
  _NewConversationState(this.uid);



  Session two() => new Session();
  BuildContext scaffoldContext ;

  void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);                                                              
  }
  
  @override
  Widget build(BuildContext context) {


    final userid2 = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller : TextEditingController(),
      decoration: InputDecoration(
        hintText: 'UserID',
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
            if(userid2.controller.text=="")
            {
                createSnackBar("User ID field should not be empty");
            }
            else
            {
            Future<String> response1 =two().post("http://192.168.1.106:8080/Ass8/CreateConversation?id="+uid+"&other_id="+userid2.controller.text,{});
            
            response1.then((status) {
              dynamic x=json.decode(status);
            if(x["status"]==true)
            {
                createSnackBar("Added new conversation");
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(uid)),
            );
            }
            else
            {
              print(x["message"]);
              if (x["message"].contains('duplicate'))
              {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Conversation(uid,userid2.controller.text)),
            );
              }
              createSnackBar("Failed to create new conversation");
            }
            });
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Add User', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          actions: <Widget>[
            IconButton(
              icon:new  Icon(Icons.home),
              onPressed: () {
                //Home Button
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(uid)),
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
              MaterialPageRoute(builder: (context) => NewConversation(uid)),
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
            userid2,
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