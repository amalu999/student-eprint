import 'menubar.dart';
import 'package:flutter/material.dart';
class FeedBackSend extends StatefulWidget {
  @override
  _FeedBackSendState createState() => _FeedBackSendState();
}

class _FeedBackSendState extends State<FeedBackSend> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,

        title: Text("FEEDBACK",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

    backgroundColor: Colors.blueGrey[900],
      ),
      drawer: MenuBar(),
    );
  }
}
