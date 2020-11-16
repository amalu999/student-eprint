import 'menubar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menubar.dart';

class Contribute extends StatefulWidget {
  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{print('could not launch $command');}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,

          title: Text("CONTRIBUTE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

          backgroundColor: Colors.blueGrey[900],

        ),
        drawer: MenuBar(),
        body:Center(
          child: Column(
            children: <Widget>[
              Center(
                child: Card(
                  child: Container(
                      child:Text("Quality Notebooks are most welcomed.\n You can mail the study materials for verification.\nKindly add details in the subject")
                  ),
                ),
              ),
              Center(
                child: Card(
                  child: Container(
                      child:Card(
                        child: Center(
                          child: RaisedButton(
                            child: Text('MAIL'),
                            color: Colors.blueGrey,
                            onPressed:(){
                              customLaunch('mailto:amalususanb@gmail.com');
                            } ,

                          ),
                        ) ,)
                  ),
                ),
              )
            ],
          ),
        )

    );
  }
}