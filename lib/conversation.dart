import 'package:flutter/material.dart';
import 'session.dart';
import 'main.dart';
import 'home_page.dart';
import 'new_conversation.dart';
import 'dart:convert';

class Conversation extends StatefulWidget {
  Conversation(this.uid1,this.uid2);
  final String uid1,uid2;
  @override
  _ConversationState createState() => new _ConversationState(uid1,uid2);
}
    

class _ConversationState extends State<Conversation> {
  final String uid1,uid2;
  _ConversationState(this.uid1,this.uid2);
  List msgs;

  void loadMsgs() async{
    var response = await two().getMsgs(uid2);
    setState(() {
      var jsondata = json.decode(response);
      msgs = jsondata["data"];
    });
  }
  Session two() => new Session();
  BuildContext scaffoldContext ;

  void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);                                                              
  }
  @override
  void initState() {
    super.initState();
    this.loadMsgs();
  }
  @override
  Widget build(BuildContext context) {

  dynamic msgfield =  new TextField(
    decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Type message"
    ),
    controller: new TextEditingController(),
  );
  dynamic sendbutton = new RaisedButton(
      onPressed: (){
       two().sendMsg(uid2,msgfield.controller.text);
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => Conversation(uid1,uid2)),
       );
        },
      color:Colors.lightBlueAccent,
      padding: const EdgeInsets.all(2.0),
      child: new Text(
        "Send",
      )
      );
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: Text(uid2),
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
      body:
        new Column(
          children: <Widget>[
            new Expanded(
                child: new ListView.builder(
                    itemCount: msgs == null ? 0 : msgs.length,
                    itemBuilder: (BuildContext context, i) {
                      return new ListTile(
                        leading: new Text(msgs[i]["uid"] == null ? '' : msgs[i]["uid"]),
                        title: new Text(msgs[i]["text"] == null ? '' : msgs[i]["text"]),
                        subtitle: new Text(msgs[i]["timestamp"] == null ? '' : msgs[i]["timestamp"]),
                        onTap: (){
                          //
                        },
                      );}
                      ),
            ),
            new Row(
              children: <Widget>[
                new Flexible(child: msgfield),
                sendbutton
              ],
            )
          ],
        )
    )
    );

                                                                                                                     
}
}