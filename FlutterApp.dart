import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());}
var firestoresconnect = FirebaseFirestore.instance;
getData() async{
    var data = await firestoresconnect.collection("<Firebase Collection Name>").get();
    for (var i in data.docs){
      print(i.data());}}
  String command;
  var output;
getLinuxOutput(cmd) async{
  var url = "http://<IP of Webserver>/cgi-bin/<CGI File Name>?y=${cmd}";
  var output = await http.get(url);
  print(output.body);
  await firestoresconnect.collection("Firebase Collection Name").add({
                  command : "${output.body}"});}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Linux Application"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.blue,
              margin: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value){
                  command = value;},
                autocorrect: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Linux Command",
                  prefixIcon: Icon(Icons.code),
                  fillColor: Colors.red,
                  focusColor: Colors.black,),),),
            RaisedButton(
              color: Colors.red,
              child: Text(
                  "Execute",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.bold,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,),),
              onPressed: () {
                getLinuxOutput(command);
                print("Output Sent");}),
              RaisedButton(
                color: Colors.red,
              child: Text(
                  "Show Output",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.bold,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SF Pro",
                    fontSize: 18,),),
              onPressed: () {
                getData();
                print("Command Executed.");})],),),),);}}
