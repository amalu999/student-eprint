import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'menubar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,

          title: Text("LOGOUT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

          backgroundColor: Colors.blueGrey[900],
        ),
        endDrawer: MenuBar(),
        backgroundColor: Colors.grey,
        body: Container(
            child:


            Center(
              child: RaisedButton(
                  child: Text("log out"),
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),);
                  }),
            )
        )


    );
  }
}
