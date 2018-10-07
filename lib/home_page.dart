import 'package:flutter/material.dart';
import 'session.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';
import 'new_conversation.dart';
import 'dart:convert';
import 'conversation.dart';

class HomePage extends StatefulWidget {
  HomePage(this.uid);
  final String uid;
  @override
  _Home createState() => new _Home(uid);
}
    

class _Home extends State<HomePage> {
  final String uid;
  _Home(this.uid);
  List chats;

  Session two() => new Session();
  BuildContext scaffoldContext ;
  void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);                                                              
  }
  void loadChats() async{
    var response = await two().getChats();
    setState(() {
      var jsondata = json.decode(response);
      chats = jsondata["data"];
    });
  }
  @override
  void initState() {
    super.initState();
    this.loadChats();
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
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
      body: new Column(
        children: <Widget>[

          new Expanded(
              child:new ListView.builder(
                  itemCount: chats == null ? 0 : chats.length,
                  itemBuilder: (BuildContext context, i) {
                    return new ListTile(
                      title: new Text(chats[i]["uid"] == null ? '' : chats[i]["uid"]),
                      subtitle: new Text(chats[i]["last_timestamp"] == null ? '' : chats[i]["last_timestamp"]),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> Conversation(uid,chats[i]["uid"])));
                      },
                    );}
                    )
          ),
        ],
      ),
    )
    );

                                                                                                                     
}
}