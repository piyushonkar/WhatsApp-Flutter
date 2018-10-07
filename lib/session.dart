/*
 * Based on an answer by Richard Heap on stackoverflow.
 * Original link:
 * https://stackoverflow.com/questions/50299253/flutter-http-maintain-php-session
 */


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Session {
  static final Session _session = new Session._internal();
  static final url = "http://192.168.1.106:8080/Ass8";
  factory Session(){
    return _session;
  }
  Session._internal();

  Map<String, String> headers = {};

  Future<String> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return response.body;
  }

  Future<String> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return response.body;
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<String> login(userid,pw) {
    return this.post(url+"/LoginServlet?userid=" +
        userid + "&password=" + pw, {});
  }

  Future<String> getChats(){
    return this.get(url+"/AllConversations");
  }

  Future<String> getMsgs(uid2){
    return this.get(url+"/ConversationDetail?other_id="+uid2);
  }

  Future<String> getName(uid) async{
     var response = await this.get(url+"/AutoCompleteUser?term="+uid);
     var jsondata = json.decode(response);
      return jsondata[0]["name"];
  }

  Future<String> sendMsg(uid2,text){
    return this.post(url+"/NewMessage?other_id="+uid2+"&msg="+text,{});
  }

}