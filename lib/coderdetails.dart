import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'coderconfirmation.dart';

class CustomRange extends StatefulWidget {
  final subject;
  final nameOfBook;
  final author;
  final  noofpages;

//create constructor
  var url;
  var amount;
  var copies;

  CustomRange({Key key, this.subject, this.nameOfBook, this.author, this.noofpages}) : super(key: key);



  @override
  _CustomRangeState createState() => _CustomRangeState();
}

class _CustomRangeState extends State<CustomRange> {
  bool processing;
  var emailId;
  var resId;
  var name;
  var author;
  var subject;
  var nopages;
  var price;
  var url;
  bool check;

  TextEditingController begctrl,endctrl,copyctrl;
  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    name = sharedPrefs.getString('name_of_book');
    author = sharedPrefs.getString('author');
    subject = sharedPrefs.getString('subject');
    nopages = sharedPrefs.getString('no_of_pages');
    price = sharedPrefs.getString('price');
    url = sharedPrefs.getString('url');
    resId= sharedPrefs.getString('res_id');
    print('user_name: $emailId');
    print('user_name: $resId');
    ;
  }
  void setValues(copies) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // set values
    sharedPrefs.setString('copies', copyctrl.text);
    print('Values Set in Shared Prefs!!');
  }

  void setValues1() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // set values
    sharedPrefs.setString('beg', begctrl.text);
    sharedPrefs.setString('end', endctrl.text);
    print('Values Set in Shared Prefs!!');
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    begctrl = new TextEditingController();
    endctrl = new TextEditingController();
    copyctrl = new TextEditingController();
  }



  void confirmcOrder(subject,nameOfBook,author,beg,end,copies) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmcOrder(subject: subject,nameOfBook: nameOfBook,author: author,beg: beg,end: end,copies: copies,),
    ),);
  }
  noOfCopiesDialog(){
    Widget okButton = FlatButton(
      child: Text("OK"),
      color: Colors.blueGrey,
      onPressed:  () {
        setValues(copyctrl);
        confirmcOrder(widget.subject,widget.nameOfBook,widget.author, int.parse(begctrl.text),
            int.parse(endctrl.text),int.parse(copyctrl.text));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Number of Copies') ,
      content: TextField(
        controller: copyctrl,
        decoration: InputDecoration(
            hintText: "Enter the required number of copies you want"
        ),
        keyboardType: TextInputType.numberWithOptions(),
      ),
      //Text("Enter the required number of copies you want"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
  @override
  void customcOrder(subject,name,author,beg,end,copies){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => noOfCopiesDialog(),
    ),);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        brightness: Brightness.dark,

        title: Text("SPECIFY RANGE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

        backgroundColor: Colors.blueGrey[900],
      ),

      body: Center(
        child: Container(

          width: 300,
          height: 150,
          child: Column(

              children:<Widget>[
                TextField(
                  controller: begctrl,
                  decoration: InputDecoration(
                      hintText: "Starting page number"
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                TextField(
                  controller: endctrl,
                  decoration: InputDecoration(
                      hintText: "Ending page number"
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),

                RaisedButton(
                  onPressed:()
                  {setValues1();
                  noOfCopiesDialog();},

                  child: Text("OK"),
                  color: Colors.blueGrey,
                )
              ]
          ),
        ),
      ),

    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}